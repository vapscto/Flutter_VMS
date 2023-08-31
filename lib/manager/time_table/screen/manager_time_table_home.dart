import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/manager/time_table/controller/time_table_controller.dart';
import 'package:m_skool_flutter/manager/time_table/tabs/manager_daily_tt_tab.dart';
import 'package:m_skool_flutter/manager/time_table/tabs/manager_weekly_tt_tab.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';

class ManagerTimeTableHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const ManagerTimeTableHome({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
    // required this.StaffListTTController,
    //     required this.title,
    //     this.day
  });

  @override
  State<ManagerTimeTableHome> createState() => _ManagerTimeTableHomeState();
}

class _ManagerTimeTableHomeState extends State<ManagerTimeTableHome>
    with SingleTickerProviderStateMixin {
  final ManagerTimeTableController ttController =
      Get.put<ManagerTimeTableController>(ManagerTimeTableController());

  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    Get.delete<ManagerTimeTableController>();
    super.dispose();
  }

  final ManagerTimeTableController controller =
      Get.put(ManagerTimeTableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Staff Time Table"),
      ),
      body: Column(
        children: [

            Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CustomTabBar(
              tabController:tabController!,
              tabs: const [
                CustomTab(
                    name: "Daily",
                    asset: "assets/svg/calendar.svg"),
                CustomTab(
                    name: "Weekly",
                    asset: "assets/svg/calendar.svg"),
              ],
            ),
          ),

         
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                ManagerDailyTimeTable(
                  loginSuccessModel: widget.loginSuccessModel,
                  controller: widget.mskoolController,
                  ttDailyController: controller,
                  // day: widget.day,
                ),
                ManagerWeeklyTimeTable(
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                  controllerTT: controller,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
