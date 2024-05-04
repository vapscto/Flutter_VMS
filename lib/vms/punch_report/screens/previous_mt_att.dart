import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/punch_report/api/punch_api.dart';
import 'package:m_skool_flutter/vms/punch_report/controller/punch_filter_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class PreviousMonthAttendanceScreen extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final PunchFilterController controller;
  const PreviousMonthAttendanceScreen(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel,
      required this.controller});

  @override
  State<PreviousMonthAttendanceScreen> createState() =>
      _PreviousMonthAttendanceScreenState();
}

class _PreviousMonthAttendanceScreenState
    extends State<PreviousMonthAttendanceScreen> {
  _onload() async {
    widget.controller.attendance(true);
    await attendance(
        ctn: widget.controller,
        base: baseUrlFromInsCode('frontoffice', widget.mskoolController),
        body: {
          "MI_Id": widget.loginSuccessModel.mIID,
          "roleId": widget.loginSuccessModel.roleId,
          "Id": widget.loginSuccessModel.userId,
          "flag": "Single",
          "rdbbutton": "Day",
          "Fromdate": firstDate!.toIso8601String(),
          "Todate": lastDt!.toIso8601String()
        });
    widget.controller.attendance(false);
  }

  DateTime dt = DateTime.now();
  DateTime? firstDate;
  DateTime? lastDt;
  int totalDay = 0;
  @override
  void initState() {
    firstDate = DateTime(dt.year, dt.month - 1, 1);
    lastDt = DateTime(dt.year, dt.month, 1).subtract(const Duration(days: 1));
    totalDay = lastDt!.day;
    _onload();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(title: '${fullMonths[dt.month - 2]} Month Attendance')
              .getAppBar(),
      body: Obx(() {
        return (widget.controller.isAtt.value)
            ? Center(
                child: AnimatedProgressWidget(
                    title:
                        "Loading ${fullMonths[dt.month - 2]} Month Attendance",
                    desc:
                        "Please wait, While we load ${fullMonths[dt.month - 2]} Month Attendance for you.",
                    animationPath: "assets/json/default.json"),
              )
            : (widget.controller.staffDetails.isEmpty)
                ? const Center(
                    child: AnimatedProgressWidget(
                      animationPath: "assets/json/nodata.json",
                      animatorHeight: 250,
                      title: "No Record Found",
                      desc:
                          "At this selected date, there is no puch report available",
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Text(
                              "Attendance Report From ${dateFormat1(firstDate!)} To ${dateFormat1(lastDt!)}",
                              style: Get.textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Details Might be Veried After Hr Updates",
                              style: Get.textTheme.titleSmall!
                                  .copyWith(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(1, 2.1),
                                  blurRadius: 0,
                                  spreadRadius: 0,
                                  color: Colors.black12),
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'Employee Name:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text:
                                            '${widget.controller.staffDetails.first.hrmEEmployeeFirstName}',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ])),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'Designation:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text:
                                            '${widget.controller.staffDetails.first.hrmEPerStreet}',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ])),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'Employee Code:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text:
                                            '${widget.controller.staffDetails.first.hrmEEmployeeCode}',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ])),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'DOJ:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text: dateFormat1(DateTime.parse(widget
                                            .controller
                                            .staffDetails
                                            .first
                                            .hrmEDOJ)),
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ])),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'Total Days:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text: '$totalDay',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ])),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'Working Days:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text:
                                            '${totalDay - widget.controller.unAuthorizedLeave.value}',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.green)),
                                  ])),
                                ],
                              ),
                            ),
                            Divider(
                              color: Theme.of(context).primaryColor,
                              thickness: 1,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: 'Total LOP:-',
                                          style: Get.textTheme.titleSmall),
                                      TextSpan(
                                          text:
                                              '${widget.controller.unAuthorizedLeave.value}',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.red)),
                                    ])),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: 'Total Payable Days:-',
                                          style: Get.textTheme.titleSmall),
                                      TextSpan(
                                          text:
                                              '${totalDay - widget.controller.unAuthorizedLeave.value}',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.green)),
                                    ])),
                                  ]),
                            ),
                            Divider(
                              color: Theme.of(context).primaryColor,
                              thickness: 1,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: 'Final LOP:-',
                                          style: Get.textTheme.titleSmall),
                                      TextSpan(
                                          text: '',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.red)),
                                    ])),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: 'Final Payable:-',
                                          style: Get.textTheme.titleSmall),
                                      TextSpan(
                                          text: '',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.green)),
                                    ])),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: 'HR Remarks:-',
                                          style: Get.textTheme.titleSmall),
                                      TextSpan(
                                          text: '',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.green)),
                                    ])),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(1, 2.1),
                                  blurRadius: 0,
                                  spreadRadius: 0,
                                  color: Colors.black12),
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width * 0.91,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                "S/W LOP Details- Dates",
                                textAlign: TextAlign.center,
                                style: Get.textTheme.titleSmall!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'Late In:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text: '',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ])),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'Early Out:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text: '',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ])),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'Unauthorized leaves:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text: widget
                                            .controller.unauthleavedatesdisplay,
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ])),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'DailyReport Notsent:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text: '',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ])),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'HalfDay DailyReport:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text: ' ',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ])),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'Blocked DailyReport:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text: ' ',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ])),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(1, 2.1),
                                  blurRadius: 0,
                                  spreadRadius: 0,
                                  color: Colors.black12),
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width * 0.91,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                "Late/Early (After ${widget.controller.staffDetails.first.hrmERelaxtime})- Dates",
                                textAlign: TextAlign.center,
                                style: Get.textTheme.titleSmall!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'Late In:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text: '',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ])),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'Early Out:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text: '',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ])),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(1, 2.1),
                                  blurRadius: 0,
                                  spreadRadius: 0,
                                  color: Colors.black12),
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width * 0.91,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                "S/W LOP - In Days",
                                textAlign: TextAlign.center,
                                style: Get.textTheme.titleSmall!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'Late In:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text: '',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ])),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'Early Out:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text: '',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ])),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'Unauthorized leaves:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text:
                                            '${widget.controller.unAuthorizedLeave.value}',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ])),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'DailyReport Notsent:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text: '',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ])),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'HalfDay DailyReport:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text: ' ',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ])),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: 'Blocked DailyReport:-',
                                        style: Get.textTheme.titleSmall),
                                    TextSpan(
                                        text: ' ',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                  ])),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(1, 2.1),
                                  blurRadius: 0,
                                  spreadRadius: 0,
                                  color: Colors.black12),
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Get.width * 0.91,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                "Approved Leave Details",
                                textAlign: TextAlign.center,
                                style: Get.textTheme.titleSmall!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Table(
                                    border: TableBorder.all(),
                                    children: [
                                      TableRow(children: [
                                        TableCell(
                                            child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6.0),
                                          child: Center(
                                            child: Text(
                                              "Type",
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                          ),
                                        )),
                                        TableCell(
                                            child: Center(
                                          child: Text(
                                            "Days",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                        )),
                                      ]),
                                      ...List.generate(
                                          widget.controller.leaveListName
                                              .length, (index) {
                                        return TableRow(children: [
                                          TableCell(
                                              child: Text(widget
                                                      .controller
                                                      .leaveListName[index]
                                                      .leavename ??
                                                  '')),
                                          TableCell(
                                              child: Text((widget
                                                          .controller
                                                          .leaveListName[index]
                                                          .drNotSentDates !=
                                                      null)
                                                  ? DateTime.parse(widget
                                                          .controller
                                                          .leaveListName[index]
                                                          .drNotSentDates!)
                                                      .day
                                                      .toString()
                                                  : ""))
                                        ]);
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
      }),
    );
  }
}
