import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:m_skool_flutter/controller/mskoll_controller.dart';

import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/timetable/widget/daily_tt.dart';
import 'package:m_skool_flutter/student/timetable/widget/weekly_tt.dart';

import 'package:m_skool_flutter/widget/custom_app_bar.dart';

import 'package:m_skool_flutter/widget/home_fab.dart';

// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// import 'package:syncfusion_flutter_pdf/pdf.dart';

class TimeTableHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String? month;
  const TimeTableHome(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      this.month});

  @override
  State<TimeTableHome> createState() => _TimeTableHomeState();
}

class _TimeTableHomeState extends State<TimeTableHome> {
  RxBool showWeekly = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Time Table".tr).getAppBar(),
      floatingActionButton: const HomeFab(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Choose Format",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 1.5)),
                    child: Row(
                      children: [
                        Obx(() {
                          return InkWell(
                            onTap: () {
                              showWeekly.value = false;
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(
                                    24.0,
                                  ),
                                  bottomLeft: Radius.circular(24.0),
                                ),
                                color: showWeekly.value
                                    ? Colors.transparent
                                    : Theme.of(context).primaryColor,
                              ),
                              child: Text(
                                "Day",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(TextStyle(
                                        color: showWeekly.value
                                            ? Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .color
                                            : Colors.white)),
                              ),
                            ),
                          );
                        }),
                        Obx(() {
                          return InkWell(
                            onTap: () {
                              showWeekly.value = true;
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(
                                    24.0,
                                  ),
                                  bottomRight: Radius.circular(24.0),
                                ),
                                color: showWeekly.value
                                    ? Theme.of(context).primaryColor
                                    : Colors.transparent,
                              ),
                              child: Text(
                                "Week",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(TextStyle(
                                        color: showWeekly.value
                                            ? Colors.white
                                            : Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .color)),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              return SizedBox(
                height: showWeekly.value ? 0.0 : 8.0,
              );
            }),
            Obx(() {
              return showWeekly.value
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: WeeklyTT(
                        loginSuccessModel: widget.loginSuccessModel,
                        mskoolController: widget.mskoolController,
                      ),
                    )
                  : DailyTT(
                      loginSuccessModel: widget.loginSuccessModel,
                      mskoolController: widget.mskoolController,
                      month: widget.month,
                    );
            }),
          ],
        ),
      ),
    );
  }
}
