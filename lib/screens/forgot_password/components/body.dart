import 'package:ecommerce/components/custom_suffix_icon.dart';
import 'package:ecommerce/components/default_button.dart';
import 'package:ecommerce/components/form_error.dart';
import 'package:ecommerce/screens/sign_in/components/no_account_text.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenHeight(12),
          ),
          child: Column(
            children: [
              Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Please enter your email and we will\n send you a link to return to your account',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                ),
                textAlign: TextAlign.center,
              ),
              ForgotPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          TextFormField(
            onSaved: (newValue) => email = newValue!,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(cEmailNullError)) {
                setState(() {
                  errors.remove(cEmailNullError);
                });
              } else if (emailRegExp.hasMatch(value) &&
                  errors.contains(cEmailInvalidError)) {
                setState(() {
                  errors.remove(cEmailInvalidError);
                });
              }
              return null;
            },
            validator: (value) {
              if (value!.isEmpty && !errors.contains(cEmailNullError)) {
                setState(() {
                  errors.add(cEmailNullError);
                });
              } else if (!emailRegExp.hasMatch(value) &&
                  !errors.contains(cEmailInvalidError) &&
                  !errors.contains(cEmailNullError)) {
                setState(() {
                  errors.add(cEmailInvalidError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                suffixIcon: CustomSuffixIcon(svgIcon: 'assets/icons/Mail.svg')),
          ),
          FormError(errors: errors),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          DefaultButton(
            text: 'Continue',
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          NoAccountText(),
        ],
      ),
    );
  }
}
