import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/config/themes/theme_data.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/attendance/api/get_academic_year.dart';
import 'package:m_skool_flutter/student/attendance/api/get_attendance_details.dart';
import 'package:m_skool_flutter/student/attendance/controller/attendance_handler.dart';
import 'package:m_skool_flutter/student/attendance/model/academic_year_model.dart';
import 'package:m_skool_flutter/student/attendance/model/attendance_detail_model.dart';
import 'package:m_skool_flutter/student/attendance/widgets/attendance_column_chart.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class AttendanceHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const AttendanceHomeScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<AttendanceHomeScreen> createState() => _AttendanceHomeScreenState();
}

class _AttendanceHomeScreenState extends State<AttendanceHomeScreen> {
  List<String> dummySession = [
    "2017-2018",
    "2018-2019",
    "2019-2020",
    "2020-2021",
    "2021-2022",
  ];

  String selectedValue = "2021-2022";
  RxBool showGraph = false.obs;

  final AttendanceHandler handler = Get.put(AttendanceHandler());
  @override
  void initState() {
    getAttendanceDatum();
    super.initState();
  }

  Future<void> getAttendanceDatum() async {
    await GetAttendanceAcademicYear.instance.getAcademicYear(
      miId: widget.loginSuccessModel.mIID!,
      amstId: widget.loginSuccessModel.amsTId!,
      base: baseUrlFromInsCode("portal", widget.mskoolController),
      handler: handler,
    );

    await GetAttendanceDetails.instance.getAttendance(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: handler.asmayId.value,
      amstId: widget.loginSuccessModel.amsTId!,
      base: baseUrlFromInsCode("portal", widget.mskoolController),
      handler: handler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const CustomGoBackButton(),
        leadingWidth: 30,
        title: Text("Attendance".tr),
      ),
      floatingActionButton: const HomeFab(),
      body: Obx(
        () {
          return handler.errorHappend.value
              ? const ErrWidget(err: {
                  "errorTitle": "Unable to connect to server",
                  "errorMsg":
                      "Sorry! but we are unable to connect to server right now, Try again later."
                })
              : handler.isLoadingWholeScreen.value
                  ? const AnimatedProgressWidget(
                      title: "Getting your detail's",
                      desc:
                          "We are fetching your attendance directly from attendance register.",
                      animationPath: 'assets/json/attendance.json',
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 16.0),
                          Obx(() {
                            return Container(
                              //padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 8,
                                    color: Colors.black12,
                                  ),
                                ],
                              ),
                              child: DropdownButtonFormField<AttyearlistValues>(
                                value: handler.selectedInDorpDown.value,
                                decoration: InputDecoration(
                                  // border: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(12.0),
                                  // ),
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
                                        horizontal: 16.0, vertical: 6.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        color: const Color(0xFFDFFBFE)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          "assets/images/cap.png",
                                          height: 28.0,
                                        ),
                                        const SizedBox(
                                          width: 6.0,
                                        ),
                                        Text(
                                          "Academic Year".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .merge(const TextStyle(
                                                  fontSize: 20.0,
                                                  color: Color(0xFF28B6C8))),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 30,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color,
                                  ),
                                ),
                                iconSize: 30,
                                items: List.generate(
                                  handler.academicYearList.length,
                                  (index) =>
                                      DropdownMenuItem<AttyearlistValues>(
                                    value: handler.academicYearList
                                        .elementAt(index),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0, left: 8.0, right: 8.0),
                                      child: Text(
                                        handler.academicYearList
                                                .elementAt(index)
                                                .asmaYYear ??
                                            "N/a",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .merge(const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16.0,
                                                letterSpacing: 0.3)),
                                      ),
                                    ),
                                  ),
                                ),
                                onChanged: (s) async {
                                  handler.updateSelectedInDropDown(s!);
                                  handler.updateAsmayId(s.asmaYId!);
                                  logger.d(handler.asmayId.value);
                                  handler
                                      .updateIsLoadingAttendanceDetails(true);
                                  await GetAttendanceDetails.instance
                                      .getAttendance(
                                          miId: widget.loginSuccessModel.mIID!,
                                          asmayId: handler.asmayId.value,
                                          amstId:
                                              widget.loginSuccessModel.amsTId!,
                                          base: baseUrlFromInsCode("portal",
                                              widget.mskoolController),
                                          handler: handler);
                                },
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Obx(
                            () {
                              return handler.isLoadingAttendanceDetails.value
                                  ? const AnimatedProgressWidget(
                                      title: "Getting Details",
                                      desc:
                                          "We found your attendance register now we will see your presence.",
                                      animationPath:
                                          "assets/json/attendance.json",
                                    )
                                  : handler.attendanceData.isEmpty
                                      ? Column(
                                          children: [
                                            Text(
                                              "No Data found ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            const SizedBox(
                                              height: 12.0,
                                            ),
                                            const Text(
                                                "For this academic year attendance register is empty.."),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                boxShadow:
                                                    CustomThemeData.getShadow(),
                                              ),
                                              child: CustomContainer(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .labelSmall!
                                                                        .merge(
                                                                          const TextStyle(
                                                                            fontSize:
                                                                                15.0,
                                                                            //fontWeight: FontWeight.w400,
                                                                            letterSpacing:
                                                                                0.3,
                                                                          ),
                                                                        ),
                                                                    text:
                                                                        "Total Class Held : "
                                                                            .tr,
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            "${attendanceDetails(handler.attendanceData)['tch'] ?? "N/A"}",
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .labelSmall!
                                                                            .merge(
                                                                              const TextStyle(
                                                                                fontSize: 15.0,
                                                                                letterSpacing: 0.3,
                                                                              ),
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 8.0,
                                                                ),
                                                                RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .labelSmall!
                                                                        .merge(
                                                                          const TextStyle(
                                                                            fontSize:
                                                                                15.0,
                                                                            letterSpacing:
                                                                                0.3,
                                                                          ),
                                                                        ),
                                                                    text:
                                                                        "Total Class Attended : "
                                                                            .tr,
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            "${attendanceDetails(handler.attendanceData)['tca'] ?? "N/A"}",
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .labelSmall!
                                                                            .merge(
                                                                              const TextStyle(
                                                                                fontSize: 15.0,
                                                                                letterSpacing: 0.3,
                                                                              ),
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 8.0,
                                                                ),
                                                                RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .labelSmall!
                                                                        .merge(
                                                                          const TextStyle(
                                                                            fontSize:
                                                                                15.0,
                                                                            letterSpacing:
                                                                                0.3,
                                                                          ),
                                                                        ),
                                                                    text:
                                                                        "Total Class Percentage : "
                                                                            .tr,
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            "${attendanceDetails(handler.attendanceData)['tcp'] ?? "N/A"}%",
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .labelSmall!
                                                                            .merge(
                                                                              const TextStyle(
                                                                                fontSize: 15.0,
                                                                                letterSpacing: 0.3,
                                                                              ),
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        (!showGraph.value)
                                                            ? InkWell(
                                                                onTap: () {
                                                                  showGraph
                                                                          .value =
                                                                      !showGraph
                                                                          .value;
                                                                },
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          16.0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          16.0),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          12.0),
                                                                  child: Text(
                                                                    "View",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .merge(const TextStyle(
                                                                            decoration:
                                                                                TextDecoration.underline)),
                                                                  ),
                                                                ),
                                                              )
                                                            : InkWell(
                                                                onTap: () {
                                                                  showGraph
                                                                          .value =
                                                                      !showGraph
                                                                          .value;
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          12.0),
                                                                  child: Text(
                                                                    "Hide",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .merge(const TextStyle(
                                                                            decoration:
                                                                                TextDecoration.underline)),
                                                                  ),
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                    // CustomContainer(
                                                    // child:
                                                    (showGraph.value)
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12.0),
                                                            child: Column(
                                                              children: [
                                                                AttendanceColumnChart(
                                                                  handler:
                                                                      handler,
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Row(
                                                                        children: const [
                                                                          Icon(
                                                                            Icons.circle,
                                                                            color:
                                                                                Color(0xFFBEEDFF),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                8.0,
                                                                          ),
                                                                          Text(
                                                                              "Class Held"),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            24.0,
                                                                      ),
                                                                      Row(
                                                                        children: const [
                                                                          Icon(
                                                                            Icons.circle,
                                                                            color:
                                                                                Color(0xFF00A5E3),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                8.0,
                                                                          ),
                                                                          Text(
                                                                              "Total Present"),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : Container(),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16.0,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                boxShadow:
                                                    CustomThemeData.getShadow(),
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: DataTable(
                                                  columnSpacing: 15,
                                                  // horizontalMargin: 5,
                                                  // checkboxHorizontalMargin: 0,
                                                  headingRowColor:
                                                      MaterialStateColor
                                                          .resolveWith((states) =>
                                                              Theme.of(context)
                                                                  .primaryColor),
                                                  border: const TableBorder(
                                                    horizontalInside:
                                                        BorderSide.none,
                                                    verticalInside:
                                                        BorderSide.none,
                                                  ),

                                                  columns: [
                                                    DataColumn(
                                                      label: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                          "Months".tr,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelSmall!
                                                                  .merge(
                                                                    const TextStyle(
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.3,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                        ),
                                                      ),
                                                    ),
                                                    DataColumn(
                                                      label: Flexible(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Text(
                                                            "Class Held".tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            maxLines: 2,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .merge(
                                                                  const TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.3,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    DataColumn(
                                                      label: Flexible(
                                                        fit: FlexFit.loose,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Text(
                                                            "Total Present".tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .labelSmall!
                                                                .merge(
                                                                  const TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.3,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  rows: List.generate(
                                                    handler
                                                        .attendanceData.length,
                                                    (index) => populateData(
                                                      context,
                                                      handler.attendanceData
                                                          .elementAt(index)
                                                          .mONTHNAME??"N/a",
                                                      handler.attendanceData
                                                          .elementAt(index)
                                                          .cLASSHELD
                                                          .toString(),
                                                      handler.attendanceData
                                                          .elementAt(index)
                                                          .tOTALPRESENT
                                                          .toString(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                            },
                          ),
                        ],
                      ),
                    );
        },
      ),
    );
  }

  DataRow populateData(
      BuildContext context, String month, String classHeld, String present) {
    return DataRow(
      cells: [
        DataCell(
          Center(
            child: Text(
              month,
              style: Theme.of(context).textTheme.labelSmall!.merge(
                    const TextStyle(
                      fontSize: 14.0,
                      letterSpacing: 0.3,
                    ),
                  ),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              classHeld,
              style: Theme.of(context).textTheme.labelSmall!.merge(
                    const TextStyle(
                      fontSize: 13.0,
                      letterSpacing: 0.3,
                    ),
                  ),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              present,
              style: Theme.of(context).textTheme.labelSmall!.merge(
                    const TextStyle(
                      fontSize: 13.0,
                      letterSpacing: 0.3,
                    ),
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> attendanceDetails(
      RxList<AttendanceDetailValues> attendanceData) {
    int tca = 0;
    int tch = 0;
    double tcp = 0.0;
    for (int i = 0; i < attendanceData.length; i++) {
      final AttendanceDetailValues values = attendanceData.elementAt(i);
      tca += double.parse(values.tOTALPRESENT.toString()).toInt();
      tch += int.parse(values.cLASSHELD!);
    }

    tcp = ((tca / tch) * 100).toPrecision(1);

    return {
      "tca": tca,
      "tch": tch,
      "tcp": tcp,
    };
  }
}
