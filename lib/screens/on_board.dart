import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/screens/institutional_login.dart';
import 'package:m_skool_flutter/widget/on_board_item.dart';
import 'package:m_skool_flutter/widget/on_board_item2.dart';
import 'package:m_skool_flutter/widget/on_board_item3.dart';

class OnBoardScreen extends StatefulWidget {
  final MskoolController mskoolController;
  const OnBoardScreen({super.key, required this.mskoolController});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  List<Map<String, dynamic>> onBoardItem = [
    {
      "anim": "assets/json/1.json",
      // "title": "Manage everthing at a single place with ",
      "desc":
          "Manage everthing at a single place with a simplified and comprehensive system"
    },
    {
      "anim": "assets/json/2.json",
      "title": "Easy Information Access",
      "desc":
          "Easy Information Access to data , reports, access domain specific modules",
    },
    {
      "anim": "assets/json/3.json",
      "title": "Get Updates On the Go",
      "desc":
          "Get updates on schedules and events in real time from anywhere, at any time",
    }
  ];

  final PageController controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: (i) {
                currentPage = i;
                setState(() {});
              },
              children: const [
                OnBoardItem(lottieAnim: "lottieAnim", desc: "desc"),
                OnBoardItem2(lottieAnim: "lottieAnim", desc: "desc"),
                OnBoardItem3(desc: "desc"),
              ],
            ),
            // child: PageView.builder(
            //   controller: controller,
            //   onPageChanged: (i) {
            //     currentPage = i;
            //     setState(() {});
            //   },
            //   itemBuilder: (_, index) {
            //     return OnBoardItem(
            //         lottieAnim: onBoardItem.elementAt(index)['anim'],
            //         //title: onBoardItem.elementAt(index)['title'],
            //         desc: onBoardItem.elementAt(index)['desc']);
            //   },
            //   itemCount: 3,
            // ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                3,
                (index) => Container(
                      margin: const EdgeInsets.only(right: 3.0),
                      child: Icon(
                        Icons.circle,
                        size: 12.0,
                        color: currentPage == index
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade300,
                      ),
                    )),
          ),
          SizedBox(
            height: Get.height * 0.08,
          )
        ],
      ),
      bottomNavigationBar: currentPage == 2
          ? Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              //height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return InstitutionalLogin(
                        mskoolController: widget.mskoolController);
                  }));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36.0),
                    )),
                label: SvgPicture.asset('assets/svg/next.svg'),
                icon: const Text("Get Started"),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        controller.animateToPage(2,
                            duration: const Duration(seconds: 2),
                            curve: Curves.fastOutSlowIn);
                      },
                      child: Text(
                        "Skip",
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                            TextStyle(color: Theme.of(context).primaryColor)),
                      )),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (currentPage >= 3) {
                        return;
                      }
                      currentPage += 1;
                      controller.animateToPage(currentPage,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.fastOutSlowIn);
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        )),
                    label: SvgPicture.asset('assets/svg/next.svg'),
                    icon: Text(
                      "Next",
                      style: Theme.of(context).textTheme.titleSmall!.merge(
                            const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
