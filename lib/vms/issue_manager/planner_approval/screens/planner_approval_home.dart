import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/api/planner_list_api.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/controller/planner_approval_controller.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/screens/all_planner_screen.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/widgets/dr_not_submit.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class PlannerApprovalHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String title;
  final PlannerApprovalController plannerApprovalController;
  const PlannerApprovalHomeScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.title,
      required this.plannerApprovalController});

  @override
  State<PlannerApprovalHomeScreen> createState() =>
      _PlannerApprovalHomeScreenState();
}

class _PlannerApprovalHomeScreenState extends State<PlannerApprovalHomeScreen> {
  @override
  void initState() {
    // getPlannerData();
    super.initState();
  }

  @override
  void dispose() {
    widget.plannerApprovalController.leavePopUp.clear();
    widget.plannerApprovalController.plannerListModel.clear();
    super.dispose();
  }

  PlannerApprovalController plannerApprovalController =
      Get.put(PlannerApprovalController());
  getPlannerData() async {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return ListView(
          padding: const EdgeInsetsDirectional.symmetric(
              vertical: 16, horizontal: 10),
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CustomContainer(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Planner Approval",
                      style: Get.textTheme.titleMedium!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   "Red Font Name:- ",
                        //   style: Get.textTheme.titleSmall!
                        //       .copyWith(color: Colors.red),
                        // ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.57,
                          child: Text(
                            "Daily Report Approval Pending",
                            style: Get.textTheme.titleSmall!.copyWith(
                                color: const Color.fromARGB(255, 255, 106, 95)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  (widget.plannerApprovalController.isPlannerLoading.value)
                      ? const Center(
                          child: AnimatedProgressWidget(
                              title: "Getting Planner List",
                              desc:
                                  "We are loading Planner List... Please wait ",
                              animationPath: "assets/json/default.json"),
                        )
                      : Column(
                          children: [
                            (widget.plannerApprovalController.newplannerList
                                    .isEmpty)
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      padding:
                                          const EdgeInsetsDirectional.symmetric(
                                              horizontal: 8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: DataTable(
                                            dataRowHeight: 35,
                                            headingRowHeight: 40,
                                            columnSpacing: 20,
                                            headingTextStyle: const TextStyle(
                                                color: Colors.white),
                                            border: TableBorder.all(
                                              color: Colors.black,
                                              width: 0.6,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            headingRowColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) =>
                                                        Theme.of(context)
                                                            .primaryColor),
                                            columns: const [
                                              DataColumn(label: Text("SL.NO.")),
                                              DataColumn(label: Text("Name")),
                                              DataColumn(
                                                  label: Text("Start Date")),
                                              DataColumn(
                                                  label: Text("End Date")),
                                              DataColumn(
                                                  label: Text("Total Effort")),
                                              // DataColumn(
                                              //     label: Text("Planner")),
                                            ],
                                            rows: List.generate(
                                                widget
                                                    .plannerApprovalController
                                                    .newplannerList
                                                    .length, (index) {
                                              var i = index + 1;
                                              return DataRow(cells: [
                                                DataCell(Text(i.toString())),
                                                DataCell(Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      onTap: widget
                                                                  .plannerApprovalController
                                                                  .newplannerList
                                                                  .elementAt(
                                                                      index)['day'] !=
                                                              0
                                                          ? () {
                                                              Get.dialog(
                                                                  DrNotSubmitWidget(
                                                                name: widget
                                                                    .plannerApprovalController
                                                                    .newplannerList
                                                                    .elementAt(
                                                                        index)['name'],
                                                                loginSuccessModel:
                                                                    widget
                                                                        .loginSuccessModel,
                                                                mskoolController:
                                                                    widget
                                                                        .mskoolController,
                                                                plannerApprovalController:
                                                                    widget
                                                                        .plannerApprovalController,
                                                              ));
                                                            }
                                                          : () {},
                                                      child: Text(
                                                        widget
                                                            .plannerApprovalController
                                                            .newplannerList
                                                            .elementAt(
                                                                index)['name'],
                                                        style: Get.textTheme.titleSmall!.copyWith(
                                                            color: (widget.plannerApprovalController
                                                                            .newplannerList
                                                                            .elementAt(index)[
                                                                        'day'] ==
                                                                    0)
                                                                ? Theme.of(
                                                                        context)
                                                                    .primaryColor
                                                                : Colors.red),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    (widget.plannerApprovalController
                                                                    .newplannerList
                                                                    .elementAt(
                                                                        index)[
                                                                'day'] !=
                                                            0)
                                                        ? Text(
                                                            '(${widget.plannerApprovalController.newplannerList.elementAt(index)['day']})',
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                )),
                                                DataCell(Text(widget
                                                    .plannerApprovalController
                                                    .newplannerList
                                                    .elementAt(
                                                        index)['startDate'])),
                                                DataCell(Text(widget
                                                    .plannerApprovalController
                                                    .newplannerList
                                                    .elementAt(
                                                        index)['endDate'])),
                                                DataCell(Text(
                                                    '${widget.plannerApprovalController.newplannerList.elementAt(index)['totalEffort']} Hr')),
                                                // DataCell(InkWell(
                                                //   onTap: () {},
                                                //   child: Row(
                                                //     crossAxisAlignment:
                                                //         CrossAxisAlignment
                                                //             .center,
                                                //     children: [
                                                //       const Icon(
                                                //         Icons
                                                //             .arrow_right_alt_outlined,
                                                //         color: Colors.green,
                                                //       ),
                                                //       Text(
                                                //         widget.plannerApprovalController
                                                //                 .newplannerList
                                                //                 .elementAt(
                                                //                     index)[
                                                //             'plannerView'],
                                                //         style: Get.textTheme
                                                //             .titleSmall!
                                                //             .copyWith(
                                                //                 color: Colors
                                                //                     .green),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // )),
                                              ]);
                                            })),
                                      ),
                                    ),
                                  ),
                            (widget.plannerApprovalController.plannerListModel
                                    .isEmpty)
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      padding:
                                          const EdgeInsetsDirectional.symmetric(
                                              horizontal: 8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: DataTable(
                                            dataRowHeight: 35,
                                            headingRowHeight: 40,
                                            columnSpacing: 20,
                                            headingTextStyle: const TextStyle(
                                                color: Colors.white),
                                            dataTextStyle:
                                                Get.textTheme.titleSmall,
                                            border: TableBorder.all(
                                              color: Colors.black,
                                              width: 0.6,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            headingRowColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) =>
                                                        Theme.of(context)
                                                            .primaryColor),
                                            columns: const [
                                              DataColumn(label: Text("SL.NO.")),
                                              DataColumn(label: Text("Name")),
                                              DataColumn(
                                                  label: Text("Start Date")),
                                              DataColumn(
                                                  label: Text("End Date")),
                                              DataColumn(
                                                  label: Text("Total Effort")),
                                              DataColumn(
                                                  label: Text("Planner")),
                                            ],
                                            rows: List.generate(
                                                widget
                                                    .plannerApprovalController
                                                    .plannerListModel
                                                    .length, (index) {
                                              var i = index + 1;
                                              return DataRow(cells: [
                                                DataCell(Text(i.toString())),
                                                DataCell(Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      widget
                                                          .plannerApprovalController
                                                          .plannerListModel
                                                          .elementAt(
                                                              index)['name'],
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                    ),
                                                  ],
                                                )),
                                                DataCell(Text(widget
                                                    .plannerApprovalController
                                                    .plannerListModel
                                                    .elementAt(
                                                        index)['startDate'])),
                                                DataCell(Text(widget
                                                    .plannerApprovalController
                                                    .plannerListModel
                                                    .elementAt(
                                                        index)['endDate'])),
                                                DataCell(Text(
                                                    '${widget.plannerApprovalController.plannerListModel.elementAt(index)['totalEffort']} Hr')),
                                                DataCell(InkWell(
                                                  onTap: () {
                                                    Get.to(() => AllPlanners(
                                                          loginSuccessModel: widget
                                                              .loginSuccessModel,
                                                          mskoolController: widget
                                                              .mskoolController,
                                                          plannerApprovalController:
                                                              widget
                                                                  .plannerApprovalController,
                                                          ismtplId: widget
                                                              .plannerApprovalController
                                                              .plannerListModel
                                                              .elementAt(
                                                                  index)['ismtplId'],
                                                          createdBy: widget
                                                              .plannerApprovalController
                                                              .plannerListModel
                                                              .elementAt(
                                                                  index)['name'],
                                                          fromDate: widget
                                                              .plannerApprovalController
                                                              .plannerListModel
                                                              .elementAt(
                                                                  index)['startDate'],
                                                          toDate: widget
                                                              .plannerApprovalController
                                                              .plannerListModel
                                                              .elementAt(
                                                                  index)['endDate'],
                                                          plannedEffort: widget
                                                                  .plannerApprovalController
                                                                  .plannerListModel
                                                                  .elementAt(
                                                                      index)[
                                                              'totalEffort'],
                                                          hrmId: widget
                                                                  .plannerApprovalController
                                                                  .plannerListModel
                                                                  .elementAt(
                                                                      index)['hrmeId'] ??
                                                              0,
                                                          hrmdId: widget
                                                              .plannerApprovalController
                                                              .plannerListModel
                                                              .elementAt(
                                                                  index)['hrmdId'],
                                                        ));
                                                  },
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .arrow_right_alt_outlined,
                                                        color: Colors.green,
                                                      ),
                                                      Text(
                                                        widget.plannerApprovalController
                                                                .plannerListModel
                                                                .elementAt(
                                                                    index)[
                                                            'plannerView'],
                                                        style: Get.textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                                color: Colors
                                                                    .green),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                              ]);
                                            })),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                ],
              )),
            ),
            const SizedBox(height: 8),
          ],
        );
      }),
    );
  }

  String getDateSelect(DateTime dt) {
    return "${dt.day.toString().padLeft(2, "0")}-${dt.month.toString().padLeft(2, "0")}-${dt.year}";
  }
}
