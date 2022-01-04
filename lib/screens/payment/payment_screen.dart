import 'package:ecommerce/screens/payment/component/body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  static final String route = '/payment';
  final int amount;

  const PaymentScreen({Key? key, required this.amount}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<int>.value(value: amount),
        ChangeNotifierProvider<ValueNotifier<int>>.value(value: ValueNotifier<int>(1)),
      ],
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          centerTitle: true,
          title: Text("Payment"),
        ),
        body: Body(),
      ),
    );
  }
}
