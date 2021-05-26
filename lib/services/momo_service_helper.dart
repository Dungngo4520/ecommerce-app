import 'package:fluttertoast/fluttertoast.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:momo_vn/momo_vn.dart';

class MomoServiceHelper {
  late MomoVn _momoPay;
  late PaymentResponse _momoPaymentResult;
  late String _paymentStatus;

  momoInit() {
    _momoPay = MomoVn();
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  void openMomo({
    double? amount,
    String? description,
    String? username,
    String? orderId,
    String? orderLabel,
    double? fee,
    String? extra,
  }) {
    try {
      MomoPaymentInfo options = MomoPaymentInfo(
        partner: 'merchant',
        appScheme: 'momomscv20210426',
        merchantcode: 'MOMOMSCV20210426',
        merchantname: 'EMO Shopping',
        merchantnamelabel: 'EMO Shopping',
        amount: amount ?? 0,
        description: description ?? '',
        username: username ?? '',
        orderId: orderId ?? '',
        orderLabel: orderLabel ?? '',
        fee: fee ?? 0,
        extra: extra ?? '',
        isTestMode: true,
      );
      _momoPay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void _setState() {
    _paymentStatus = 'Đã chuyển thanh toán';
    if (_momoPaymentResult.isSuccess) {
      _paymentStatus += "\nTình trạng: Thành công.";
      _paymentStatus += "\nSố điện thoại: " + _momoPaymentResult.phonenumber;
      _paymentStatus += "\nExtra: " + _momoPaymentResult.extra;
      _paymentStatus += "\nToken: " + _momoPaymentResult.token;
    } else {
      _paymentStatus += "\nTình trạng: Thất bại.";
      _paymentStatus += "\nExtra: " + _momoPaymentResult.extra;
      _paymentStatus += "\nMã lỗi: " + _momoPaymentResult.status.toString();
    }
  }

  void _handlePaymentSuccess(PaymentResponse response) {
    _momoPaymentResult = response;
    _setState();
    Fluttertoast.showToast(msg: "THÀNH CÔNG: " + response.phonenumber, timeInSecForIosWeb: 4);
    print(_paymentStatus);
  }

  void _handlePaymentError(PaymentResponse response) {
    _momoPaymentResult = response;
    _setState();
    Fluttertoast.showToast(msg: "THẤT BẠI: " + response.message.toString(), timeInSecForIosWeb: 4);
    print(_paymentStatus);
  }
}
