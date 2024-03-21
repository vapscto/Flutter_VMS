import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnBoardItem3 extends StatelessWidget {
  final String desc;
  const OnBoardItem3({super.key, required this.desc});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/onboard_bg.png"))),
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.12,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Get Update On ",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .merge(const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w400,
                          )),
                      children: [
                        TextSpan(
                          text: "Schedules & Events in Real Time",
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                                const TextStyle(
                                  fontSize: 24.0,
                                  color: Color(0xFFFE7E72),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                        ),
                        TextSpan(
                          text: " from anywhere & at any time",
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                                const TextStyle(
                                  fontSize: 24.0,
                                ),
                              ),
                        )
                      ]),
                ),
                SizedBox(
                  height: Get.height * 0.08,
                ),
                LottieBuilder.asset("assets/json/3.json"),
                const SizedBox(
                  height: 16.0,
                ),
                const SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
