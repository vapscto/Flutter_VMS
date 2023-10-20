import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/api/planner_status_api.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/controller/planner_creation_controller.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/planner_status_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';

class PlannerStatusWidget extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const PlannerStatusWidget(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<PlannerStatusWidget> createState() => _PlannerStatusWidgetState();
}

class _PlannerStatusWidgetState extends State<PlannerStatusWidget> {
  List<PlannerStatusModel> statusList = [];
  PlannerCreationController plannerCreationController =
      Get.put(PlannerCreationController());

  String fromDate = '';
  String toDate = '';
  String status = '';
  getPlannerStatus() async {
    plannerCreationController.statusLoading(true);
    await PlannerStatusList.instance.plannerStatusAPI(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        plannerCreationController: plannerCreationController);
    plannerCreationController.statusLoading(false);
    if (plannerCreationController.plannerStatus.isNotEmpty) {
      for (int index = 0;
          index < plannerCreationController.plannerStatus.length;
          index++) {
        var pl = plannerCreationController.plannerStatus.elementAt(index);
        if (plannerCreationController.plannerStatus.elementAt(index).iSMTPLId ==
            null) {
          if (pl.iSMTPLApprovalFlg == true) {
            status = "Approved";
          } else {
            status = "Pending";
          }
        } else {
          if (pl.iSMTPLApprovalFlg == false) {
            status = "Rejected";
          } else {
            status = "Approved";
          }
        }
        DateTime dt = DateTime.parse(plannerCreationController.plannerStatus
            .elementAt(index)
            .iSMTPLStartDate!);
        fromDate = '${dt.day}-${dt.month}-${dt.year}';
        DateTime dt1 = DateTime.parse(plannerCreationController.plannerStatus
            .elementAt(index)
            .iSMTPLEndDate!);
        toDate = '${dt1.day}-${dt1.month}-${dt.year}';
        statusList.add(PlannerStatusModel(
            plannerCreationController.plannerStatus
                .elementAt(index)
                .iSMTPLPlannerName!,
            fromDate,
            toDate,
            '${plannerCreationController.plannerStatus.elementAt(index).iSMTPLTotalHrs} Hr',
            status,
            // (plannerCreationController.plannerStatus
            //                 .elementAt(index)
            //                 .iSMTPLApprovalFlg ==
            //             true &&
            //         plannerCreationController.plannerStatus.isNotEmpty)
            //     ? 'Approved'
            //     : (plannerCreationController.plannerStatus
            //                 .elementAt(index)
            //                 .iSMTPLApprovalFlg ==
            //             false)
            //         ? 'Rejected'
            //         : 'Pending',
            plannerCreationController.plannerStatus
                    .elementAt(index)
                    .approvedby ??
                '',
            plannerCreationController.plannerStatus
                    .elementAt(index)
                    .iSMTPLAPRemarks ??
                ''));
      }
    }
  }

  @override
  void initState() {
    setState(() {
      getPlannerStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return ListView(
          children: [
            plannerCreationController.isstatusLoading.value
                ? const Center(
                    child: AnimatedProgressWidget(
                        title: "Getting Planner status",
                        desc: "We are loading Planner status... Please wait ",
                        animationPath: "assets/json/default.json"),
                  )
                : (plannerCreationController.plannerStatus.isNotEmpty)
                    ? SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: DataTable(
                            headingRowColor: MaterialStatePropertyAll(
                                Theme.of(context).primaryColor),
                            dataTextStyle: const TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(0, 0, 0, 0.95),
                                fontWeight: FontWeight.w400),
                            // dataRowHeight:
                            //     MediaQuery.of(context).size.height * 0.1,

                            // headingRowHeight: MediaQuery.of(context).size.height * 0.08,
                            horizontalMargin: 2,
                            columnSpacing:
                                MediaQuery.of(context).size.width * 0.04,
                            dividerThickness: 1,
                            headingTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                            border: TableBorder.all(
                                borderRadius: BorderRadius.circular(10),
                                width: 0.5),
                            columns: const [
                              DataColumn(
                                label: Text('S.No'),
                              ),
                              DataColumn(
                                label: Text("Planner"),
                              ),
                              DataColumn(
                                label: Text('Start Date'),
                              ),
                              DataColumn(
                                label: Text('End Date'),
                              ),
                              DataColumn(
                                label: Text('Total Effort'),
                              ),
                              DataColumn(
                                label: Text('Status'),
                              ),
                            ],
                            rows: [
                              ...List.generate(statusList.length, (index) {
                                var i = index + 1;
                                return DataRow(cells: [
                                  DataCell(Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      i.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                                  DataCell(Text(statusList[index].planner,
                                      style: Get.textTheme.titleSmall!.copyWith(
                                          color:
                                              Theme.of(context).primaryColor))),
                                  DataCell(Text(statusList[index].startDate)),
                                  DataCell(Text(statusList[index].endDate)),
                                  DataCell(Text(statusList[index].totalEffort)),
                                  DataCell(SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(statusList[index].status,
                                                  style: Get
                                                      .textTheme.titleMedium!
                                                      .copyWith(
                                                          color: (statusList[
                                                                          index]
                                                                      .status ==
                                                                  'Rejected')
                                                              ? Colors.red
                                                              : (statusList[index]
                                                                          .status ==
                                                                      'Pending')
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .green)),
                                              (plannerCreationController
                                                          .plannerStatus
                                                          .elementAt(index)
                                                          .approvedby !=
                                                      null)
                                                  ? Text(
                                                      ' By- ${statusList[index].assignedBy}',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: Get
                                                          .textTheme.titleSmall)
                                                  : const SizedBox(),
                                            ],
                                          ),
                                          (plannerCreationController
                                                      .plannerStatus
                                                      .elementAt(index)
                                                      .iSMTPLAPRemarks !=
                                                  null)
                                              ? Text(
                                                  'Remarks: ${statusList[index].remarks}',
                                                  // maxLines: 1,
                                                  overflow: TextOverflow.clip,
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  )),
                                ]);
                              }),
                            ],
                          ),
                        ),
                      )
                    : const Center(
                        child: AnimatedProgressWidget(
                            title: "Planners not Found",
                            desc: " ",
                            animationPath: "assets/json/nodata.json")),
          ],
        );
      }),
    );
  }
}
