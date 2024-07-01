import 'package:flutter/material.dart';
import 'package:food_delivery/Common/Style/text.dart';
import 'package:food_delivery/Screens/Introduction_Screen/screen1.dart';
import 'package:food_delivery/Screens/Introduction_Screen/screen3.dart';
import 'package:food_delivery/Screens/auth_Screen/singup_Screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'screen2.dart';

class OnBorarding_Screen extends StatefulWidget {
  static const String id = "onBoarding_Screen";
  const OnBorarding_Screen({super.key});

  @override
  State<OnBorarding_Screen> createState() => _OnBorarding_ScreenState();
}

class _OnBorarding_ScreenState extends State<OnBorarding_Screen> {
  var controller = PageController();
  bool lastPage = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          onPageChanged: (index) {
            setState(() {
              lastPage = (index == 2);
            });
          },
          controller: controller,
          children: const [
            Screen1(),
            Screen2(),
            Screen3(),
          ],
        ),
        Container(
          alignment: const Alignment(0, 0.84),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //skip
              GestureDetector(
                child: Text(
                  "Skip",
                  style: BoldNameText.boldNameTextFieldStyle().copyWith(
                    decoration: TextDecoration.none,
                  ),
                ), // This removes the underline
                onTap: () {
                  controller.jumpToPage(2);
                },
              ),
              const SizedBox(
                width: 50,
              ),
              //dot animation
              SmoothPageIndicator(controller: controller, count: 3),
              const SizedBox(

                width: 50,
              ),
              //next
              lastPage
                  ? GestureDetector(
                      child: Text(
                        "Done",
                        style: BoldNameText.boldNameTextFieldStyle().copyWith(
                          decoration: TextDecoration.none,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, SingUp_Screen.id);
                      },
                    )
                  : GestureDetector(
                      child: Text(
                        "Next",
                        style: BoldNameText.boldNameTextFieldStyle().copyWith(
                          decoration: TextDecoration.none,
                        ),
                      ),
                      onTap: () {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeIn);
                      },
                    ),
            ],
          ),
        )
      ],
    );
  }
}
