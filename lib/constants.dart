import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

const cPrimaryColor = Color(0xFFFF7643);
const cPrimaryLightColor = Color(0xFFFFECDF);
const cPrimaryGradientColor = LinearGradient(
    colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);
const cSecondaryColor = Color(0xFF979797);
const cTextColor = Color(0xFF757575);

const cAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  color: Colors.black87,
  fontWeight: FontWeight.bold,
  fontSize: getProportionateScreenWidth(28),
);

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(
    vertical: getProportionateScreenWidth(15),
  ),
  enabledBorder: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  border: outlineInputBorder(),
  
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: cTextColor),
  );
}

final RegExp emailRegExp = RegExp(
  r"^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
);
const String cEmailNullError = 'Please enter your email';
const String cEmailInvalidError = 'Please enter your valid email';
const String cPasswordNullError = 'Please enter your password';
const String cPasswordShortError = 'Password is too short';
const String cPasswordMatchError = 'Passwords don\'t match';
const String cNameNullError = 'Please enter your name';
const String cPhoneNumberNullError = 'Please enter your phone number';
const String cAddressNullError = 'Please enter your address';