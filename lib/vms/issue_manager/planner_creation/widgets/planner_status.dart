import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/controller/planner_creation_controller.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_creation/model/planner_status_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';

class PlannerStatusWidget extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final PlannerCreationController plannerCreationController;
  const PlannerStatusWidget(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.plannerCreationController});

  @override
  State<PlannerStatusWidget> createState() => _PlannerStatusWidgetState();
}

class _PlannerStatusWidgetState extends State<PlannerStatusWidget> {
  List<PlannerStatusModel> statusList = [];
  String fromDate = '';
  String toDate = '';
  String status = '';
  getPlannerStatus() async {
    if (widget.plannerCreationController.plannerStatus.isNotEmpty) {
      for (int index = 0;
          index < widget.plannerCreationController.plannerStatus.length;
          index++) {
        var pl =
            widget.plannerCreationController.plannerStatus.elementAt(index);
        if (widget.plannerCreationController.plannerStatus
                .elementAt(index)
                .iSMTPLId ==
            null) {
          if (pl.iSMTPLApprovalFlg == true || pl.iSMTPLApprovedBy != 0) {
            status = "Approved";
          } else if (pl.iSMTPLApprovalFlg == false ||
              pl.iSMTPLApprovedBy == 0) {
            status = "Pending";
          } else if (pl.iSMTPLApprovalFlg == false ||
              pl.iSMTPLApprovedBy != 0) {
            status = 'Rejected';
          }
          logger.i(status);
        }
        DateTime dt = DateTime.parse(widget
            .plannerCreationController.plannerStatus
            .elementAt(index)
            .iSMTPLStartDate!);
        fromDate = '${dt.day}-${dt.month}-${dt.year}';
        DateTime dt1 = DateTime.parse(widget
            .plannerCreationController.plannerStatus
            .elementAt(index)
            .iSMTPLEndDate!);
        toDate = '${dt1.day}-${dt1.month}-${dt.year}';
        statusList.add(PlannerStatusModel(
            widget.plannerCreationController.plannerStatus
                .elementAt(index)
                .iSMTPLPlannerName!,
            fromDate,
            toDate,
            widget.plannerCreationController.plannerStatus
                .elementAt(index)
                .iSMTPLTotalHrs!,
            (widget.plannerCreationController.plannerStatus
                        .elementAt(index)
                        .iSMTPLApprovalFlg ==
                    true)
                ? 'Approved'
                : (widget.plannerCreationController.plannerStatus
                            .elementAt(index)
                            .iSMTPLApprovedBy !=
                        0)
                    ? 'Rejected'
                    : (widget.plannerCreationController.plannerStatus
                                .elementAt(index)
                                .iSMTPLApprovedBy ==
                            0)
                        ? 'Pending'
                        : '',
            widget.plannerCreationController.plannerStatus
                    .elementAt(index)
                    .approvedby ??
                '',
            widget.plannerCreationController.plannerStatus
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

  String convertDecimalToTime(double decimalHours) {
    int hours = decimalHours.toInt();
    int minutes = ((decimalHours - hours) * 60).toInt();

    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');

    return '$formattedHours:$formattedMinutes Hr';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return ListView(
          children: [
            widget.plannerCreationController.isstatusLoading.value
                ? const Center(
                    child: AnimatedProgressWidget(
                        title: "Getting Planner status",
                        desc: "We are loading Planner status... Please wait ",
                        animationPath: "assets/json/default.json"),
                  )
                : (widget.plannerCreationController.plannerStatus.isNotEmpty)
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
                            dataRowHeight:
                                MediaQuery.of(context).size.height * 0.1,
                            // horizontalMargin: 10,
                            dividerThickness: 1,
                            headingTextStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
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
                                label: Align(
                                    alignment: Alignment.center,
                                    child: Text('Status')),
                              ),
                            ],
                            rows: [
                              ...List.generate(statusList.length, (index) {
                                var i = index + 1;
                                String effort = convertDecimalToTime(
                                    statusList[index].totalEffort);
                                return DataRow(cells: [
                                  DataCell(Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      i.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                                  DataCell(SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Text(statusList[index].planner,
                                        overflow: TextOverflow.clip,
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  )),
                                  DataCell(Text(statusList[index].startDate)),
                                  DataCell(Text(statusList[index].endDate)),
                                  DataCell(Text(effort)),
                                  DataCell(SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.71,
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
                                                          color: (statusList[index]
                                                                      .status ==
                                                                  'Rejected')
                                                              ? Colors.red
                                                              : (statusList[index]
                                                                          .status ==
                                                                      'Pending')
                                                                  ? Theme.of(
                                                                          context)
                                                                      .primaryColor
                                                                  : Colors
                                                                      .green)),
                                              (widget.plannerCreationController
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
                                          (widget.plannerCreationController
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
