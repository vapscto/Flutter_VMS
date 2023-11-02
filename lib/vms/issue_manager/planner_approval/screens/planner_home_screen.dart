import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_tab_bar.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/api/planner_list_api.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/controller/planner_approval_controller.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/screens/approved_status.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/screens/planner_approval_home.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class PlannerApprovalTabScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;

  const PlannerApprovalTabScreen({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<PlannerApprovalTabScreen> createState() =>
      _PlannerApprovalTabScreenState();
}

class _PlannerApprovalTabScreenState extends State<PlannerApprovalTabScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  PlannerApprovalController plannerApprovalController =
      Get.put(PlannerApprovalController());
  _getPlannerData() async {
    plannerApprovalController.plannerLoading(true);
    await PlannerListAPI.instance.plannerListAPI(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        plannerApprovalController: plannerApprovalController,
        userId: widget.loginSuccessModel.userId!,
        miId: widget.loginSuccessModel.mIID!,
        roleId: widget.loginSuccessModel.roleId!);
    plannerApprovalController.plannerLoading(false);
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    _getPlannerData();
    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    plannerApprovalController.plannerListModel.clear();
    plannerApprovalController.newplannerList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Planner Approval").getAppBar(),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CustomTabBar(
              tabController: tabController!,
              tabs: const [
                CustomTab(
                    name: "Planner Approve", asset: "assets/svg/bell.svg"),
                CustomTab(name: "Planner Status", asset: "assets/svg/bell.svg"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                PlannerApprovalHomeScreen(
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                  title: '',
                  plannerApprovalController: plannerApprovalController,
                ),
                PlannerApprovedStatusWidget(
                  loginSuccessModel: widget.loginSuccessModel,
                  mskoolController: widget.mskoolController,
                  plannerApprovalController: plannerApprovalController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
