import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/controller/planner_creation_controller.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/widgets/planner_create.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/widgets/planner_status.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class PlannerCreateHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;

  const PlannerCreateHomeScreen({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<PlannerCreateHomeScreen> createState() =>
      _PlannerCreateHomeScreenState();
}

class _PlannerCreateHomeScreenState extends State<PlannerCreateHomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  PlannerCreationController plannerCreationController =
      Get.put(PlannerCreationController());

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Planner Creation").getAppBar(),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CustomTabBar(
              tabController: tabController!,
              tabs: const [
                CustomTab(name: "Create Planner", asset: "assets/svg/bell.svg"),
                CustomTab(name: "Planner Status", asset: "assets/svg/bell.svg"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                PlannerCreateWidget(
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                  plannerCreationController: plannerCreationController,
                ),
                PlannerStatusWidget(
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                  plannerCreationController: plannerCreationController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
