import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';

class CurrentMonthAttendanceScreen extends StatelessWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  const CurrentMonthAttendanceScreen(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel});

  @override
  Widget build(BuildContext context) {
    DateTime dt = DateTime.now();
    return Scaffold(
      appBar:
          CustomAppBar(title: '${fullMonths[dt.month - 1]} Month Attendance')
              .getAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Text(
                  "Attendance Report From _ To_",
                  style: Get.textTheme.titleSmall!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 6),
                Text(
                  "Details Might be Veried After Hr Updates",
                  style: Get.textTheme.titleSmall!.copyWith(color: Colors.red),
                )
              ],
            ),
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Theme.of(context).primaryColor),
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Employee Name:-',
                            style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: 'Tapan',
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Designation:-',
                            style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: 'Software',
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Employee Code:-',
                            style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: '1246',
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'DOJ:-', style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: 'Tapan',
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Total Days:-',
                            style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: '30',
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).primaryColor)),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Working Days:-',
                            style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: '26',
                            style: Get.textTheme.titleSmall!.copyWith(
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: 'Total LOP:-',
                              style: Get.textTheme.titleSmall),
                          TextSpan(
                              text: '1',
                              style: Get.textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red)),
                        ])),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: 'Total Payable Days:-',
                              style: Get.textTheme.titleSmall),
                          TextSpan(
                              text: '30',
                              style: Get.textTheme.titleSmall!.copyWith(
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: 'Final LOP:-',
                              style: Get.textTheme.titleSmall),
                          TextSpan(
                              text: '0',
                              style: Get.textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red)),
                        ])),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: 'Final Payable:-',
                              style: Get.textTheme.titleSmall),
                          TextSpan(
                              text: '30',
                              style: Get.textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green)),
                        ])),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: 'HR Remarks:-',
                              style: Get.textTheme.titleSmall),
                          TextSpan(
                              text: 'HR LOP - 0',
                              style: Get.textTheme.titleSmall!.copyWith(
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
                border: Border.all(color: Theme.of(context).primaryColor),
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
                        color: Colors.white, fontWeight: FontWeight.w600),
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
                            text: 'Late In:-', style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: '24',
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Early Out:-',
                            style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: '23',
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Unauthorized leaves:-',
                            style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: '1',
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'DailyReport Notsent:-',
                            style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: '',
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'HalfDay DailyReport:-',
                            style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: ' ',
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Blocked DailyReport:-',
                            style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: ' ',
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
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
                border: Border.all(color: Theme.of(context).primaryColor),
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
                    "Late/Early (After 369)- Dates",
                    textAlign: TextAlign.center,
                    style: Get.textTheme.titleSmall!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
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
                            text: 'Late In:-', style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: '24',
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Early Out:-',
                            style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: '23',
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
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
                border: Border.all(color: Theme.of(context).primaryColor),
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
                        color: Colors.white, fontWeight: FontWeight.w600),
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
                            text: 'Late In:-', style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: '24',
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Early Out:-',
                            style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: '23',
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Unauthorized leaves:-',
                            style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: '1',
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'DailyReport Notsent:-',
                            style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: '',
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'HalfDay DailyReport:-',
                            style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: ' ',
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
                      ])),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Blocked DailyReport:-',
                            style: Get.textTheme.titleSmall),
                        TextSpan(
                            text: ' ',
                            style: Get.textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
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
                border: Border.all(color: Theme.of(context).primaryColor),
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
                        color: Colors.white, fontWeight: FontWeight.w600),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: Center(
                                child: Text(
                                  "Type",
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                            )),
                            TableCell(
                                child: Center(
                              child: Text(
                                "Days",
                                style: Get.textTheme.titleSmall!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            )),
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: Center(
                                child: Text(
                                  "Type",
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                            )),
                            TableCell(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: Center(
                                child: Text(
                                  "Type",
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                            )),
                          ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
