import 'package:flutter/material.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/student_birthday/tabs/between_day.dart';
import 'package:m_skool_flutter/staffs/student_birthday/tabs/month_wise.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class StudentBdayHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const StudentBdayHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<StudentBdayHome> createState() => _StudentBdayHomeState();
}

class _StudentBdayHomeState extends State<StudentBdayHome>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const HomeFab(),
      appBar: const CustomAppBar(
        title: "Student Birthday Report",
        // bottom: PreferredSize(
        //   preferredSize: const Size(double.infinity, 50),
        //   child: Container(
        //     // padding: const EdgeInsets.symmetric(horizontal: 12.0),
        //     color: Colors.white,
        //     child: CustomTabBar(
        //       tabs: const [
        //         CustomTab(
        //             name: "Between Days",
        //             asset: "assets/svg/calendar_icon.svg"),
        //         CustomTab(
        //             name: "Month Wise", asset: "assets/svg/calendar_icon.svg"),
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
                    name: "Between Days",
                    asset: "assets/svg/calendar_icon.svg"),
                CustomTab(
                    name: "Month Wise", asset: "assets/svg/calendar_icon.svg"),
              ],
              tabController: tabController!,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                BetweenDays(
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                ),
                MonthWise(
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
