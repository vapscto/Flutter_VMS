import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/staff_tt/controller/staff_tt_controller.dart';
import 'package:m_skool_flutter/staffs/staff_tt/tabs/staff_daily_tt.dart';
import 'package:m_skool_flutter/staffs/staff_tt/tabs/staff_weekly_tt.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class StaffTTHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String title;
  final String? day;
  const StaffTTHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.title,
      this.day});

  @override
  State<StaffTTHome> createState() => _StaffTTHomeState();
}

class _StaffTTHomeState extends State<StaffTTHome>
    with SingleTickerProviderStateMixin {
  final StaffTTController ttController =
      Get.put<StaffTTController>(StaffTTController());

  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    Get.delete<StaffTTController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const HomeFab(),
      appBar: CustomAppBar(
        title: widget.title,
        // bottom: PreferredSize(
        //   preferredSize: const Size(double.infinity, 50),
        //   child: Container(
        //     color: Theme.of(context).scaffoldBackgroundColor,
        //     child: CustomTabBar(
        //       tabController: tabController!,
        //       tabs: const [
        //         CustomTab(name: "Daily", asset: "assets/svg/calendar.svg"),
        //         CustomTab(name: "Weekly", asset: "assets/svg/calendar.svg"),
        //       ],
        //     ),
        //   ),
        // ),
      ).getAppBar(),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CustomTabBar(
              tabController: tabController!,
              tabs: const [
                CustomTab(name: "Daily", asset: "assets/svg/calendar.svg"),
                CustomTab(name: "Weekly", asset: "assets/svg/calendar.svg"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                StaffDailyTT(
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                  ttController: ttController,
                  day: widget.day,
                ),
                StaffWeeklyTT(
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
