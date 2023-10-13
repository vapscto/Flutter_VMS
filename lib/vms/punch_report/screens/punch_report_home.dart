import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/punch_report/api/punch_report_api.dart';
import 'package:m_skool_flutter/vms/punch_report/controller/punch_filter_controller.dart';
import 'package:m_skool_flutter/vms/punch_report/widget/punch_report_item.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class PunchReport extends StatefulWidget {
  final String title;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String? previousScreen;
  const PunchReport({
    super.key,
    required this.title,
    required this.loginSuccessModel,
    required this.mskoolController,
    required this.previousScreen,
  });

  @override
  State<PunchReport> createState() => _PunchReportState();
}

class _PunchReportState extends State<PunchReport> {
  int color = -1;

  final PunchFilterController punchFilterController =
      Get.put(PunchFilterController());

  int backgroundColor = -1;

  @override
  void dispose() {
    Get.delete<PunchFilterController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton:const HomeFab(),
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: (widget.previousScreen == '0') ? false : true,
        // titleSpacing: 0,
        leading: (widget.previousScreen == '0')
            ? const CustomGoBackButton()
            : const SizedBox(),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(
              60,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () async {
                      final DateTime? dt = await showDatePicker(
                        context: context,
                        initialDate: punchFilterController.startFrom.value,
                        firstDate: DateTime(2011, 01, 01),
                        lastDate: punchFilterController.endTo.value,
                      );

                      if (dt == null) {
                        Fluttertoast.showToast(
                            msg: "Please select Start Date.");
                        return;
                      }
                      punchFilterController.updateDisplayAbleStartFrom(
                          "${dt.day}-${dt.month}-${dt.year}");
                      punchFilterController.updateStartFrom(dt);

                      if (punchFilterController.start.value > 0) {
                        await PunchReportApi.instance.pcReports(
                            miId: widget.loginSuccessModel.mIID!,
                            userId: widget.loginSuccessModel.userId!,
                            fromDate: punchFilterController.startFrom.value
                                .toLocal()
                                .toString(),
                            endDate: punchFilterController.endTo.value
                                .toLocal()
                                .toString(),
                            base: baseUrlFromInsCode(
                              "portal",
                              widget.mskoolController,
                            ),
                            controller: punchFilterController);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      width: double.infinity,
                      height: 50,
                      child: Obx(() {
                        return Text(
                            punchFilterController.displayAbleStartFrom.value);
                      }),
                    ),
                  )),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                      child: InkWell(
                    onTap: () async {
                      final DateTime? dt = await showDatePicker(
                        context: context,
                        initialDate: punchFilterController.startFrom.value,
                        firstDate: punchFilterController.startFrom.value,
                        lastDate: DateTime.now(),
                      );

                      if (dt == null) {
                        Fluttertoast.showToast(
                            msg:
                                "You didn't selected end date to show punch report");
                        return;
                      }

                      punchFilterController.updateDisplayAbleEndTo(
                          "${dt.day}-${dt.month}-${dt.year}");
                      punchFilterController.updateEndTo(dt);

                      punchFilterController.start.value += 1;

                      await PunchReportApi.instance.pcReports(
                          miId: widget.loginSuccessModel.mIID!,
                          userId: widget.loginSuccessModel.userId!,
                          fromDate: punchFilterController.startFrom.value
                              .toLocal()
                              .toString(),
                          endDate: punchFilterController.endTo.value
                              .toLocal()
                              .toString(),
                          base: baseUrlFromInsCode(
                              "portal", widget.mskoolController),
                          controller: punchFilterController);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      width: double.infinity,
                      height: 50,
                      child: Obx(() {
                        return Text(
                            punchFilterController.displayAbleEndTo.value);
                      }),
                    ),
                  )),
                ],
              ),
            )),
      ),
      // appBar: CustomAppBar(
      //   title: widget.title,
      //   bottom: PreferredSize(
      //       preferredSize: const Size.fromHeight(
      //         60,
      //       ),
      //       child: Padding(
      //         padding: const EdgeInsets.all(12.0),
      //         child: Row(
      //           children: [
      //             Expanded(
      //                 child: InkWell(
      //               onTap: () async {
      //                 final DateTime? dt = await showDatePicker(
      //                   context: context,
      //                   initialDate: punchFilterController.startFrom.value,
      //                   firstDate: DateTime(2011, 01, 01),
      //                   lastDate: punchFilterController.endTo.value,
      //                 );

      //                 if (dt == null) {
      //                   Fluttertoast.showToast(
      //                       msg: "Please select Start Date.");
      //                   return;
      //                 }
      //                 punchFilterController.updateDisplayAbleStartFrom(
      //                     "${dt.day}-${dt.month}-${dt.year}");
      //                 punchFilterController.updateStartFrom(dt);

      //                 if (punchFilterController.start.value > 0) {
      //                   await PunchReportApi.instance.pcReports(
      //                       miId: widget.loginSuccessModel.mIID!,
      //                       userId: widget.loginSuccessModel.userId!,
      //                       fromDate: punchFilterController.startFrom.value
      //                           .toLocal()
      //                           .toString(),
      //                       endDate: punchFilterController.endTo.value
      //                           .toLocal()
      //                           .toString(),
      //                       base: baseUrlFromInsCode(
      //                         "portal",
      //                         widget.mskoolController,
      //                       ),
      //                       controller: punchFilterController);
      //                 }
      //               },
      //               child: Container(
      //                 padding: const EdgeInsets.all(12.0),
      //                 alignment: Alignment.centerLeft,
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(8.0),
      //                   color: Colors.white,
      //                 ),
      //                 width: double.infinity,
      //                 height: 50,
      //                 child: Obx(() {
      //                   return Text(
      //                       punchFilterController.displayAbleStartFrom.value);
      //                 }),
      //               ),
      //             )),
      //             const SizedBox(
      //               width: 12.0,
      //             ),
      //             Expanded(
      //                 child: InkWell(
      //               onTap: () async {
      //                 final DateTime? dt = await showDatePicker(
      //                   context: context,
      //                   initialDate: punchFilterController.startFrom.value,
      //                   firstDate: punchFilterController.startFrom.value,
      //                   lastDate: DateTime.now(),
      //                 );

      //                 if (dt == null) {
      //                   Fluttertoast.showToast(
      //                       msg:
      //                           "You didn't selected end date to show punch report");
      //                   return;
      //                 }

      //                 punchFilterController.updateDisplayAbleEndTo(
      //                     "${dt.day}-${dt.month}-${dt.year}");
      //                 punchFilterController.updateEndTo(dt);

      //                 punchFilterController.start.value += 1;

      //                 await PunchReportApi.instance.pcReports(
      //                     miId: widget.loginSuccessModel.mIID!,
      //                     userId: widget.loginSuccessModel.userId!,
      //                     fromDate: punchFilterController.startFrom.value
      //                         .toLocal()
      //                         .toString(),
      //                     endDate: punchFilterController.endTo.value
      //                         .toLocal()
      //                         .toString(),
      //                     base: baseUrlFromInsCode(
      //                         "portal", widget.mskoolController),
      //                     controller: punchFilterController);
      //               },
      //               child: Container(
      //                 padding: const EdgeInsets.all(12.0),
      //                 alignment: Alignment.centerLeft,
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(8.0),
      //                   color: Colors.white,
      //                 ),
      //                 width: double.infinity,
      //                 height: 50,
      //                 child: Obx(() {
      //                   return Text(
      //                       punchFilterController.displayAbleEndTo.value);
      //                 }),
      //               ),
      //             )),
      //           ],
      //         ),
      //       )),
      // ).getAppBar(),
      body: Obx(() {
        logger.d("message");
        return punchFilterController.start.value == 0
            ? const Center(
                child: AnimatedProgressWidget(
                  title: "Please Select Start & End Date",
                  desc:
                      "When you select the data then your punch details will appear here.",
                  animationPath: "assets/json/nodata.json",
                  animatorHeight: 250,
                ),
              )
            : punchFilterController.isErrorOccured.value
                ? Center(
                    child: ErrWidget(
                      err: {
                        "errorTitle": "Unexpected Error Occured",
                        "errorMsg": punchFilterController.message.value,
                      },
                    ),
                  )
                : punchFilterController.startFilteration.value
                    ? const Center(
                        child: AnimatedProgressWidget(
                            title: "Loading Punch Report",
                            desc:
                                "Please wait, While we load Punch Report for you.",
                            animationPath: "assets/json/default.json"),
                      )
                    : punchFilterController.reports.isEmpty
                        ? const Center(
                            child: AnimatedProgressWidget(
                              animationPath: "assets/json/nodata.json",
                              animatorHeight: 250,
                              title: "No Record Found",
                              desc:
                                  "At this selected date, there is no puch report available",
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.all(16.0),
                            itemBuilder: (_, index) {
                              backgroundColor += 1;
                              if (backgroundColor % 6 == 0) {
                                backgroundColor = 0;
                              }

                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: lighterColor
                                        .elementAt(backgroundColor)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          getFormatedDate(DateTime.parse(
                                              punchFilterController.reports
                                                  .elementAt(index)
                                                  .punchdate!)),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .merge(
                                                const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                        ),
                                        Chip(
                                          label: Text(
                                            punchFilterController.reports
                                                            .elementAt(index)
                                                            .punchINtime ==
                                                        null ||
                                                    punchFilterController
                                                            .reports
                                                            .elementAt(index)
                                                            .punchOUTtime ==
                                                        null
                                                ? "N/A"
                                                : timeDifference(
                                                    punchFilterController
                                                        .reports
                                                        .elementAt(index)
                                                        .punchINtime!,
                                                    punchFilterController
                                                        .reports
                                                        .elementAt(index)
                                                        .punchOUTtime!),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .merge(
                                                  const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                          ),
                                          backgroundColor: noticeColor
                                              .elementAt(backgroundColor),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                    PunchReportItem(
                                      title: "In Time",
                                      time: timing(
                                          "${punchFilterController.reports.elementAt(index).punchINtime}"),
                                    ),
                                    const SizedBox(
                                      height: 12.0,
                                    ),
                                    PunchReportItem(
                                      title: "Out Time",
                                      time: timing(
                                          "${punchFilterController.reports.elementAt(index).punchOUTtime}"),
                                    ),
                                    const SizedBox(
                                      height: 12.0,
                                    ),
                                    PunchReportItem(
                                      title: "Late In Time",
                                      time: punchFilterController.reports
                                              .elementAt(index)
                                              .lateby ??
                                          "N/A",
                                    ),
                                    const SizedBox(
                                      height: 12.0,
                                    ),
                                    PunchReportItem(
                                      title: "Early Out",
                                      time: punchFilterController.reports
                                              .elementAt(index)
                                              .earlyby ??
                                          "N/A",
                                    ),
                                    const SizedBox(
                                      height: 12.0,
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (_, index) {
                              return const SizedBox(
                                height: 16.0,
                              );
                            },
                            itemCount: punchFilterController.reports.length);
      }),
    );
  }
}
