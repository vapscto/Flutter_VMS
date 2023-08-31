import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/controller/tab_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/certificates/screens/apply_now.dart';
import 'package:m_skool_flutter/student/certificates/screens/view_details.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';
import 'package:video_player/video_player.dart';

class CertificateHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const CertificateHomeScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<CertificateHomeScreen> createState() => _CertificateHomeScreenState();
}

class _CertificateHomeScreenState extends State<CertificateHomeScreen>
    with TickerProviderStateMixin {
  TabController? tabController;
  final TabStateController tabStateController =
      Get.put<TabStateController>(TabStateController());

  final List<Widget> tabsChildren = [];

  final PageController pageViewController = PageController();
  VideoPlayerController? controller;

  @override
  void initState() {
    controller = VideoPlayerController.asset(
      'assets/video/certification.mp4',
    );
    tabsChildren.addAll([
      ApplyNow(
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController,
        controller: controller!,
      ),
      ViewDetails(
        loginSuccessModel: widget.loginSuccessModel,
        mskoolController: widget.mskoolController,
      ),
    ]);

    tabController = TabController(length: 2, vsync: this);
    tabController!.addListener(() {
      tabStateController.updateSelectedIndex(tabController!.index);
      pageViewController.animateToPage(
        tabController!.index,
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.fastOutSlowIn,
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    pageViewController.dispose();

    Get.delete<TabStateController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const HomeFab(),
      appBar: const CustomAppBar(title: "Certificate").getAppBar(),
      body: Column(
        children: [
          CustomTabBar(
            tabs: const [
              CustomTab(
                name: "Apply",
                asset: "assets/svg/file-text.svg",
              ),
              CustomTab(
                name: "View Details",
                asset: "assets/svg/eye_svg.svg",
              )
            ],
            tabController: tabController!,
          ),
          const SizedBox(
            height: 12.0,
          ),
          Expanded(
            child: SizedBox(
              height: Get.height,
              child: PageView.builder(
                controller: pageViewController,
                itemCount: tabsChildren.length,
                itemBuilder: (_, index) {
                  return tabsChildren.elementAt(index);
                },
                onPageChanged: (index) {
                  tabController!.animateTo(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
