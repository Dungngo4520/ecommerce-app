import 'package:ecommerce/components/custom_suffix_icon.dart';
import 'package:ecommerce/components/default_button.dart';
import 'package:ecommerce/components/form_error.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/otp/opt_screen.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class CompleteProfileForm extends StatefulWidget {
  final List<String> userEmailAndPassword;

  const CompleteProfileForm({Key key, @required this.userEmailAndPassword})
      : super(key: key);

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String firstName, lastName, phoneNumber, address;

  addError({String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  removeError({String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userEmailAndPassword);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(10)),
          DefaultButton(
            text: "Continue",
            onPressed: () {
              if (_formKey.currentState.validate()) {
                AuthMethods().createUserWithUserData(context, [
                  ...widget.userEmailAndPassword,
                  firstName,
                  lastName,
                  phoneNumber,
                  address,
                ]);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: cAddressNullError);
        }
        address = value;
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: cAddressNullError);
          return "This field must be filled";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: 'Address',
          hintText: 'Enter your address',
          suffixIcon:
              CustomSuffixIcon(svgIcon: 'assets/icons/Location point.svg')),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: cPhoneNumberNullError);
        }
        phoneNumber = value;
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: cPhoneNumberNullError);
          return "This field must be filled";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: 'Phone number',
          hintText: 'Enter your phone number',
          suffixIcon: CustomSuffixIcon(svgIcon: 'assets/icons/Phone.svg')),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: cNameNullError);
        }
        lastName = value;
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: cNameNullError);
          return "This field must be filled";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: 'Last Name',
          hintText: 'Enter your last name',
          suffixIcon: CustomSuffixIcon(svgIcon: 'assets/icons/User.svg')),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: cNameNullError);
        }
        firstName = value;
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: cNameNullError);
          return "This field must be filled";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: 'First Name',
          hintText: 'Enter your first name',
          suffixIcon: CustomSuffixIcon(svgIcon: 'assets/icons/User.svg')),
    );
  }
}
