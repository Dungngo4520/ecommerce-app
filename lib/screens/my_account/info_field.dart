import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

class InfoField extends StatelessWidget {
  const InfoField({
    Key? key,
    required this.title,
    required this.isEdit,
  }) : super(key: key);

  final bool isEdit;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: isEdit ? 10 : 5),
      child: Text(
        title,
        style: TextStyle(
          color: cPrimaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
