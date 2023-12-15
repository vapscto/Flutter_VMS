// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/marks_entry/widget/dropdown_label.dart';
import 'package:m_skool_flutter/vms/rating_report/api/month_api.dart';
import 'package:m_skool_flutter/vms/rating_report/api/year_list_api.dart';
import 'package:m_skool_flutter/vms/rating_report/controller/rating_report_controller.dart';
import 'package:m_skool_flutter/vms/rating_report/model/year_list_rating_model.dart';
import 'package:m_skool_flutter/vms/rating_report/screen/report_data_screen.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class RatingReportHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const RatingReportHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<RatingReportHome> createState() => _RatingReportHomeState();
}

class _RatingReportHomeState extends State<RatingReportHome> {
  final RatingReportController ratingReportController =
      Get.put(RatingReportController());

  YearListRatingReportModelValues? selectedAcademicYear;

  String? selectedYear;

  String? year;

  bool validateFields() {
    if (selectedAcademicYear == null) {
      Fluttertoast.showToast(msg: "Select Academic Year");
      return false;
    }

    if (monthListArray.isEmpty) {
      Fluttertoast.showToast(msg: "Select Month");
      return false;
    }

    return true;
  }

  loadYearData() {
    setState(() {
      ratingReportController.selectAll = false;
      ratingReportController.checkList!.clear();
    });

    getYearListRatingReport(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        mIId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        roleFlag: widget.loginSuccessModel.roleforlogin!,
        ivrmRtId: widget.loginSuccessModel.roleTypeId!,
        controller: ratingReportController);
  }

  loadMonthData() {
    monthRatingReport(
        base: baseUrlFromInsCode("issuemanager", widget.mskoolController),
        mIId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        roleFlag: widget.loginSuccessModel.roleforlogin!,
        ivrmRtId: widget.loginSuccessModel.roleTypeId!,
        controller: ratingReportController);
  }

  @override
  void initState() {
    super.initState();
    loadYearData();
  }

  List<Map<String, dynamic>> monthListArray = [];

