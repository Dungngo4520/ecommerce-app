import 'package:ecommerce/components/custom_suffix_icon.dart';
import 'package:ecommerce/components/default_button.dart';
import 'package:ecommerce/components/form_error.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/forgot_password/forgot_password_screen.dart';
import 'package:ecommerce/screens/login_success/login_success_screen.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String email, password;
  bool remember = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Row(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: remember,
                    activeColor: cPrimaryColor,
                    onChanged: (value) {
                      setState(() {
                        remember = value;
                      });
                    },
                  ),
                  Text('Remember me'),
                ],
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, ForgotPasswordScreen.route),
                child: Text(
                  'Forget Password',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: 'Continue',
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                Navigator.pushNamed(context, LoginSuccessScreen.route);
              }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      onSaved: (newValue) => email = newValue,
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
        if (value.isEmpty && !errors.contains(cEmailNullError)) {
          setState(() {
            errors.add(cEmailNullError);
          });
          return 'This field must be filled';
        } else if (!emailRegExp.hasMatch(value) &&
            !errors.contains(cEmailInvalidError) &&
            !errors.contains(cEmailNullError)) {
          setState(() {
            errors.add(cEmailInvalidError);
          });
          return cEmailInvalidError;
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'Enter your email',
          suffixIcon: CustomSuffixIcon(svgIcon: 'assets/icons/Mail.svg')),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(cPasswordNullError)) {
          setState(() {
            errors.remove(cPasswordNullError);
          });
        } else if (value.length >= 8 && errors.contains(cPasswordShortError)) {
          setState(() {
            errors.remove(cPasswordShortError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(cPasswordNullError)) {
          setState(() {
            errors.add(cPasswordNullError);
          });
          return 'This field must be filled';
        } else if (value.length < 8 &&
            !errors.contains(cPasswordShortError) &&
            !errors.contains(cPasswordNullError)) {
          setState(() {
            errors.add(cPasswordShortError);
          });
          return cPasswordShortError;
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Enter your password',
          suffixIcon: CustomSuffixIcon(svgIcon: 'assets/icons/Lock.svg')),
    );
  }
}
