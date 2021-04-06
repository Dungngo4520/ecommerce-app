import 'package:ecommerce/components/default_button.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/home/home_screen.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPForm extends StatefulWidget {
  @override
  _OTPFormState createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  final _formKey = GlobalKey<FormState>();
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;

  @override
  void initState() {
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    super.dispose();
  }

  void nextPin({required String value, required FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(1),
                  ],
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24, color: cTextColor),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  obscureText: true,
                  onChanged: (value) {
                    nextPin(value: value, focusNode: pin2FocusNode);
                    
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(1),
                  ],
                  focusNode: pin2FocusNode,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24, color: cTextColor),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  obscureText: true,
                  onChanged: (value) {
                    nextPin(value: value, focusNode: pin3FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(1),
                  ],
                  focusNode: pin3FocusNode,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24, color: cTextColor),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  obscureText: true,
                  onChanged: (value) {
                    nextPin(value: value, focusNode: pin4FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(1),
                  ],
                  focusNode: pin4FocusNode,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24, color: cTextColor),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  obscureText: true,
                  onChanged: (value) {
                    pin4FocusNode.unfocus();
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          DefaultButton(
            text: 'Continue',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pushReplacementNamed(context, HomeScreen.route);
              }
            },
          )
        ],
      ),
    );
  }
}
