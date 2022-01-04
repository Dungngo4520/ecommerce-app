import 'package:ecommerce/components/default_button.dart';
import 'package:ecommerce/models/Cart.dart';
import 'package:ecommerce/models/UserData.dart';
import 'package:ecommerce/screens/order/order_screen.dart';
import 'package:ecommerce/screens/payment/component/payment_method.dart';
import 'package:ecommerce/screens/payment/component/payment_summary.dart';
import 'package:ecommerce/services/database.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:momo_vn/momo_vn.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late MomoVn momo;
  late PaymentResponse momoPaymentResult;
  late String paymentStatus;

  late DatabaseMethods firestore;
  late int amount;
  late ValueNotifier<int> method;
  late UserData userData;
  late List<Cart> cartList;

  @override
  void initState() {
    super.initState();
    momo = MomoVn();
    momo.on(MomoVn.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    momo.on(MomoVn.EVENT_PAYMENT_ERROR, handlePaymentError);
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {});
  }

  void _setState() {
    paymentStatus = 'Đã chuyển thanh toán';
    if (momoPaymentResult.isSuccess!) {
      paymentStatus += "\nTình trạng: Thành công.";
      paymentStatus += "\nSố điện thoại: " + momoPaymentResult.phoneNumber!;
      paymentStatus += "\nExtra: " + momoPaymentResult.extra!;
      paymentStatus += "\nToken: " + momoPaymentResult.token!;
    } else {
      paymentStatus += "\nTình trạng: Thất bại.";
      paymentStatus += "\nExtra: " + momoPaymentResult.extra!;
      paymentStatus += "\nMã lỗi: " + momoPaymentResult.status.toString();
    }
  }

  void handlePaymentSuccess(PaymentResponse response) {
    momoPaymentResult = response;
    _setState();
    Fluttertoast.showToast(msg: "THÀNH CÔNG", timeInSecForIosWeb: 4);
    print(paymentStatus);
    createOrderOnPaymentSuccess();
  }

  void createOrderOnPaymentSuccess() async {
    String orderId = await firestore.createOrder(
      cartList: cartList,
      receiverName: userData.name,
      receiverPhone: userData.phone,
      receiverAddress: userData.address,
      paymentMethod: 'Momo',
      amount: amount,
      discount: 0,
    );
    firestore.clearCart();
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OrderScreen(orderId: orderId),
      ),
    );
  }

  void handlePaymentError(PaymentResponse response) {
    momoPaymentResult = response;
    _setState();
    Fluttertoast.showToast(msg: "THẤT BẠI: " + response.message.toString(), timeInSecForIosWeb: 4);
    print(paymentStatus);
  }

  void openMomo({
    int? amount,
    String? description,
    String? username,
    String? orderId,
    String? orderLabel,
    int? fee,
    String? extra,
  }) {
    try {
      MomoPaymentInfo options = MomoPaymentInfo(
        partner: 'merchant',
        partnerCode: 'MOMOMSCV20210426',
        appScheme: 'momomscv20210426',
        merchantCode: 'MOMOMSCV20210426',
        merchantName: 'EMO Shopping',
        merchantNameLabel: 'EMO Shopping',
        amount: amount ?? 0,
        description: description ?? '',
        username: username ?? '',
        orderId: orderId ?? '',
        orderLabel: orderLabel ?? '',
        fee: fee ?? 0,
        extra: extra ?? '',
        isTestMode: true,
      );
      momo.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    firestore = Provider.of<DatabaseMethods>(context);
    amount = Provider.of<int>(context);
    method = Provider.of<ValueNotifier<int>>(context);
    userData = Provider.of<UserData>(context);
    cartList = Provider.of<List<Cart>>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaymentSummary(),
        SizedBox(height: getProportionateScreenHeight(30)),
        PaymentMethod(),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(30),
              vertical: getProportionateScreenWidth(30)),
          child: DefaultButton(
            text: 'Place Order',
            onPressed: () async {
              if (userData.address != "" && userData.phone != "" && userData.name != "") {
                if (method.value == 1) {
                  openMomo(
                    amount: amount,
                    description: "Thanh toán đơn hàng",
                    username: userData.email,
                    orderId: randomAlpha(20),
                    orderLabel: "Thanh toán đơn hàng",
                    extra: "",
                    fee: 0,
                  );
                } else {
                  String orderId = await firestore.createOrder(
                    receiverAddress: userData.address,
                    receiverName: userData.name,
                    receiverPhone: userData.phone,
                    cartList: cartList,
                    paymentMethod: 'Direct',
                    amount: amount,
                    discount: 0,
                  );
                  firestore.clearCart();
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderScreen(orderId: orderId),
                    ),
                  );
                }
              } else
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please update your information before continue'),
                  ),
                );
            },
          ),
        )
      ],
    );
  }
}
