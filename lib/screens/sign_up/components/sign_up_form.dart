import 'package:ecommerce/components/custom_suffix_icon.dart';
import 'package:ecommerce/components/default_button.dart';
import 'package:ecommerce/components/form_error.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/complete_profile/comple_profile_screen.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String email = "", password = "", confirmPassword = "";
  List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildConfirmPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          DefaultButton(
            text: 'Register',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pushReplacementNamed(
                    context, CompleteProfileScreen.route,
                    arguments: [email, password]);
              }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
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
        email = value;
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(cEmailNullError)) {
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
      initialValue: "",
      onSaved: (newValue) => password = newValue!,
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
        password = value;
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(cPasswordNullError)) {
          setState(() {
            errors.add(cPasswordNullError);
          });
          return "This field must be filled";
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

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      initialValue: "",
      onSaved: (newValue) => confirmPassword = newValue!,
      onChanged: (value) {
        if (password == confirmPassword) {
          setState(() {
            errors.remove(cPasswordMatchError);
          });
        }
        confirmPassword = value;
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "This field must be filled";
        } else if (password != value && !errors.contains(cPasswordMatchError)) {
          setState(() {
            errors.add(cPasswordMatchError);
          });
          return cPasswordMatchError;
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Confirm Password',
          hintText: 'Retype your password',
          suffixIcon: CustomSuffixIcon(svgIcon: 'assets/icons/Lock.svg')),
    );
  }
}
