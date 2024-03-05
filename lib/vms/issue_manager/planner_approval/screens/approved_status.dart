import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/controller/planner_approval_controller.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_approval/widgets/approved_planner_status.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';

class PlannerApprovedStatusWidget extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final PlannerApprovalController plannerApprovalController;
  const PlannerApprovedStatusWidget(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.plannerApprovalController});

  @override
  State<PlannerApprovedStatusWidget> createState() =>
      _PlannerApprovedStatusWidgetState();
}

class _PlannerApprovedStatusWidgetState
    extends State<PlannerApprovedStatusWidget> {
  List<PlannerApprovedStatusModel> statusList = [];

  String fromDate = '';
  String toDate = '';
  String status = '';
  String convertDecimalToTime(double decimalHours) {
    int hours = decimalHours.toInt();
    double decimalMinutes = (decimalHours - hours) * 60;
    int minutes = decimalMinutes.toInt();

    return '$hours. $minutes Hr';
  }

  getplannerStatusModel() async {
    if (widget.plannerApprovalController.plannerStatusModel.isNotEmpty) {
      for (int index = 0;
          index < widget.plannerApprovalController.plannerStatusModel.length;
          index++) {
        var pl = widget.plannerApprovalController.plannerStatusModel
            .elementAt(index);
        if (widget.plannerApprovalController.plannerStatusModel
                .elementAt(index)
                .iSMTPLId ==
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
        DateTime dt = DateTime.parse(widget
            .plannerApprovalController.plannerStatusModel
            .elementAt(index)
            .iSMTPLStartDate!);
        fromDate = '${dt.day}-${dt.month}-${dt.year}';
        DateTime dt1 = DateTime.parse(widget
            .plannerApprovalController.plannerStatusModel
            .elementAt(index)
            .iSMTPLEndDate!);
        toDate = '${dt1.day}-${dt1.month}-${dt.year}';
        statusList.add(PlannerApprovedStatusModel(
            widget.plannerApprovalController.plannerStatusModel
                .elementAt(index)
                .iSMTPLPlannerName!,
            fromDate,
            toDate,
            convertDecimalToTime(widget
                .plannerApprovalController.plannerStatusModel
                .elementAt(index)
                .iSMTPLTotalHrs!),
            // '${widget.plannerApprovalController.plannerStatusModel.elementAt(index).iSMTPLTotalHrs} Hr',
            status,
            widget.plannerApprovalController.plannerStatusModel
                    .elementAt(index)
                    .approvedby ??
                '',
            widget.plannerApprovalController.plannerStatusModel
                    .elementAt(index)
                    .iSMTPLAPRemarks ??
                ''));
      }
    }
  }

  @override
  void initState() {
    setState(() {
      getplannerStatusModel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return ListView(
          children: [
            widget.plannerApprovalController.isPlannerStatusLoading.value
                ? const Center(
                    child: AnimatedProgressWidget(
                        title: "Getting Planner status",
                        desc: "We are loading Planner status... Please wait ",
                        animationPath: "assets/json/default.json"),
                  )
                : (widget.plannerApprovalController.plannerStatusModel
                        .isNotEmpty)
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
                            horizontalMargin: 2,
                            columnSpacing:
                                MediaQuery.of(context).size.width * 0.04,
                            dividerThickness: 1,
                            dataRowHeight: 70,
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
                                  DataCell(SizedBox(
                                    width: 150,
                                    child: Text(statusList[index].planner,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  )),
                                  DataCell(Text(statusList[index].startDate)),
                                  DataCell(Text(statusList[index].endDate)),
                                  DataCell(Text(statusList[index].totalEffort)),
                                  DataCell(SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.72,
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
                                              (widget.plannerApprovalController
                                                          .plannerStatusModel
                                                          .elementAt(index)
                                                          .approvedby !=
                                                      null)
                                                  ? Text(
                                                      ' By- ${statusList[index].assignedBy.trim()}',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              fontSize: 13))
                                                  : const SizedBox(),
                                            ],
                                          ),
                                          (widget.plannerApprovalController
                                                      .plannerStatusModel
                                                      .elementAt(index)
                                                      .iSMTPLAPRemarks !=
                                                  null)
                                              ? Text(
                                                  'Remarks: ${statusList[index].remarks}',
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
