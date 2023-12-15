import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/rating_report/api/report_data_api.dart';
import 'package:m_skool_flutter/vms/rating_report/controller/rating_report_controller.dart';
import 'package:m_skool_flutter/vms/rating_report/model/report_data_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

var logger = Logger();

class ReportDataScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final RatingReportController controller;
  final List<Map<String, dynamic>> monthListArray;
  final String year;
  // final List<Map<String, dynamic>> sortedMonthListArray;
  final List<int> selectedMonths;

  const ReportDataScreen({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.controller,
    required this.selectedMonths,
    required this.monthListArray,
    required this.year,
    // required this.sortedMonthListArray
  });

  @override
  State<ReportDataScreen> createState() => _ReportDataScreenState();
}

class _ReportDataScreenState extends State<ReportDataScreen> {
  String? employeeName;
  double totalAverage = 0.0;

  _getreport() async {
    logger.d(totalAverage);

    widget.controller.updateisLoadingRatingReportData(true);
    await getReportData(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        mIId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        flag: "monthyearwise",
        year: widget.year,
        monthList: widget.monthListArray,
        controller: widget.controller);
    widget.controller.updateisLoadingRatingReportData(false);

    if (widget.controller.ratingReportData.isNotEmpty) {
      employeeName = widget.controller.ratingReportData.first.empName;
    } else {
      // Handle the case when the list is empty, e.g., set a default value for employeeName.
    }

    for (var data in widget.controller.ratingReportData) {
      int totalSum = 0;
      int monthCount = 0;
      logger.d(monthCount);
      for (int monthIndex in widget.selectedMonths) {
        int? monthValue = getMonthValue(data, monthIndex);
        if (monthValue != null) {
          totalSum += monthValue;
          monthCount++;
        }
      }
      totalAverage += (monthCount > 0 ? totalSum / monthCount : 0);
    }
    totalAverage /= widget.controller.ratingReportData.length;
  }

  @override
  void initState() {
    super.initState();
    _getreport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomAppBar(title: "Consolidated Report Details").getAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Obx(
          () => widget.controller.isLoadingRatingReportData.value
              ? const AnimatedProgressWidget(
                  animationPath: "assets/json/default.json",
                  title: "Loading...",
                  desc:
                      "Please wait while we are loading Consolidated Report Details",
                )
              : widget.controller.ratingReportData.isEmpty
                  ? const AnimatedProgressWidget(
                      animationPath: "assets/json/nodata.json",
                      title: "No Data Found",
                      animatorHeight: 350,
                      desc:
                          "We couldn't find any Rating Report, so we couldn't able to show any Report's",
                    )
                  : Container(
                      margin: const EdgeInsets.only(top: 16.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3, left: 15, right: 15, bottom: 30),
                          child: Column(
                            children: [
                              DataTable(
                                dataTextStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(5, 5, 5, 0.945),
                                  fontWeight: FontWeight.w500,
                                ),
                                dataRowHeight: 60,
                                headingRowHeight: 55,
                                horizontalMargin: 10,
                                columnSpacing: 40,
                                dividerThickness: 1,
                                border: TableBorder.all(
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                headingRowColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor),
                                columns: [
                                  const DataColumn(
                                    label: Text(
                                      "Sl No",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  const DataColumn(
                                    label: Text(
                                      "Employee",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  const DataColumn(
                                    label: Text(
                                      "Overall Average",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  const DataColumn(
                                    label: Text(
                                      "Questions",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  for (int monthIndex in widget.selectedMonths)
                                    DataColumn(
                                      label: Text(
                                        widget.controller.monthList[monthIndex]
                                            .ivrMMonthName!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  const DataColumn(
                                    label: Text(
                                      "Total Average",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                                rows: List.generate(
                                  widget.controller.ratingReportData.length,
                                  (index) {
                                    double showMiddleOfTable = widget.controller
                                            .ratingReportData.length /
                                        2;
                                    if (showMiddleOfTable.toInt().isOdd) {
                                      showMiddleOfTable + .5;
                                    }
                                    var data = widget
                                        .controller.ratingReportData[index];

                                    int totalSum = 0;
                                    int monthCount = 0;
                                    for (int monthIndex
                                        in widget.selectedMonths) {
                                      int? monthValue =
                                          getMonthValue(data, monthIndex);
                                      if (monthValue != null) {
                                        totalSum += monthValue;
                                        monthCount++;
                                      }
                                    }
                                    double averageTotal = monthCount > 0
                                        ? totalSum / monthCount
                                        : 0;

                                    return DataRow(cells: [
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                            index == showMiddleOfTable.toInt()
                                                ? "1"
                                                : ""),
                                      )),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                            index == showMiddleOfTable.toInt()
                                                ? widget
                                                    .controller
                                                    .ratingReportData
                                                    .first
                                                    .empName!
                                                : ""),
                                      )),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          index == showMiddleOfTable.toInt()
                                              ? totalAverage.toStringAsFixed(2)
                                              : "",
                                        ),
                                      )),
                                      DataCell(Text(
                                          data.rATMQERatingQuestions ?? '')),
                                      for (int monthIndex
                                          in widget.selectedMonths)
                                        DataCell(
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              getMonthData(data, monthIndex) ??
                                                  '',
                                            ),
                                          ),
                                        ),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                            averageTotal.toStringAsFixed(2)),
                                      )),
                                    ]);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }

  int? getMonthValue(ReportDataModelValues data, int monthIndex) {
    switch (monthIndex) {
      case 0:
        return data.january;
      case 1:
        return data.february;
      case 2:
        return data.march;
      case 3:
        return data.april;
      case 4:
        return data.may;
      case 5:
        return data.june;
      case 6:
        return data.july;
      case 7:
        return data.august;
      case 8:
        return data.september;
      case 9:
        return data.october;
      case 10:
        return data.november;
      case 11:
        return data.december;
      default:
        return null;
    }
  }

  String? getMonthData(ReportDataModelValues data, int monthIndex) {
    switch (monthIndex) {
      case 0:
        return data.january?.toString();
      case 1:
        return data.february?.toString();
      case 2:
        return data.march?.toString();
      case 3:
        return data.april?.toString();
      case 4:
        return data.may?.toString();
      case 5:
        return data.june?.toString();
      case 6:
        return data.july?.toString();
      case 7:
        return data.august?.toString();
      case 8:
        return data.september?.toString();
      case 9:
        return data.october?.toString();
      case 10:
        return data.november?.toString();
      case 11:
        return data.december?.toString();
      default:
        return '';
    }
  }

  @override
  void dispose() {
    super.dispose();

    widget.controller.ratingReportData.clear();
  }
}
