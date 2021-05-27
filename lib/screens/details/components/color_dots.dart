import 'package:ecommerce/components/rounded_icon_button.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/Product.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ColorDots extends StatefulWidget {
  const ColorDots({
    Key? key,
    required this.product,
    required this.amount,
  }) : super(key: key);

  final Product product;
  final amount;

  @override
  _ColorDotsState createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  TextEditingController productAmount = TextEditingController();
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> currentAmount = Provider.of<ValueNotifier<int>>(context);
    ValueNotifier<Color> currentColor = Provider.of<ValueNotifier<Color>>(context);
    productAmount.text = currentAmount.value.toString();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          ...List.generate(
            widget.product.colors.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
                currentColor.value = widget.product.colors[selectedColor];
              },
              child: Container(
                margin: EdgeInsets.only(right: 2),
                padding: EdgeInsets.all(8),
                height: getProportionateScreenWidth(40),
                width: getProportionateScreenWidth(40),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: index == selectedColor ? cPrimaryColor : Colors.transparent),
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: widget.product.colors[index],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          RoundedIconButton(
            iconData: Icons.remove,
            onTap: () {
              if (currentAmount.value > 0) {
                productAmount.text = (--currentAmount.value).toString();
              }
            },
          ),
          SizedBox(width: getProportionateScreenWidth(10)),
          SizedBox(
            width: getProportionateScreenWidth(35),
            height: getProportionateScreenWidth(35),
            child: TextFormField(
              controller: productAmount,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 16, color: cTextColor),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenWidth(5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: cPrimaryColor),
                ),
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onTap: () {
                productAmount.selection =
                    TextSelection(baseOffset: 0, extentOffset: productAmount.text.length);
              },
              onChanged: (value) {
                currentAmount.value = value.contains('-') ? 0 : int.parse(value);
              },
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(10)),
          RoundedIconButton(
            iconData: Icons.add,
            onTap: () {
              productAmount.text = (++currentAmount.value).toString();
            },
          ),
        ],
      ),
    );
  }
}
