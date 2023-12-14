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
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

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

    plannerApprovalController.leavePopUp.isNotEmpty
        ? Get.dialog(
            barrierDismissible: false,
            WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "LEAVE APPROVAL DETAILS",
                      // ignore: use_build_context_synchronously
                      style: Theme.of(context).textTheme.titleLarge!.merge(
                          // ignore: use_build_context_synchronously
                          const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w900)),
                    )),
                content: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: DataTable(
                            dataRowHeight: 35,
                            headingRowHeight: 40,
                            columnSpacing: 20,
                            headingTextStyle:
                                const TextStyle(color: Colors.white),
                            border: TableBorder.all(
                              color: Colors.black,
                              width: 0.6,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Theme.of(context).primaryColor),
                            columns: const [
                              DataColumn(label: Text("SL.NO.")),
                              DataColumn(label: Text("Employee Name")),
                              DataColumn(label: Text("Leave Name")),
                              DataColumn(label: Text("From Date")),
                              DataColumn(label: Text("To Date")),
                              DataColumn(label: Text("Total Days")),
                              DataColumn(label: Text("Reason")),
                              // DataColumn(
                              //     label: Text("Planner")),
                            ],
                            rows: List.generate(
                                plannerApprovalController.leavePopUp.length,
                                (index) {
                              var i = index + 1;
                              return DataRow(cells: [
                                DataCell(Text(i.toString())),
                                DataCell(Text(
                                    '${plannerApprovalController.leavePopUp.elementAt(index).hRMEEmployeeFirstName}')),
                                DataCell(Text(
                                    '${plannerApprovalController.leavePopUp.elementAt(index).hRMLLeaveName}')),
                                DataCell(Text(
                                  getDateSelect(DateTime.parse(
                                      plannerApprovalController.leavePopUp
                                          .elementAt(index)
                                          .hRELAPFromDate!)),
                                )),
                                DataCell(Text(
                                  getDateSelect(DateTime.parse(
                                      plannerApprovalController.leavePopUp
                                          .elementAt(index)
                                          .hRELAPToDate!)),
                                )),
                                DataCell(Text(
                                    '${plannerApprovalController.leavePopUp.elementAt(index).hRELAPTotalDays}')),
                                DataCell(Text(
                                    '${plannerApprovalController.leavePopUp.elementAt(index).hRELAPLeaveReason}')),
                              ]);
                            })),
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(
                          // height: 20,
                          ),
                    ),
                    Text(
                        "Kindly update Leave Status, Then only can Approve Planner"),
                    MSkollBtn(
                      title: "Close",
                      onPress: () {
                        Get.back();
                        Get.back();

                        plannerApprovalController.leavePopUp.clear();
                      },
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ))
        : null;
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

  String getDateSelect(DateTime dt) {
    return "${dt.day.toString().padLeft(2, "0")}-${dt.month.toString().padLeft(2, "0")}-${dt.year}";
  }
}
