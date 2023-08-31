import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/manager/time_table/api/get_manager_daily_day_tt_api.dart';
import 'package:m_skool_flutter/manager/time_table/api/get_manager_daily_tt_api.dart';
import 'package:m_skool_flutter/manager/time_table/api/get_staff_list_api.dart';
import 'package:m_skool_flutter/manager/time_table/controller/time_table_controller.dart';
import 'package:m_skool_flutter/manager/time_table/model/manager_daily_Day_model.dart';
import 'package:m_skool_flutter/manager/time_table/model/manager_time_table_stafflist_model.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class ManagerDailyTimeTable extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController controller;
  final ManagerTimeTableController ttDailyController;
  const ManagerDailyTimeTable(
      {super.key,
      required this.loginSuccessModel,
      required this.controller,
      required this.ttDailyController});

  @override
  State<ManagerDailyTimeTable> createState() => _ManagerDailyTimeTableState();
}

class _ManagerDailyTimeTableState extends State<ManagerDailyTimeTable> {
  final ManagerTimeTableController controller =
      Get.put(ManagerTimeTableController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadData();
    });
    super.initState();
  }

  void loadData() async {
    controller.staffList.clear();
    await GetStaffListInitialDataApi.instance.getStaffList(
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        base: baseUrlFromInsCode("portal", widget.controller),
        controller: controller);

    await GetManagerDailyDayTTApi.instance.getDailyDayTTApi(
        miId: widget.loginSuccessModel.mIID!,
        base: baseUrlFromInsCode("portal", widget.controller),
        controller: controller);

    await ManagerDailyTTApi.instance.getDailyTT(
        miId: widget.loginSuccessModel.mIID!,
        asmayId: widget.loginSuccessModel.asmaYId!,
        base: baseUrlFromInsCode("portal", widget.controller),
        controller: controller,
        ttMiID: widget.ttDailyController.selectedDayList!.ttmDId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(bottom: 20)),
            Obx(() {
              return CustomContainer(
                child: DropdownButtonFormField<ManagerTimeTableStaffListValues>(
                  value: controller.selectedStaffList,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        top: 16.0, bottom: 16.0, left: 10, right: 10),
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
                            height: 16.0,
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Text(
                            "Select Employee",
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
                  
                  items: List.generate(
                    controller.staffList.length,
                    (index) =>
                        DropdownMenuItem<ManagerTimeTableStaffListValues>(
                      value: controller.staffList.elementAt(index),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 12.0, left: 0, right:0),
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
                  onChanged: (s) async {
                    controller.selectedStaffList = s;

                    await GetManagerDailyDayTTApi.instance.getDailyDayTTApi(
                        miId: widget.loginSuccessModel.mIID!,
                        base: baseUrlFromInsCode("portal", widget.controller),
                        controller: controller);
                    await ManagerDailyTTApi.instance.getDailyTT(
                        miId: widget.loginSuccessModel.mIID!,
                        asmayId: widget.loginSuccessModel.asmaYId!,
                        base: baseUrlFromInsCode("portal", widget.controller),
                        controller: controller,
                        ttMiID:
                            widget.ttDailyController.selectedDayList!.ttmDId!);
                  },
                ),
              );
            }),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            Obx(() {
              return CustomContainer(
                child: DropdownButtonFormField<ManagerDailyDayModelValues>(
                  value: controller.selectedDayList,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16.0),
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
                            "Select Day",
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
                  items: List.generate(
                    controller.dayList.length,
                    (index) => DropdownMenuItem<ManagerDailyDayModelValues>(
                      value: controller.dayList.elementAt(index),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 12.0, left: 8, right: 8),
                        child: Text(
                          controller.dayList.elementAt(index).ttmDDayCode!,
                          style: Theme.of(context).textTheme.labelSmall!.merge(
                              const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  letterSpacing: 0.3)),
                        ),
                      ),
                    ),
                  ),
                  onChanged: (s) async {
                    controller.selectedDayList = s;

                    ManagerDailyTTApi.instance.getDailyTT(
                        miId: widget.loginSuccessModel.mIID!,
                        asmayId: widget.loginSuccessModel.asmaYId!,
                        base: baseUrlFromInsCode("portal", widget.controller),
                        controller: controller,
                        ttMiID:
                            widget.ttDailyController.selectedDayList!.ttmDId!);
                  },
                ),
              );
            }),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            Obx(() {
              return widget
                      .ttDailyController.isErrorOccuredWhileLoadingDailyTT.value
                  ? ErrWidget(
                      err: {
                        "errorTitle": "An Unexpected Error Occured",
                        "errorMsg": widget.ttDailyController
                            .isErrorOccuredWhileLoadingDailyTT.value
                      },
                    )
                  : widget.ttDailyController.isLoadingDailyTT.value
                      ? AnimatedProgressWidget(
                          title: "Loading Timetable",
                          desc:
                              "Don't Worry, your classes wont't miss, We will provide you timetable",
                          animationPath: "assets/json/default.json",
                        )
                      : widget.ttDailyController.day.isEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.1,
                                ),
                                AnimatedProgressWidget(
                                  title: "No Timetable Found",
                                  desc: "We couldn't find any timetable",
                                  animationPath: "assets/json/nodata.json",
                                  animatorHeight: 250,
                                ),
                              ],
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 16.0),
                              height: Get.height * 0.7,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      DataTable(
                                          dataTextStyle: const TextStyle(
                                              fontSize: 15,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.95),
                                              fontWeight: FontWeight.w500),
                                          dataRowHeight: 40,
                                          headingRowHeight: 40,
                                          horizontalMargin: 10,
                                          columnSpacing: 40,
                                          dividerThickness: 1,
                                          border: TableBorder.all(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              width: 0.5),
                                          headingRowColor:
                                              MaterialStateProperty.all(
                                                  Theme.of(context)
                                                      .primaryColor),
                                          columns: [
                                            // DataColumn(
                                            //     label: Text(
                                            //   "S.No",
                                            //   style: TextStyle(
                                            //       color: Colors.white),
                                            // )),
                                            DataColumn(
                                                label: Text("Period",
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                            DataColumn(
                                                label: Text("Class",
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                            DataColumn(
                                                label: Text("Section",
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                          ],
                                          rows: List.generate(
                                              controller.day.length,
                                              
                                              (index) => DataRow(cells: [
                                                
                                                    // DataCell(Text(
                                                    //     "${controller.day.elementAt(index).hashCode}")),
                                                    DataCell(Text(
                                                        "${controller.day.elementAt(index).period}")),
                                                    DataCell(Text(
                                                        "${controller.day.elementAt(index).asmcLClassName}")),
                                                    DataCell(Text(
                                                        "${controller.day.elementAt(index).asmCSectionName}")),
                                                  ]))),
                                    ],
                                  ),
                                ),
                              ),
                            );
            }),
          ],
        ),
      ),
    );
  }
}
