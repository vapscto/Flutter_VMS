import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_deviation/api/deviation_api.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_deviation/controller/deviation_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class DeviationDetails extends StatefulWidget {
  final DateTime fDt;
  final DateTime toDt;
  final DeviationController controller;
  final MskoolController mskoolController;
  const DeviationDetails(
      {super.key,
      required this.fDt,
      required this.toDt,
      required this.controller,
      required this.mskoolController});

  @override
  State<DeviationDetails> createState() => _DeviationDetailsState();
}

class _DeviationDetailsState extends State<DeviationDetails> {
  _onLoad() async {
    widget.controller.deviation(true);
    await DeviationAPI.i.reportDetails(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        body: {
          "startdate": widget.fDt.toIso8601String(),
          "enddate": widget.toDt.toIso8601String(),
          "arrayuserEmp": widget.controller.addedEmpList
        },
        controller: widget.controller);
    widget.controller.deviation(false);
  }

  @override
  void initState() {
    _onLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Deviation Details").getAppBar(),
        body:
            // Obx(() {
            //   return widget.controller.isDeviation.value
            //       ? const Center(
            //           child: AnimatedProgressWidget(
            //           animationPath: 'assets/json/default.json',
            //           title: 'Loading',
            //           desc: "Please wait we are loading data",
            //         ))
            //       : ListView(
            //           padding: const EdgeInsets.all(16),
            //         );
            // }),
            FutureBuilder(
                future: DeviationAPI.i.reportDetails(
                    base: baseUrlFromInsCode(
                        "issuemanager", widget.mskoolController),
                    body: {
                      "startdate": widget.fDt.toIso8601String(),
                      "enddate": widget.toDt.toIso8601String(),
                      "arrayuserEmp": widget.controller.addedEmpList
                    },
                    controller: widget.controller),
                builder: (context, snapSort) {
                  if (snapSort.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: AnimatedProgressWidget(
                      animationPath: 'assets/json/default.json',
                      title: 'Loading',
                      desc: "Please wait we are loading data",
                    ));
                  } else if (snapSort.hasError) {
                    return Center(child: Text('Error: ${snapSort.error}'));
                  } else {
                    var processedData = widget.controller
                        .processDeviationReport(
                            widget.controller.deviationDetails);
                    return ListView.builder(
                      itemCount: processedData.length,
                      itemBuilder: (context, index) {
                        var employee = processedData[index];
                        return Card(
                          margin: const EdgeInsets.all(6),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: Colors.grey.shade300, width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                      'DEVIATION REPORT: ${dateFormat1(DateTime.parse(widget.controller.startDate))} - ${dateFormat1(DateTime.parse(widget.controller.endDate))}',
                                      style: Get.textTheme.titleSmall!.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Theme.of(context).primaryColor)),
                                ),
                                const SizedBox(height: 6),
                                Text('Employee: ${employee.employeename ?? ''}',
                                    style: Get.textTheme.titleSmall!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                const SizedBox(height: 6),
                                Text(
                                    'Average Deviation: ${employee.percentage ?? ''}',
                                    style: Get.textTheme.titleSmall!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                const SizedBox(height: 12),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: DataTable(
                                      headingRowColor: MaterialStatePropertyAll(
                                          Theme.of(context).primaryColor),
                                      dataTextStyle: const TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(0, 0, 0, 0.95),
                                        fontWeight: FontWeight.w400,
                                      ),
                                      dataRowHeight: 45,
                                      headingRowHeight: 45,
                                      columnSpacing: 10,
                                      dividerThickness: 1,
                                      headingTextStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      border: TableBorder.all(
                                        borderRadius: BorderRadius.circular(10),
                                        width: 0.5,
                                      ),
                                      columns: const [
                                        // DataColumn(label: Text('SL.No.')),

                                        DataColumn(label: Text('Planner')),
                                        DataColumn(label: Text('Start Date')),
                                        DataColumn(label: Text('End Date')),
                                        DataColumn(label: Text('Total Effort')),
                                        DataColumn(
                                            label: Text('Completed Effort')),
                                        DataColumn(
                                            label:
                                                Text('Completed Percentage')),
                                        DataColumn(label: Text('Deviation')),
                                      ],
                                      rows:
                                          employee.plannerdetails.map((detail) {
                                        return DataRow(cells: [
                                          // DataCell(Text((employee.plannerdetails
                                          //             .indexOf(detail) +
                                          //         1)
                                          //     .toString())),

                                          DataCell(Text(
                                              detail.iSMTPLPlannerName ?? '')),
                                          DataCell(Text(dateFormat1(
                                              DateTime.parse(
                                                  detail.iSMTPLStartDate!)))),
                                          DataCell(Text(dateFormat1(
                                              DateTime.parse(
                                                  detail.iSMTPLEndDate!)))),
                                          DataCell(
                                              Text(detail.totalEffort ?? '')),
                                          DataCell(Text(
                                              detail.completedEffort ?? '')),
                                          DataCell(Text(
                                              '${detail.completedPercentage?.toStringAsFixed(2) ?? ''} %')),
                                          DataCell(Text(
                                            detail.deviationPercentage
                                                    ?.toStringAsFixed(2) ??
                                                '',
                                            style: const TextStyle(
                                                color: Colors.red),
                                          )),
                                        ]);
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }));
  }
}
