import 'package:ecommerce/components/default_button.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:ecommerce/screens/splash/components/splash_content.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      'text': 'Welcome to EMO, Let\'s shop!',
      'image': 'assets/images/splash_1.png'
    },
    {
      'text': 'Connect with store around Vietnam in 1 click',
      'image': 'assets/images/splash_2.png'
    },
    {
      'text': 'We show the easy way to shop.\n Just stay at home with us',
      'image': 'assets/images/splash_3.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]['image'],
                  text: splashData[index]['text'],
                ),
                onPageChanged: (value) => {
                  setState(() {
                    currentPage = value;
                  })
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: [
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        )
                      ],
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: 'Continue',
                      onPressed: () {
                        Navigator.pushNamed(context, SignInScreen.route);
                      },
                    ),
                    Spacer(flex: 2),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      width: currentPage == index ? 20 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: currentPage == index ? cPrimaryColor : cSecondaryColor,
        borderRadius: BorderRadius.circular(3),
      ),
      duration: cAnimationDuration,
    );
  }
}
