import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/homework_classwork/controller/hw_cw_controller.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/controller/notice_board_controller.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/tabs/new_notice_tab_screen.dart';
import 'package:m_skool_flutter/staffs/notice_board_staff/tabs/view_notice_tab_screen.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class NoticeBoardStaffHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String title;
  const NoticeBoardStaffHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.title});

  @override
  State<NoticeBoardStaffHome> createState() => _NoticeBoardStaffHomeState();
}

class _NoticeBoardStaffHomeState extends State<NoticeBoardStaffHome>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  final NoticeBoardController noticeBoardController =
      Get.put(NoticeBoardController());

  final HwCwController hwCwController = Get.put(HwCwController());
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<NoticeBoardController>();
    Get.delete<HwCwController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const HomeFab(),
      appBar: const CustomAppBar(
        title: "Staff Notice Board",
        // bottom: PreferredSize(
        //   preferredSize: const Size(double.infinity, 50),
        //   child: Container(
        //     // padding: const EdgeInsets.symmetric(horizontal: 12.0),
        //     color: Colors.white,
        //     child: CustomTabBar(
        //       tabs: const [
        //         CustomTab(
        //             name: "New Notice", asset: "assets/svg/file-text.svg"),
        //         CustomTab(name: "View Notice", asset: "assets/svg/eye_svg.svg"),
        //       ],
        //       tabController: tabController!,
        //     ),
        //   ),
        // ),
      ).getAppBar(),
      body: Column(
        children: [
          Container(
            // padding: const EdgeInsets.symmetric(horizontal: 12.0),
            color: Colors.white,
            child: CustomTabBar(
              tabs: const [
                CustomTab(
                    name: "New Notice", asset: "assets/svg/file-text.svg"),
                CustomTab(name: "View Notice", asset: "assets/svg/eye_svg.svg"),
              ],
              tabController: tabController!,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                NewNoticeTabScreen(
                  noticeBoardController: noticeBoardController,
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                  hwCwController: hwCwController,
                ),
                ViewNoticeTabScreen(
                  nbController: noticeBoardController,
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
