// ignore_for_file: unrelated_type_equality_checks, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/controller/attendance_entry_related_controller.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/initialdataModel.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/sectionModel.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/screen/attendance_records_popup_screen.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/screen/dailyonce_attendance_entry_detail_screen.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/screen/dailytwice_attendance_entry_detail.screen.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/screen/monthwise_attendance_entry_detail_screen.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/screen/periodwise_attendance_entry_detail_screen.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/subjectModel.dart'
    as PWM;
import 'package:m_skool_flutter/widget/home_fab.dart';
import 'package:m_skool_flutter/widget/staff_home_fab.dart';

class AttendanceEntryHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const AttendanceEntryHomeScreen({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<AttendanceEntryHomeScreen> createState() =>
      _AttendanceEntryHomeScreenState();
}

class _AttendanceEntryHomeScreenState extends State<AttendanceEntryHomeScreen> {
  final AttendanceEntryController attendanceEntryController =
      Get.put(AttendanceEntryController());

  AcademicYearListValue? selectedAcademicYear;
  ClassListValue? selectedClass;
  SectionListValue? selectedSection;
  PWM.SubjectListValue? selectedSubject;
  PeriodlistValue? selectedPeriod;
  MonthListValue? selectedMonth;

  String selectedRadio = 'Regular';
  var todayDate = TextEditingController();
  var startDate = TextEditingController();
  var endDate = TextEditingController();
  DateTime selecteddate = DateTime.now();
  DateTime? selectedstartdate;
  DateTime? selectedenddate;

  void getInitialData() async {
    attendanceEntryController.isinitialdataloading(true);
    await attendanceEntryController
        .getAttendanceEntryInitialData(
      asmayId: widget.loginSuccessModel.asmaYId!,
      userId: widget.loginSuccessModel.userId!,
      miId: widget.loginSuccessModel.mIID!,
      username: widget.loginSuccessModel.userName!,
      roleId: widget.loginSuccessModel.roleId!,
      base: baseUrlFromInsCode(
        'admission',
        widget.mskoolController,
      ),
    )
        .then(
      (value) {
        if (value) {
          selectedAcademicYear =
              attendanceEntryController.academicYearList.first;
          getClassData(selectedAcademicYear!.asmaYId!.toInt());
        }
      },
    );
    attendanceEntryController.isinitialdataloading(false);
  }

  void getClassData(int asmayId) async {
    attendanceEntryController.isclassloading(true);
    await attendanceEntryController
        .getAttendanceEntryClassData(
      asmayId: asmayId,
      userId: widget.loginSuccessModel.userId!,
      miId: widget.loginSuccessModel.mIID!,
      username: widget.loginSuccessModel.userName!,
      roleId: widget.loginSuccessModel.roleId!,
      base: baseUrlFromInsCode(
        'admission',
        widget.mskoolController,
      ),
    )
        .then((value) {
      if (value && attendanceEntryController.classList.isNotEmpty) {
        selectedClass = attendanceEntryController.classList.first;
        getSectionData(selectedClass!.asmcLId!.toInt());
      }
    });
    attendanceEntryController.isclassloading(false);
  }

  void getSectionData(int asmclId) async {
    attendanceEntryController.issectionloading(true);
    if (selectedAcademicYear == null) {
      Fluttertoast.showToast(msg: 'Select Academic year.');
      attendanceEntryController.issectionloading(false);
      return;
    }
    await attendanceEntryController
        .getSection(
      asmayId: selectedAcademicYear!.asmaYId!.toInt(),
      asmclId: asmclId.toString(),
      miId: widget.loginSuccessModel.mIID!,
      username: widget.loginSuccessModel.userName!,
      roleId: widget.loginSuccessModel.roleId!,
      userId: widget.loginSuccessModel.userId!,
      base: baseUrlFromInsCode(
        'admission',
        widget.mskoolController,
      ),
    )
        .then((value) {
      logger.d(attendanceEntryController.attendanceEntry.value);
      logger.d(value);
      if (!value || value && attendanceEntryController.sectionList.isEmpty) {
        Fluttertoast.showToast(
            msg:
                'Map The Attendance Entry Type For This Class i.e., Daily /Daily Twice/ Monthly');
      }
    });

    attendanceEntryController.issectionloading(false);
  }

  void getStudentListOnChangeOfMonth(int monthid) async {
    attendanceEntryController.isstudentdataloading(true);
    await attendanceEntryController
        .getAttendanceDataOnchangeofMonth(
      miId: widget.loginSuccessModel.mIID!,
      asmayId: selectedAcademicYear!.asmaYId!.toInt(),
      asmclId: selectedClass!.asmcLId!.toInt(),
      asmsId: selectedSection!.asmSId!,
      monthId: monthid,
      base: baseUrlFromInsCode(
        'admission',
        widget.mskoolController,
      ),
    )
        .then((value) {
      if (!value) {
        logger.d(value);
        attendanceEntryController.isstudentdataloading(false);
        return;
      }
      logger.d(attendanceEntryController.monthwiseStudentList.length);
    });
    attendanceEntryController.isstudentdataloading(false);
  }

  void getStudentListOnChangeOfSection(String asmsId) async {
    attendanceEntryController.dailyOnceAndDailyTwiceStudentList.clear();
    attendanceEntryController.boolList.clear();
    attendanceEntryController.boolList2.clear();
    attendanceEntryController.isstudentdataloading(true);
    await attendanceEntryController
        .getAttendanceDataOnChangeOfSection(
      asmayId: selectedAcademicYear!.asmaYId!.toInt(),
      userId: widget.loginSuccessModel.userId!,
      miId: widget.loginSuccessModel.mIID!,
      username: widget.loginSuccessModel.userName!,
      roleId: widget.loginSuccessModel.roleId!,
      fromDate: todayDate.text,
      asmclId: selectedClass!.asmcLId!.toString(),
      asmsId: asmsId,
      monthFlag: attendanceEntryController.attendanceEntry.value,
      monthFlag1: attendanceEntryController.attendanceEntry.value == 'D'
          ? 'Dailyonce'
          : attendanceEntryController.attendanceEntry.value == 'H'
              ? 'Dailytwice '
              : '',
      base: baseUrlFromInsCode(
        'admission',
        widget.mskoolController,
      ),
    )
        .then(
      (value) {
        if (!value) {
          logger.d(value);
          attendanceEntryController.isstudentdataloading(false);
          return;
        }
      },
    );
    attendanceEntryController.isstudentdataloading(false);
  }

  void getSubjectList(int asmsId) async {
    attendanceEntryController.issubjectloading(true);
    await attendanceEntryController
        .getSubjectListOnChangeSection(
      asmayId: selectedAcademicYear!.asmaYId!.toInt(),
      asmclId: selectedClass!.asmcLId.toString(),
      asmsId: asmsId,
      userId: widget.loginSuccessModel.userId!,
      miId: widget.loginSuccessModel.mIID!,
      username: widget.loginSuccessModel.userName!,
      roleId: widget.loginSuccessModel.roleId!,
      base: baseUrlFromInsCode(
        'admission',
        widget.mskoolController,
      ),
    )
        .then((value) {
      logger.d(value);
    });
    attendanceEntryController.issubjectloading(false);
  }

  void getStudentListOnChangeOfPeriod(int ttmpId) async {
    attendanceEntryController.isstudentdataloading(true);
    attendanceEntryController.periodwiseStudentList.clear();
    attendanceEntryController.boolList.clear();
    attendanceEntryController.asaId.value = 0;
    await attendanceEntryController
        .getStudentListOnChangePeriod(
      asmayId: selectedAcademicYear!.asmaYId!.toInt(),
      asmclId: selectedClass!.asmcLId!.toInt(),
      asmsId: selectedSection!.asmSId!.toInt(),
      ttmpId: ttmpId,
      ismsId: selectedSubject!.ismSId!,
      miId: widget.loginSuccessModel.mIID!,
      fromeDate: todayDate.text,
      base: baseUrlFromInsCode(
        'admission',
        widget.mskoolController,
      ),
    )
        .then(
      (value) {
        if (!value) {
          logger.d(value);
          attendanceEntryController.isstudentdataloading(false);
          return;
        }
      },
    );
    attendanceEntryController.isstudentdataloading(false);
  }

  @override
  void initState() {
    getInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomGoBackButton(),
        leadingWidth: 25,
        title: const Text('Attendance Entry'),
      ),
      floatingActionButton: const HomeFab(),
      //  StaffHomeFab(
      //   loginSuccessModel: widget.loginSuccessModel,
      //   mskoolController: widget.mskoolController,
      // ),
      body: Obx(
        () => attendanceEntryController.isInitialData.value
            ? const Center(
                child: AnimatedProgressWidget(
                    title: "Loading Attendance Entry",
                    desc:
                        "Please wait while we load attendance entry and create a view for you.",
                    animationPath: "assets/json/default.json"),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          top: 40, left: 16, right: 16, bottom: 16),
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
                      child: DropdownButtonFormField<AcademicYearListValue>(
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
                          isDense: true,
                          hintStyle: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .merge(const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                  letterSpacing: 0.3)),
                          hintText: attendanceEntryController
                                  .academicYearList.isNotEmpty
                              ? 'Select Year'
                              : "No data available.",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          label: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFDFFBFE),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 6.0),
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
                                  " Academic Year ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(
                                        const TextStyle(
                                            backgroundColor: Color(0xFFDFFBFE),
                                            fontSize: 20.0,
                                            color: Color(0xFF28B6C8)),
                                      ),
                                ),
                              ],
                            ),
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
                            attendanceEntryController.academicYearList.length,
                            (index) {
                          return DropdownMenuItem(
                            value: attendanceEntryController
                                .academicYearList[index],
                            child: Padding(
                              padding: const EdgeInsets.only(top: 13, left: 5),
                              child: Text(
                                attendanceEntryController
                                    .academicYearList[index].asmaYYear!,
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
                        onChanged: (s) {
                          selectedAcademicYear = s!;
                          logger.d(s.asmaYId);

                          setState(() {
                            selectedClass = null;
                            selectedSection = null;
                            selectedMonth = null;
                            selectedSubject = null;
                            selectedPeriod = null;
                            startDate.text = '';
                            endDate.text = '';
                          });
                          getClassData(s.asmaYId!.toInt());
                        },
                      ),
                    ),
                    attendanceEntryController.isClass.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
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
                            child: DropdownButtonFormField<ClassListValue>(
                              value: selectedClass,
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
                                hintText: attendanceEntryController
                                        .classList.isNotEmpty
                                    ? 'Select Class'
                                    : "No data available",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                isDense: true,
                                label: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFEBEA),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 6.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/class_.svg",
                                        height: 24.0,
                                        color: const Color(0xFFFF6F67),
                                      ),
                                      const SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        " Class ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .merge(
                                              const TextStyle(
                                                  fontSize: 20.0,
                                                  color: Color(0xFFFF6F67)),
                                            ),
                                      ),
                                    ],
                                  ),
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
                                  attendanceEntryController.classList.length,
                                  (index) {
                                return DropdownMenuItem(
                                  value: attendanceEntryController
                                      .classList[index],
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(top: 13, left: 5),
                                    child: Text(
                                      attendanceEntryController
                                          .classList[index].asmcLClassName!,
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
                              onChanged: (s) {
                                selectedClass = s!;
                                logger.d(s.asmcLId);
                                selectedSection = null;
                                selectedMonth = null;
                                startDate.text = '';
                                endDate.text = '';
                                getSectionData(s.asmcLId!.toInt());
                              },
                            ),
                          ),
                    attendanceEntryController.isSection.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : attendanceEntryController.classList.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
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
                                child:
                                    DropdownButtonFormField<SectionListValue>(
                                  value: selectedSection,
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
                                    isDense: true,
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .merge(const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.0,
                                            letterSpacing: 0.3)),
                                    hintText: attendanceEntryController
                                            .sectionList.isNotEmpty
                                        ? 'Select Section'
                                        : "No data available",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    label: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFDBFDF5),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 6.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/svg/section_.svg",
                                            height: 24.0,
                                            color: const Color(0xFF47BA9E),
                                          ),
                                          const SizedBox(
                                            width: 6.0,
                                          ),
                                          Text(
                                            " Section ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .merge(
                                                  const TextStyle(
                                                      fontSize: 20.0,
                                                      color: Color(0xFF47BA9E)),
                                                ),
                                          ),
                                        ],
                                      ),
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
                                      attendanceEntryController
                                          .sectionList.length, (index) {
                                    return DropdownMenuItem(
                                      value: attendanceEntryController
                                          .sectionList[index],
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 13, left: 5),
                                        child: Text(
                                          attendanceEntryController
                                              .sectionList[index]
                                              .asmCSectionName!,
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
                                  onChanged: (s) {
                                    selectedSection = s!;
                                    logger.d(s.asmSId);

                                    setState(() {
                                      selectedMonth = null;
                                      selectedSubject = null;
                                      selectedPeriod = null;
                                      startDate.text = '';
                                      endDate.text = '';
                                      todayDate.text = attendanceEntryController
                                                  .attendanceEntry.value ==
                                              'M'
                                          ? "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}"
                                          : "";
                                    });

                                    if (attendanceEntryController
                                            .attendanceEntry.value ==
                                        'P') {
                                      getSubjectList(s.asmSId!.toInt());
                                    }
                                  },
                                ),
                              )
                            : const SizedBox(),
                    (selectedSection != null)
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if (selectedAcademicYear == null) {
                                    Fluttertoast.showToast(
                                        msg: 'Select academic year');
                                  } else if (selectedClass == null) {
                                    Fluttertoast.showToast(msg: 'Select class');
                                  } else if (selectedSection == null) {
                                    Fluttertoast.showToast(
                                        msg: 'Select section');
                                  } else {
                                    showDialog(
                                        context: context,
                                        // barrierDismissible: false,
                                        builder: (context) {
                                          return Dialog(
                                            insetPadding:
                                                const EdgeInsets.all(10),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.0))),
                                            child: AttendanceRecordPopupScreen(
                                              loginSuccessModel:
                                                  widget.loginSuccessModel,
                                              mskoolController:
                                                  widget.mskoolController,
                                              asmayId: selectedAcademicYear!
                                                  .asmaYId!
                                                  .toInt(),
                                              asmclId: selectedClass!.asmcLId!
                                                  .toInt(),
                                              asmsId: selectedSection!.asmSId!
                                                  .toInt(),
                                              attentrytype: attendanceEntryController
                                                          .attendanceEntry
                                                          .value ==
                                                      'D'
                                                  ? 'dailyonce'
                                                  : attendanceEntryController
                                                              .attendanceEntry
                                                              .value ==
                                                          'H'
                                                      ? 'dailytwice'
                                                      : attendanceEntryController
                                                                  .attendanceEntry
                                                                  .value ==
                                                              'P'
                                                          ? 'period'
                                                          : attendanceEntryController
                                                                      .attendanceEntry
                                                                      .value ==
                                                                  'M'
                                                              ? 'monthly'
                                                              : '',
                                            ),
                                          );
                                        });
                                  }
                                },
                                // size: const Size.fromWidth(180),
                                child: const Text('View Records'),
                              ),
                            ),
                          )
                        : Container(),
                    attendanceEntryController.isSection.value
                        ? const SizedBox()
                        : attendanceEntryController.attendanceEntry.value ==
                                    'M' &&
                                selectedSection != null
                            ? Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
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
                                child: DropdownButtonFormField<MonthListValue>(
                                  value: selectedMonth,
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
                                    isDense: true,
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .merge(const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.0,
                                            letterSpacing: 0.3)),
                                    hintText: 'Select Month',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    label: Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            229, 243, 255, 1),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 6.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/svg/calendar_icon.svg",
                                            color: const Color(0xFF3E78AA),
                                            height: 18,
                                          ),
                                          const SizedBox(
                                            width: 6.0,
                                          ),
                                          Text(
                                            " Select Month ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .merge(
                                                  const TextStyle(
                                                    fontSize: 18.0,
                                                    color: Color.fromRGBO(
                                                        62, 120, 170, 1),
                                                  ),
                                                ),
                                          ),
                                        ],
                                      ),
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
                                      attendanceEntryController
                                          .monthList.length, (index) {
                                    return DropdownMenuItem(
                                      value: attendanceEntryController
                                          .monthList[index],
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, left: 5),
                                        child: Text(
                                          attendanceEntryController
                                              .monthList[index].ivrMMonthName!,
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
                                  onChanged: (s) {
                                    selectedMonth = s!;
                                    startDate.text =
                                        "${DateTime.now().year}/${s.ivrMMonthId!.toInt()}/1";
                                    selectedstartdate = DateTime(
                                        DateTime.now().year,
                                        s.ivrMMonthId!.toInt(),
                                        1);
                                    endDate.text =
                                        "${DateTime.now().year}/${s.ivrMMonthId!.toInt()}/"
                                        "${s.ivrMMonthId!.toInt() == 1 || s.ivrMMonthId!.toInt() == 3 || s.ivrMMonthId!.toInt() == 5 || s.ivrMMonthId!.toInt() == 7 || s.ivrMMonthId!.toInt() == 8 || s.ivrMMonthId!.toInt() == 10 || s.ivrMMonthId!.toInt() == 12 ? '31' : s.ivrMMonthId!.toInt() == 2 ? '28' : '30'}";
                                    selectedenddate = DateTime(
                                        DateTime.now().year,
                                        s.ivrMMonthId!.toInt(),
                                        s.ivrMMonthId!.toInt() == 1 ||
                                                s.ivrMMonthId!.toInt() == 3 ||
                                                s.ivrMMonthId!.toInt() == 5 ||
                                                s.ivrMMonthId!.toInt() == 7 ||
                                                s.ivrMMonthId!.toInt() == 8 ||
                                                s.ivrMMonthId!.toInt() == 10 ||
                                                s.ivrMMonthId!.toInt() == 12
                                            ? 31
                                            : s.ivrMMonthId!.toInt() == 2
                                                ? 28
                                                : 30);
                                    getStudentListOnChangeOfMonth(
                                        s.ivrMMonthId!.toInt());
                                  },
                                ),
                              )
                            : const SizedBox(),
                    attendanceEntryController.isSection.value
                        ? const SizedBox()
                        : (attendanceEntryController.attendanceEntry.value ==
                                        'D' ||
                                    attendanceEntryController
                                            .attendanceEntry.value ==
                                        'H' ||
                                    attendanceEntryController
                                            .attendanceEntry.value ==
                                        'P' ||
                                    attendanceEntryController
                                            .attendanceEntry.value ==
                                        'M') &&
                                selectedSection != null
                            ? Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 25),
                                child: CustomContainer(
                                  child: TextField(
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                    controller: todayDate,
                                    onTap: () async {
                                      showDatePicker(
                                        context: context,
                                        initialDate: selecteddate,
                                        firstDate: attendanceEntryController
                                                    .attendanceEntry.value ==
                                                'M'
                                            ? DateTime.now()
                                            : DateTime(
                                                selectedAcademicYear!
                                                    .asmaYFromDate!.year,
                                              ),
                                        lastDate: DateTime.now(),
                                      ).then((value) {
                                        if (value != null) {
                                          selecteddate = value;
                                          setState(() {
                                            todayDate.text =
                                                "${selecteddate.year}/${numberList[selecteddate.month]}/${numberList[selecteddate.day]}";
                                            selectedPeriod = null;
                                          });

                                          if (attendanceEntryController
                                                      .attendanceEntry.value ==
                                                  'D' ||
                                              attendanceEntryController
                                                      .attendanceEntry.value ==
                                                  'H') {
                                            getStudentListOnChangeOfSection(
                                                selectedSection!.asmSId
                                                    .toString());
                                          }
                                        }
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      label: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              229, 243, 255, 1),
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                        ),
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 6.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/svg/calendar_icon.svg",
                                              color: const Color(0xFF3E78AA),
                                              height: 18.0,
                                            ),
                                            const SizedBox(
                                              width: 6.0,
                                            ),
                                            Text(
                                              " Select Date ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .merge(
                                                    const TextStyle(
                                                      fontSize: 20.0,
                                                      color: Color.fromRGBO(
                                                          62, 120, 170, 1),
                                                    ),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      hintText: 'Select date.'.tr,
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: SvgPicture.asset(
                                          "assets/svg/calendar_icon.svg",
                                          color: const Color(0xFF3E78AA),
                                        ),
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                    readOnly: true,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                    attendanceEntryController.isSection.value
                        ? const SizedBox()
                        : attendanceEntryController.attendanceEntry.value ==
                                    'M' &&
                                selectedSection != null &&
                                selectedMonth != null
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomContainer(
                                        child: TextField(
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                          readOnly: true,
                                          controller: startDate,
                                          // onTap: () async {
                                          //   selectedstartdate =
                                          //       await showDatePicker(
                                          //     context: context,
                                          //     initialDate: DateTime(
                                          //       DateTime.now().year,
                                          //       selectedMonth!.ivrMMonthId!
                                          //           .toInt(),
                                          //     ),
                                          //     firstDate: DateTime(
                                          //         DateTime.now().year,
                                          //         selectedMonth!.ivrMMonthId!
                                          //             .toInt(),
                                          //         1),
                                          //     lastDate: DateTime(
                                          //         DateTime.now().year,
                                          //         selectedMonth!.ivrMMonthId!
                                          //             .toInt(),
                                          //         31),
                                          //   );

                                          //   if (selectedstartdate != null) {
                                          //     setState(() {
                                          //       startDate.text =
                                          //           "${numberList[selectedstartdate!.day]}-${numberList[selectedstartdate!.month]}-${selectedstartdate!.year}";
                                          //     });
                                          //   }
                                          // },
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: () {},
                                              icon: SvgPicture.asset(
                                                "assets/svg/calendar_icon.svg",
                                                color: const Color(0xFF3E78AA),
                                                height: 18,
                                              ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 48.0, left: 12),
                                            border: const OutlineInputBorder(),
                                            label: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 8.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          24.0),
                                                  color:
                                                      const Color(0xFFE5F3FF)),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SvgPicture.asset(
                                                    "assets/svg/calendar_icon.svg",
                                                    color:
                                                        const Color(0xFF3E78AA),
                                                    height: 18,
                                                  ),
                                                  const SizedBox(
                                                    width: 6.0,
                                                  ),
                                                  Text(
                                                    " Start Date ",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium!
                                                        .merge(
                                                          const TextStyle(
                                                            fontSize: 18.0,
                                                            color: Color(
                                                                0xFF3E78AA),
                                                          ),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            hintText: 'Select Date',
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12.0,
                                    ),
                                    Expanded(
                                      child: CustomContainer(
                                        child: TextField(
                                          readOnly: true,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                          controller: endDate,
                                          // onTap: () async {
                                          //   selectedenddate =
                                          //       await showDatePicker(
                                          //     context: context,
                                          //     initialDate: DateTime.now(),
                                          //     firstDate: DateTime(
                                          //         DateTime.now().year,
                                          //         selectedMonth!.ivrMMonthId!
                                          //             .toInt()),
                                          //     lastDate: DateTime.now(),
                                          //   );

                                          //   if (selectedenddate != null) {
                                          //     setState(() {
                                          //       endDate.text =
                                          //           "${numberList[selectedenddate!.day]}-${numberList[selectedenddate!.month]}-${selectedenddate!.year}";
                                          //     });
                                          //   }
                                          // },
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 48.0, left: 12),
                                            suffixIcon: IconButton(
                                              onPressed: () {},
                                              icon: SvgPicture.asset(
                                                "assets/svg/calendar_icon.svg",
                                                color: const Color(0xFF3E78AA),
                                                height: 18,
                                              ),
                                            ),
                                            border: const OutlineInputBorder(),
                                            label: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 8.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          24.0),
                                                  color:
                                                      const Color(0xFFE5F3FF)),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SvgPicture.asset(
                                                    "assets/svg/calendar_icon.svg",
                                                    color:
                                                        const Color(0xFF3E78AA),
                                                    height: 18,
                                                  ),
                                                  const SizedBox(
                                                    width: 6.0,
                                                  ),
                                                  Text(
                                                    " End Date ",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium!
                                                        .merge(
                                                          const TextStyle(
                                                              fontSize: 18.0,
                                                              color: Color(
                                                                  0xFF3E78AA)),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            hintText: 'Select Date',
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                    attendanceEntryController.isSubject.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : attendanceEntryController.isSection.value
                            ? const SizedBox()
                            : attendanceEntryController.attendanceEntry.value ==
                                        'P' &&
                                    selectedSection != null
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
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
                                        PWM.SubjectListValue>(
                                      value: selectedSubject,
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
                                        hintText: 'Select Subject',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        isDense: true,
                                        label: Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                229, 243, 255, 1),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 6.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                "assets/images/selectSub.png",
                                                height: 20.0,
                                              ),
                                              const SizedBox(
                                                width: 6.0,
                                              ),
                                              Text(
                                                " Select Subject ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .merge(
                                                      const TextStyle(
                                                        fontSize: 19.0,
                                                        color: Color.fromRGBO(
                                                            62, 120, 170, 1),
                                                      ),
                                                    ),
                                              ),
                                            ],
                                          ),
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
                                          attendanceEntryController
                                              .subjectList.length, (index) {
                                        return DropdownMenuItem(
                                          value: attendanceEntryController
                                              .subjectList[index],
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13, left: 5),
                                            child: Text(
                                              attendanceEntryController
                                                  .subjectList[index]
                                                  .ismSSubjectName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .merge(const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.3)),
                                            ),
                                          ),
                                        );
                                      }),
                                      onChanged: (s) {
                                        logger.d(s!.ismSId);
                                        selectedSubject = s;
                                        setState(() {
                                          selectedPeriod = null;
                                        });
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                    attendanceEntryController.isSubject.value
                        ? const SizedBox()
                        : attendanceEntryController.isSection.value ||
                                selectedSubject == null
                            ? const SizedBox()
                            : attendanceEntryController.attendanceEntry.value ==
                                        'P' &&
                                    selectedSection != null
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
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
                                        PeriodlistValue>(
                                      value: selectedPeriod,
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
                                        isDense: true,
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .merge(const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0,
                                                letterSpacing: 0.3)),
                                        hintText: 'Select Period',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        label: Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                238, 232, 255, 1),
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 6.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                'assets/images/selectPeriod.png',
                                                height: 20.0,
                                              ),
                                              const SizedBox(
                                                width: 6.0,
                                              ),
                                              Text(
                                                " Select Period ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .merge(
                                                      const TextStyle(
                                                        fontSize: 18.0,
                                                        color: Color.fromRGBO(
                                                            111, 88, 180, 1),
                                                      ),
                                                    ),
                                              ),
                                            ],
                                          ),
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
                                          attendanceEntryController
                                              .periodList.length, (index) {
                                        return DropdownMenuItem(
                                          value: attendanceEntryController
                                              .periodList[index],
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13, left: 5),
                                            child: Text(
                                              attendanceEntryController
                                                  .periodList[index]
                                                  .ttmPPeriodName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .merge(const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.3)),
                                            ),
                                          ),
                                        );
                                      }),
                                      onChanged: (s) {
                                        selectedPeriod = s!;
                                        logger.d(s.ttmPId);
                                        setState(() {});
                                        getStudentListOnChangeOfPeriod(
                                            s.ttmPId!.toInt());
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                    attendanceEntryController.isSubject.value
                        ? const SizedBox()
                        : attendanceEntryController.isSection.value ||
                                selectedPeriod == null
                            ? const SizedBox()
                            : attendanceEntryController.attendanceEntry.value ==
                                        'P' &&
                                    selectedSection != null
                                ? SizedBox(
                                    height: 33,
                                    child: RadioListTile(
                                      dense: true,
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8),
                                      visualDensity:
                                          const VisualDensity(horizontal: -4.0),
                                      title: Text(
                                        "Regular",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .merge(const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16.0,
                                                letterSpacing: 0.3)),
                                      ),
                                      value: "Regular",
                                      groupValue: selectedRadio,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedRadio = value.toString();
                                        });
                                        getStudentListOnChangeOfPeriod(
                                            selectedPeriod!.ttmPId!.toInt());
                                        logger.d(value);
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                    attendanceEntryController.isSubject.value
                        ? const SizedBox()
                        : attendanceEntryController.isSection.value ||
                                selectedPeriod == null
                            ? const SizedBox()
                            : attendanceEntryController.attendanceEntry.value ==
                                        'P' &&
                                    selectedSection != null
                                ? SizedBox(
                                    height: 33,
                                    child: RadioListTile(
                                      dense: true,
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8),
                                      visualDensity:
                                          const VisualDensity(horizontal: -4.0),
                                      title: Text(
                                        "Extra Period",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .merge(const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16.0,
                                                letterSpacing: 0.3)),
                                      ),
                                      value: "extraPeriod",
                                      groupValue: selectedRadio,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedRadio = value.toString();
                                        });
                                        getStudentListOnChangeOfPeriod(
                                            selectedPeriod!.ttmPId!.toInt());
                                        logger.d(value);
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                    const SizedBox(height: 80),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        attendanceEntryController.isStudentData.value
                            ? SizedBox(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size.fromWidth(180),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 26, vertical: 14.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                onPressed: () {
                                  if (selectedAcademicYear == null) {
                                    Fluttertoast.showToast(
                                        msg: 'Select academic year');
                                  } else if (selectedClass == null) {
                                    Fluttertoast.showToast(msg: 'Select class');
                                  } else if (selectedSection == null) {
                                    Fluttertoast.showToast(
                                        msg: 'Select section');
                                  } else if (todayDate.text.isEmpty) {
                                    Fluttertoast.showToast(msg: 'Select date');
                                  } else if (attendanceEntryController
                                          .attendanceEntry.value ==
                                      'M') {
                                    if (selectedMonth == null) {
                                      Fluttertoast.showToast(
                                          msg: 'Select month');
                                    } else if (startDate.text.isEmpty ||
                                        endDate.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg:
                                              'Select start date and end date.');
                                    } else if (attendanceEntryController
                                        .monthwiseStudentList.isNotEmpty) {
                                      Get.to(() =>
                                          MonthWiseAttendanceEntryDetailScreen(
                                            loginSuccessModel:
                                                widget.loginSuccessModel,
                                            mskoolController:
                                                widget.mskoolController,
                                            asaId: attendanceEntryController
                                                .asaId.value,
                                            asmayId: selectedAcademicYear!
                                                .asmaYId!
                                                .toInt(),
                                            asmclId:
                                                selectedClass!.asmcLId!.toInt(),
                                            asmsId: selectedSection!.asmSId!
                                                .toInt(),
                                            fromDate:
                                                selectedstartdate.toString(),
                                            classheld: attendanceEntryController
                                                .countClassHeld.value
                                                .toStringAsFixed(0),
                                            toDate: selectedenddate.toString(),
                                          ));
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please Enter The Number Of Class Held For Particular Month In Master Class Held");
                                    }
                                  } else if (attendanceEntryController
                                          .attendanceEntry.value ==
                                      'D') {
                                    if (attendanceEntryController
                                        .dailyOnceAndDailyTwiceStudentList
                                        .isNotEmpty) {
                                      Get.to(() =>
                                          DailyOnceAttendanceEntryDetailScreen(
                                            loginSuccessModel:
                                                widget.loginSuccessModel,
                                            mskoolController:
                                                widget.mskoolController,
                                            asaId: attendanceEntryController
                                                .asaId.value,
                                            asmayId: selectedAcademicYear!
                                                .asmaYId!
                                                .toInt(),
                                            asmclId:
                                                selectedClass!.asmcLId!.toInt(),
                                            asmsId: selectedSection!.asmSId!
                                                .toInt(),
                                            selectedDate: todayDate.text,
                                          ));
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Something went wrong..");
                                    }
                                  } else if (attendanceEntryController
                                          .attendanceEntry.value ==
                                      'H') {
                                    if (attendanceEntryController
                                        .dailyOnceAndDailyTwiceStudentList
                                        .isNotEmpty) {
                                      Get.to(() =>
                                          DailyTwiceAttendanceEntryDetailScreen(
                                            loginSuccessModel:
                                                widget.loginSuccessModel,
                                            mskoolController:
                                                widget.mskoolController,
                                            asaId: attendanceEntryController
                                                .asaId.value,
                                            asmayId: selectedAcademicYear!
                                                .asmaYId!
                                                .toInt(),
                                            asmclId:
                                                selectedClass!.asmcLId!.toInt(),
                                            asmsId: selectedSection!.asmSId!
                                                .toInt(),
                                            selectedDate: todayDate.text,
                                          ));
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Something went wrong..");
                                    }
                                  } else if (attendanceEntryController
                                          .attendanceEntry.value ==
                                      'P') {
                                    if (selectedSubject == null) {
                                      Fluttertoast.showToast(
                                          msg: "Select Subject.");
                                    } else if (selectedPeriod == null) {
                                      Fluttertoast.showToast(
                                          msg: "Select Peroid.");
                                    } else if (attendanceEntryController
                                        .periodwiseStudentList.isNotEmpty) {
                                      Get.to(() =>
                                          PeriodWiseAttendanceEntryDetailScreen(
                                            loginSuccessModel:
                                                widget.loginSuccessModel,
                                            mskoolController:
                                                widget.mskoolController,
                                            asaId: attendanceEntryController
                                                .asaId.value,
                                            asmayId: selectedAcademicYear!
                                                .asmaYId!
                                                .toInt(),
                                            asmclId:
                                                selectedClass!.asmcLId!.toInt(),
                                            asmsId: selectedSection!.asmSId!
                                                .toInt(),
                                            periodId:
                                                selectedPeriod!.ttmPId!.toInt(),
                                            selectedradio: selectedRadio,
                                            subjectId: selectedSubject!.ismSId!
                                                .toInt(),
                                            selectedDate: todayDate.text,
                                          ));
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "No data available...");
                                    }
                                  }
                                },
                                child: Text(
                                  'View Details',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .merge(
                                        const TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 0.3,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                ),
                              )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