  report() {
    monthListArray.clear();

    for (int i = 0; i < ratingReportController.checkList!.length; i++) {
      monthListArray.add({
        "createdDate": ratingReportController.monthList
            .elementAt(ratingReportController.checkList![i])
            .createdDate,
        "is_Active": ratingReportController.monthList
            .elementAt(ratingReportController.checkList![i])
            .isActive,
        "ivrM_Month_Id": ratingReportController.monthList
            .elementAt(ratingReportController.checkList![i])
            .ivrMMonthId,
        "ivrM_Month_Max_Days": ratingReportController.monthList
            .elementAt(ratingReportController.checkList![i])
            .ivrMMonthMaxDays,
        "ivrM_Month_Name": ratingReportController.monthList
            .elementAt(ratingReportController.checkList![i])
            .ivrMMonthName,
        "updatedDate": ratingReportController.monthList
            .elementAt(ratingReportController.checkList![i])
            .updatedDate,
      });
    }

    print("prathap${monthListArray.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Rating Report").getAppBar(),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 3, left: 15, right: 15, bottom: 50),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () => Container(
                    margin: const EdgeInsets.only(
                        top: 30, left: 0, right: 0, bottom: 0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          blurRadius: 8,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                    child: DropdownButtonFormField<
                        YearListRatingReportModelValues>(
                      value: selectedAcademicYear,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .merge(const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                                letterSpacing: 0.3)),
                        hintText: ratingReportController.yearList.isNotEmpty
                            ? 'Select Academic Year'
                            : 'No data available',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        isDense: true,
                        label: const CustomDropDownLabel(
                          icon: 'assets/images/clock.png',
                          containerColor: Color.fromRGBO(252, 244, 244, 1),
                          text: 'Select Academic Year',
                          textColor: Color.fromRGBO(245, 32, 32, 1),
                        ),
                      ),
                      icon: const Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 30,
                        ),
                      ),
                      iconSize: 30,
                      items: List.generate(
                          ratingReportController.yearList.length, (index) {
                        return DropdownMenuItem(
                          value: ratingReportController.yearList[index],
                          child: Padding(
                            padding: const EdgeInsets.only(top: 13, left: 5),
                            child: Text(
                              ratingReportController.yearList[index].asmaYYear!,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .merge(const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                      letterSpacing: 0.3)),
                            ),
                          ),
                        );
                      }),
                      onChanged: (selected) {
                        setState(() {
                          selectedAcademicYear = selected;
                          ratingReportController.yearSelectedSeperated =
                              selectedAcademicYear!.asmaYYear!.split('-');
                          selectedYear = ratingReportController
                              .yearSelectedSeperated.first;
                        });
                      },
                    ),
                  ),
                ),
                ratingReportController.yearSelectedSeperated.isEmpty
                    ? const SizedBox()
                    : Container(
                        margin: const EdgeInsets.only(
                            top: 30, left: 0, right: 0, bottom: 0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 8,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField<String>(
                          value: ratingReportController
                              .yearSelectedSeperated.first,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    letterSpacing: 0.3)),
                            hintText: ratingReportController
                                    .yearSelectedSeperated.isNotEmpty
                                ? 'Select Year'
                                : 'No data available',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            isDense: true,
                            label: const CustomDropDownLabel(
                              icon: 'assets/images/clock.png',
                              containerColor: Color.fromRGBO(252, 244, 244, 1),
                              text: 'Select Year',
                              textColor: Color.fromRGBO(245, 32, 32, 1),
                            ),
                          ),
                          icon: const Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 30,
                            ),
                          ),
                          iconSize: 30,
                          items: List.generate(
                              ratingReportController
                                  .yearSelectedSeperated.length, (index) {
                            return DropdownMenuItem(
                              value: ratingReportController
                                  .yearSelectedSeperated[index],
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 13, left: 5),
                                child: Text(
                                  ratingReportController
                                      .yearSelectedSeperated[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.0,
                                          letterSpacing: 0.3)),
                                ),
                              ),
                            );
                          }),
                          onChanged: (selected) {
                            print(selectedYear);
                            setState(() {
                              selectedYear = selected;
                            });
                          },
                        ),
                      ),
                const SizedBox(
                  height: 22,
                ),
                ratingReportController.yearList.isEmpty
                    ? const SizedBox()
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            dataTextStyle: const TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(5, 5, 5, 0.945),
                                fontWeight: FontWeight.w500),
                            dataRowHeight: 60,
                            headingRowHeight: 55,
                            horizontalMargin: 10,
                            columnSpacing: 40,
                            dividerThickness: 1,
                            border: TableBorder.all(
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            headingRowColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            columns: [
                              const DataColumn(
                                  label: Text("Sl No",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800))),
                              DataColumn(
                                label: Checkbox(
                                  shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  activeColor: Colors.indigo,
                                  value: ratingReportController.selectAll,
                                  onChanged: (newValue) {
                                    setState(() {
                                      ratingReportController.selectAll =
                                          newValue!;
                                      ratingReportController.checkList!.clear();
                                      for (var i = 0;
                                          i <
                                              ratingReportController
                                                  .monthList.length;
                                          i++) {
                                        ratingReportController
                                            .checkListBoxs[i] = newValue;
                                        if (newValue) {
                                          ratingReportController.checkList!
                                              .add(i);
                                        }
                                      }
                                    });
                                  },
                                ),
                              ),
                              const DataColumn(
                                  label: Align(
                                alignment: Alignment.center,
                                child: Text("Month",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800)),
                              )),
                            ],
                            rows: List.generate(
                                ratingReportController.monthList.length,
                                (index) {
                              var i = index + 1;
                              return DataRow(cells: [
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: Text('$i'))),
                                DataCell(
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Obx(
                                      () => Checkbox(
                                        checkColor: Colors.indigo,
                                        shape: ContinuousRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        value: ratingReportController
                                            .checkListBoxs[index],
                                        onChanged: (val) {
                                          setState(() {
                                            ratingReportController
                                                .checkListBoxs[index] = val!;
                                            if (val) {
                                              ratingReportController.checkList!
                                                  .add(index);
                                            } else {
                                              ratingReportController.checkList!
                                                  .remove(index);
                                            }
                                            if (ratingReportController
                                                    .monthList.length !=
                                                ratingReportController
                                                    .checkList!.length) {
                                              ratingReportController.selectAll =
                                                  false;
                                            } else {
                                              ratingReportController.selectAll =
                                                  true;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      "${ratingReportController.monthList[index].ivrMMonthName}"),
                                ))
                              ]);
                            }))),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      backgroundColor: const Color.fromARGB(235, 56, 23, 243),
                    ),
                    onPressed: () async {
                      year = selectedYear;
                      report();

                      if (!validateFields()) {
                        return;
                      }

                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ReportDataScreen(
                          loginSuccessModel: widget.loginSuccessModel,
                          mskoolController: widget.mskoolController,
                          controller: ratingReportController,
                          selectedMonths: ratingReportController.checkList!,
                          monthListArray: monthListArray,
                          year: year!,
                        );
                      }));

                      // Get.to(ReportDataScreen(
                      //   loginSuccessModel: widget.loginSuccessModel,
                      //   mskoolController: widget.mskoolController,
                      //   controller: ratingReportController,
                      //   selectedMonths: ratingReportController.checkList!,
                      //   monthListArray: monthListArray,
                      //   year: year!,
                      // ));
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(
                        top: 13.0,
                        bottom: 13,
                        left: 14,
                        right: 14,
                      ),
                      child: Text(
                        "Report",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    ratingReportController.checkList!.clear();
    ratingReportController.yearList.clear();
    ratingReportController.monthList.clear();
    ratingReportController.yearSelectedSeperated.clear();
    ratingReportController.checkList!.clear();
    ratingReportController.checkListBoxs.clear();
    super.dispose();
  }
}
