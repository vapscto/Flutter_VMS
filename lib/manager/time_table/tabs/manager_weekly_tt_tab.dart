import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/manager/time_table/api/get_manager_weekly_tt_api.dart';
import 'package:m_skool_flutter/manager/time_table/api/get_staff_list_api.dart';
import 'package:m_skool_flutter/manager/time_table/controller/time_table_controller.dart';
import 'package:m_skool_flutter/manager/time_table/model/manager_time_table_stafflist_model.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';

class ManagerWeeklyTimeTable extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final ManagerTimeTableController controllerTT;
  const ManagerWeeklyTimeTable(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.controllerTT});

  @override
  State<ManagerWeeklyTimeTable> createState() => _ManagerWeeklyTimeTableState();
}

class _ManagerWeeklyTimeTableState extends State<ManagerWeeklyTimeTable> {
  final ManagerTimeTableController controller =
      Get.put(ManagerTimeTableController());

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    await GetStaffListInitialDataApi.instance.getStaffList(
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        controller: controller);

    await GetManagerWeeklyTTApi.instance.getWeeklyTTApi(
        miId: widget.loginSuccessModel.mIID!,
        asmaYId: widget.loginSuccessModel.asmaYId!,
        hrmEId: widget.controllerTT.selectedStaffList!.hrmEId!,
        base: baseUrlFromInsCode("portal", widget.mskoolController),
        controller: controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(() {
              return CustomContainer(
                child: DropdownButtonFormField<ManagerTimeTableStaffListValues>(
                  value: controller.selectedStaffList,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        top: 16.0, bottom: 16.0, left: 16, right: 4.4),
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
                    label: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 5),
                      decoration: BoxDecoration(
                          color: const Color(0xFFDFFBFE),
                          borderRadius: BorderRadius.circular(24.0)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/images/cap.png",
                            height: 28.0,
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Text(
                            "Employee",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .merge(const TextStyle(
                                    fontSize: 20, color: Color(0xFF28B6C8))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 30,
                    ),
                  ),
                  iconSize: 30,
                  // value: controller.selectedStaffList!.firstName,
                  items: List.generate(
                    controller.staffList.length,
                    (index) =>
                        DropdownMenuItem<ManagerTimeTableStaffListValues>(
                      value: controller.staffList.elementAt(index),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 12.0, left: 8, right: 8),
                        child: Text(
                          "${controller.staffList.elementAt(index).firstName ?? ''}${controller.staffList.elementAt(index).middleName ?? ''}${controller.staffList.elementAt(index).lastName ?? ''}",
                          style: Theme.of(context).textTheme.labelSmall!.merge(
                              const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  letterSpacing: 0.3)),
                        ),
                      ),
                    ),
                  ),
                  onChanged: (b) async {
                    controller.selectedStaffList = b;

                    await GetManagerWeeklyTTApi.instance.getWeeklyTTApi(
                        miId: widget.loginSuccessModel.mIID!,
                        asmaYId: widget.loginSuccessModel.asmaYId!,
                        hrmEId: controller.selectedStaffList!.hrmEId!,
                        base: baseUrlFromInsCode(
                            "portal", widget.mskoolController),
                        controller: controller);
                  },
                ),
              );
            }),
            Obx(() {
              return widget
                      .controllerTT.isErrorOccuredWhileLoadingWeeklyTT.value
                  ? ErrWidget(
                      err: {
                        "errorTitle": "An Unexpected Error Occured",
                        "errorMsg": widget.controllerTT
                            .isErrorOccuredWhileLoadingWeeklyTT.value
                      },
                    )
                  : widget.controllerTT.isLoadingWeeklyTT.value
                      ? const AnimatedProgressWidget(
                          title: "Loading Timetable",
                          desc:
                              "Don't Worry, your classes wont't miss, We will provide you timetable",
                          animationPath: "assets/json/default.json",
                        )
                      : widget.controllerTT.weeklyTT == null ||
                              widget.controllerTT.weeklyTT!.tt.isEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.1,
                                ),
                                const AnimatedProgressWidget(
                                  title: "No Timetable Found",
                                  desc: "We couldn't find any timetable",
                                  animationPath: "assets/json/nodata.json",
                                  animatorHeight: 250,
                                ),
                              ],
                            )
                          : CustomContainer(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        bottomLeft: Radius.circular(8.0)),
                                    child: DataTable(
                                        headingRowColor:
                                            MaterialStateColor.resolveWith(
                                          (states) =>
                                              Theme.of(context).primaryColor,
                                        ),
                                        columnSpacing: 20,
                                        border: TableBorder(
                                            verticalInside: BorderSide(
                                                color: Colors.grey.shade500,
                                                width: 0.4)),
                                        columns: const [
                                          DataColumn(
                                            label: Text(
                                              "Days",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                        rows: List.generate(
                                            widget.controllerTT.weeklyTT!
                                                .periods.values!.length,
                                            (index) => DataRow(
                                                    color: MaterialStateColor
                                                        .resolveWith(
                                                      (states) =>
                                                          timetablePeriodColor
                                                              .elementAt(index),
                                                    ),
                                                    cells: [
                                                      DataCell(Text(
                                                        "P${widget.controllerTT.weeklyTT!.periods.values!.elementAt(index).ttmPPeriodName}",
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ))
                                                    ]))),
                                  ),
                                  const VerticalDivider(
                                    thickness: 0.4,
                                    width: 0.4,
                                  ),
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0)),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                          headingRowColor:
                                              MaterialStateColor.resolveWith(
                                            (states) =>
                                                Theme.of(context).primaryColor,
                                          ),
                                          border: TableBorder(
                                              verticalInside: BorderSide(
                                                  color: Theme.of(context)
                                                      .dividerColor,
                                                  width: 0.4)),
                                          // columnSpacing: 20,
                                          columns: [
                                            // DataColumn(
                                            //   label: Text(
                                            //     "Days",
                                            //     style: Theme.of(context).textTheme.titleSmall!.merge(
                                            //           const TextStyle(
                                            //             color: Colors.white,
                                            //           ),
                                            //         ),
                                            //   ),
                                            // ),
                                            ...List.generate(
                                              widget.controllerTT.weeklyTT!.days
                                                  .values!.length,
                                              (index) => DataColumn(
                                                label: Text(
                                                  widget.controllerTT.weeklyTT!
                                                      .days.values!
                                                      .elementAt(index)
                                                      .ttmDDayCode!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .merge(
                                                        const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                          rows: List.generate(
                                            widget.controllerTT.weeklyTT!
                                                .periods.values!.length,
                                            (index) => DataRow(
                                              cells: [
                                                // DataCell(
                                                //   Container(
                                                //     width: double.infinity,
                                                //     height: 50,
                                                //     color: noticeColor.elementAt(index >= 7 ? 0 : index),
                                                //     child: Text(
                                                //       "P${snapshot.data!.periods.values!.elementAt(index).ttmPPeriodName}",
                                                //     ),
                                                //   ),
                                                // ),
                                                ...List.generate(
                                                  widget.controllerTT.weeklyTT!
                                                      .days.values!.length,
                                                  (e2) {
                                                    DataCell dC =
                                                        const DataCell(
                                                            Text(""));
                                                    for (var e3 = 0;
                                                        e3 <
                                                            widget
                                                                .controllerTT
                                                                .weeklyTT!
                                                                .tt
                                                                .length;
                                                        e3++) {
                                                      for (var i = 0;
                                                          i <
                                                              widget
                                                                  .controllerTT
                                                                  .weeklyTT!
                                                                  .tt
                                                                  .elementAt(e3)
                                                                  .classesAt
                                                                  .length;
                                                          i++) {
                                                        String period = widget
                                                            .controllerTT
                                                            .weeklyTT!
                                                            .periods
                                                            .values!
                                                            .elementAt(index)
                                                            .ttmPPeriodName!
                                                            .toString();

                                                        String day = widget
                                                            .controllerTT
                                                            .weeklyTT!
                                                            .days
                                                            .values!
                                                            .elementAt(e2)
                                                            .ttmDDayName!
                                                            .toString()
                                                            .toLowerCase()
                                                            .trim();
                                                        if (widget.controllerTT
                                                                    .weeklyTT!.tt
                                                                    .elementAt(
                                                                        e3)
                                                                    .classesAt
                                                                    .elementAt(
                                                                        i)
                                                                    .periodName
                                                                    .toString() ==
                                                                period &&
                                                            widget.controllerTT
                                                                    .weeklyTT!.tt
                                                                    .elementAt(
                                                                        e3)
                                                                    .classesAt
                                                                    .elementAt(
                                                                        i)
                                                                    .dayName
                                                                    .toLowerCase()
                                                                    .trim() ==
                                                                day) {
                                                          dC = DataCell(
                                                            Text(
                                                                "${widget.controllerTT.weeklyTT!.tt.elementAt(e3).classesAt.elementAt(i).className} ${widget.controllerTT.weeklyTT!.tt.elementAt(e3).classesAt.elementAt(i).sectionName} ${widget.controllerTT.weeklyTT!.tt.elementAt(e3).classesAt.elementAt(i).subjectName} ",
                                                             // "${widget.controllerTT.weeklyTT!.tt.elementAt(e3).classesAt.elementAt(i).className} ${widget.controllerTT.weeklyTT!.tt.elementAt(e3).classesAt.elementAt(i).sectionName}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .merge(
                                                                    TextStyle(
                                                                      color: timetablePeriodColor
                                                                          .elementAt(
                                                                        Random()
                                                                            .nextInt(12),
                                                                      ),
                                                                    ),
                                                                  ),
                                                            ),
                                                          );
                                                          // return dC;
                                                        }
                                                      }
                                                    }
                                                    return dC;
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
            }),
          ],
        ),
      ),
    );
  }
}
