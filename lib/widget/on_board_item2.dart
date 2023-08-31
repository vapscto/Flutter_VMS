import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnBoardItem2 extends StatelessWidget {
  final String lottieAnim;
  // final String title;
  final String desc;
  const OnBoardItem2(
      {super.key,
      required this.lottieAnim,
      //required this.title,
      required this.desc});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // decoration: const BoxDecoration(
      //     image: DecorationImage(image: AssetImage("assets/images/bg_st.png"))),
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
                        text: "Easy Information Access to",
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                        children: [
                          TextSpan(
                            text: ' Data, Reports, Access Domain ',
                            style:
                                Theme.of(context).textTheme.titleSmall!.merge(
                                      const TextStyle(
                                          fontSize: 24.0,
                                          color: Color(0xFFFF6F67),
                                          fontWeight: FontWeight.w600),
                                    ),
                          ),
                          TextSpan(
                            text: "Specific modules",
                            style:
                                Theme.of(context).textTheme.titleSmall!.merge(
                                      const TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                          )
                        ])),
                // Text(
                //   "Easy Information Access to data , reports, access domain specific modules",
                //   style: Theme.of(context)
                //       .textTheme
                //       .titleSmall!
                //       .merge(const TextStyle(fontSize: 24.0)),
                //   textAlign: TextAlign.center,
                // ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                LottieBuilder.asset("assets/json/2.json"),
                const SizedBox(
                  height: 16.0,
                ),
                // Text(
                //   title,
                //   textAlign: TextAlign.center,
                //   style: Theme.of(context).textTheme.titleSmall!.merge(
                //         const TextStyle(
                //             fontWeight: FontWeight.w600, fontSize: 24.0),
                //       ),
                // ),
                const SizedBox(
                  height: 8.0,
                ),
                // Text(
                //   desc,
                //   style: Theme.of(context).textTheme.titleSmall,
                //   textAlign: TextAlign.center,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
