import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/staffs/marks_entry/widget/dropdown_label.dart';
import 'package:m_skool_flutter/staffs/student_attendance_staff/controller/student_attendance_related_controller.dart';
import 'package:m_skool_flutter/staffs/student_attendance_staff/model/initialData.dart';
import 'package:m_skool_flutter/staffs/student_attendance_staff/model/studentModel.dart';
import 'package:m_skool_flutter/staffs/student_attendance_staff/screen/consolidated_monthly_student_attendance_detail_screen.dart';
import 'package:m_skool_flutter/staffs/student_attendance_staff/widget/selectdatefromtodate.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';
import 'package:m_skool_flutter/widget/staff_home_fab.dart';

class StudentAttendanceStaffHome extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const StudentAttendanceStaffHome({
    super.key,
    required this.loginSuccessModel,
    required this.mskoolController,
  });

  @override
  State<StudentAttendanceStaffHome> createState() =>
      _StudentAttendanceStaffHomeState();
}

class _StudentAttendanceStaffHomeState
    extends State<StudentAttendanceStaffHome> {
  final StudentAttendanceController studentAttendanceController =
      Get.put(StudentAttendanceController());

  AcademicListValue? selectedAcademicYear;
  ClasslistValue? selectedClass;
  SectionListValue? selectedSection;
  MonthListValue? selectedMonth;
  StudentListValue? selectedStudent;

  var todayDate = TextEditingController();
  DateTime? selectedfromdate;
  DateTime? selectedtodate;
  String nameOrAdm = '';

  int selectedRadio = 1;
  int configuration = 1;

  void getAcademicYearDropdown() async {
    studentAttendanceController.isacademicyearloading(true);
    await studentAttendanceController
        .getInitialData(
          base: baseUrlFromInsCode('admission', widget.mskoolController),
          miId: widget.loginSuccessModel.mIID!,
          asmayId: widget.loginSuccessModel.asmaYId!,
          roleId: widget.loginSuccessModel.roleId!,
          userId: widget.loginSuccessModel.userId!,
          username: widget.loginSuccessModel.userName!,
        )
        .then((value) {});
    studentAttendanceController.isacademicyearloading(false);
  }

  void getStudentListData(String type1) async {
    studentAttendanceController.isstudentloading(true);
    await studentAttendanceController
        .getStudentListData(
          asmayId: selectedAcademicYear!.asmaYId!.toInt(),
          asmclId: selectedClass!.asmcLId!.toInt(),
          asmsId: selectedSection!.asmSId!.toInt(),
          radiotype: configuration,
          type1: type1,
          miId: widget.loginSuccessModel.mIID!,
          base: baseUrlFromInsCode(
            'admission',
            widget.mskoolController,
          ),
        )
        .then((value) {});
    studentAttendanceController.isstudentloading(false);
  }

  void getAttendaceDetail() async {
    studentAttendanceController.isdetailloading(true);
    await studentAttendanceController
        .getStudentAttendanceDetails(
      asmayId: selectedAcademicYear!.asmaYId!.toInt(),
      asmclId: selectedClass!.asmcLId!.toInt(),
      asmsId: selectedSection!.asmSId!.toInt(),
      monthId: configuration == 1 ? selectedMonth!.amMId!.toInt() : 0,
      radioType: configuration,
      datewise: configuration == 2 ? 1 : 0,
      fromdate: configuration != 1
          ? selectedfromdate.toString()
          : DateTime.now().toString(),
      todate: configuration == 2
          ? selectedtodate.toString()
          : DateTime.now().toString(),
      type: selectedRadio,
      amstId: selectedRadio == 1 ? 0 : selectedStudent!.amstId!,
      miId: widget.loginSuccessModel.mIID!,
      base: baseUrlFromInsCode(
        'admission',
        widget.mskoolController,
      ),
    )
        .then((value) {
      logger.d(value);
      if (value) {
        if (studentAttendanceController.studentAttendanceDetailsList.isEmpty) {
          Fluttertoast.showToast(msg: 'No data available.');
          return;
        }
        Get.to(() => ConsolidatedMonthlyStudentAttendanceDetailScreen(
              loginSuccessModel: widget.loginSuccessModel,
              mskoolController: widget.mskoolController,
            ));
      }
    });
    studentAttendanceController.isdetailloading(false);
  }

  void getFromDate(DateTime fromdate) {
    selectedfromdate = fromdate;
  }

  void getEndDate(DateTime toDate) {
    selectedtodate = toDate;
  }

  @override
  void initState() {
    getAcademicYearDropdown();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomGoBackButton(),
        leadingWidth: 25,
        title: const Text('Student Attendance'),
      ),
      floatingActionButton:const HomeFab(),
      //  StaffHomeFab(
      //   loginSuccessModel: widget.loginSuccessModel,
      //   mskoolController: widget.mskoolController,
      // ),
      body: Obx(
        () => studentAttendanceController.isAcademicYear.value
            ? const Center(
                child: AnimatedProgressWidget(
                    title: "Loading Student Attendance",
                    desc:
                        "Please wait while we load student attendance and create a view for you.",
                    animationPath: "assets/json/default.json"),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      child: DropdownButtonFormField<AcademicListValue>(
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
                          hintText: studentAttendanceController
                                  .academicYearList.isNotEmpty
                              ? 'Select Year'
                              : 'No data available',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isDense: true,
                          label: const CustomDropDownLabel(
                            icon: 'assets/images/hat.png',
                            containerColor: Color.fromRGBO(223, 251, 254, 1),
                            text: 'Academic Year',
                            textColor: Color.fromRGBO(40, 182, 200, 1),
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
                            studentAttendanceController.academicYearList.length,
                            (index) {
                          return DropdownMenuItem(
                            value: studentAttendanceController
                                .academicYearList[index],
                            child: Padding(
                              padding: const EdgeInsets.only(top: 13, left: 5),
                              child: Text(
                                studentAttendanceController
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
                        },
                      ),
                    ),
                    Container(
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
                      child: DropdownButtonFormField<ClasslistValue>(
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
                          hintText:
                              studentAttendanceController.classList.isNotEmpty
                                  ? 'Select Class'
                                  : 'No data available',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isDense: true,
                          label: const CustomDropDownLabel(
                            icon: 'assets/images/classnew.png',
                            containerColor: Color.fromRGBO(255, 235, 234, 1),
                            text: 'Class',
                            textColor: Color.fromRGBO(255, 111, 103, 1),
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
                            studentAttendanceController.classList.length,
                            (index) {
                          return DropdownMenuItem(
                            value: studentAttendanceController.classList[index],
                            child: Padding(
                              padding: const EdgeInsets.only(top: 13, left: 5),
                              child: Text(
                                studentAttendanceController
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
                        },
                      ),
                    ),
                    Container(
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
                      child: DropdownButtonFormField<SectionListValue>(
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
                          hintStyle: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .merge(const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                  letterSpacing: 0.3)),
                          hintText:
                              studentAttendanceController.sectionList.isNotEmpty
                                  ? 'Select section'
                                  : "No data available",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          isDense: true,
                          label: const CustomDropDownLabel(
                            icon: 'assets/images/sectionnew.png',
                            containerColor: Color.fromRGBO(219, 253, 245, 1),
                            text: 'Section',
                            textColor: Color.fromRGBO(71, 186, 158, 1),
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
                            studentAttendanceController.sectionList.length,
                            (index) {
                          return DropdownMenuItem(
                            value:
                                studentAttendanceController.sectionList[index],
                            child: Padding(
                              padding: const EdgeInsets.only(top: 13, left: 5),
                              child: Text(
                                studentAttendanceController
                                    .sectionList[index].asmCSectionName!,
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
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.1,
                                child: Radio(
                                  visualDensity:
                                      const VisualDensity(horizontal: -4.0),
                                  activeColor: Theme.of(context).primaryColor,
                                  value: 1,
                                  groupValue: selectedRadio,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRadio = value!;
                                      selectedStudent = null;
                                      selectedMonth = null;
                                      nameOrAdm = '';
                                    });
                                  },
                                ),
                              ),
                              Text(
                                "Consolidated",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                        letterSpacing: 0.3)),
                              ),
                            ],
                          ),
                          const SizedBox(width: 30),
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.1,
                                child: Radio(
                                  visualDensity:
                                      const VisualDensity(horizontal: -4.0),
                                  activeColor: Theme.of(context).primaryColor,
                                  value: 2,
                                  groupValue: selectedRadio,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRadio = value!;
                                      selectedStudent = null;
                                      selectedMonth = null;
                                      nameOrAdm = '';
                                    });
                                  },
                                ),
                              ),
                              Text(
                                "Detailed",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                        letterSpacing: 0.3)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Select Configuration',
                        style: Theme.of(context).textTheme.labelSmall!.merge(
                            const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                                letterSpacing: 0.3)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.1,
                                child: Radio(
                                  visualDensity:
                                      const VisualDensity(horizontal: -4.0),
                                  activeColor: Theme.of(context).primaryColor,
                                  value: 1,
                                  groupValue: configuration,
                                  onChanged: (value) {
                                    setState(() {
                                      configuration = value!;
                                      selectedfromdate = null;
                                      todayDate.text = '';
                                      selectedtodate = null;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                "Monthly",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                        letterSpacing: 0.3)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.1,
                                child: Radio(
                                  visualDensity:
                                      const VisualDensity(horizontal: -4.0),
                                  activeColor: Theme.of(context).primaryColor,
                                  value: 2,
                                  groupValue: configuration,
                                  onChanged: (value) {
                                    setState(() {
                                      configuration = value!;
                                      selectedfromdate = null;
                                      todayDate.text = '';
                                      selectedtodate = null;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                "Betn days",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                        letterSpacing: 0.3)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.1,
                                child: Radio(
                                  visualDensity:
                                      const VisualDensity(horizontal: -4.0),
                                  activeColor: Theme.of(context).primaryColor,
                                  value: 3,
                                  groupValue: configuration,
                                  onChanged: (value) {
                                    setState(() {
                                      configuration = value!;
                                      selectedfromdate = null;
                                      todayDate.text = '';
                                      selectedtodate = null;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                "Date Wise",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                        letterSpacing: 0.3)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (configuration == 1) const SizedBox(height: 10),
                    configuration == 1
                        ? Container(
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
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                        letterSpacing: 0.3)),
                                hintText: studentAttendanceController
                                        .monthList.isNotEmpty
                                    ? 'Select month'
                                    : 'No data available',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                isDense: true,
                                label: const CustomDropDownLabel(
                                  icon: 'assets/images/darkbluecalendar.png',
                                  containerColor:
                                      Color.fromRGBO(229, 243, 255, 1),
                                  text: 'Select Month',
                                  textColor: Color.fromRGBO(62, 120, 170, 1),
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
                                  studentAttendanceController.monthList.length,
                                  (index) {
                                return DropdownMenuItem(
                                  value: studentAttendanceController
                                      .monthList[index],
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(top: 13, left: 5),
                                    child: Text(
                                      studentAttendanceController
                                          .monthList[index].amMName!,
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
                              },
                            ),
                          )
                        : configuration == 3
                            ? Container(
                                margin: const EdgeInsets.only(
                                    left: 16, right: 16, top: 25, bottom: 10),
                                child: CustomContainer(
                                  child: TextField(
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                    controller: todayDate,
                                    onTap: () async {
                                      selectedfromdate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2005),
                                        lastDate: DateTime.now(),
                                      );

                                      if (selectedfromdate != null) {
                                        setState(() {
                                          todayDate.text =
                                              "${numberList[selectedfromdate!.day]}-${numberList[selectedfromdate!.month]}-${selectedfromdate!.year}";
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      label: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        child: const CustomDropDownLabel(
                                          icon:
                                              'assets/images/darkbluecalendar.png',
                                          containerColor:
                                              Color.fromRGBO(229, 243, 255, 1),
                                          text: 'Select Date',
                                          textColor:
                                              Color.fromRGBO(62, 120, 170, 1),
                                        ),
                                      ),
                                      hintText: 'Select date.'.tr,
                                      suffixIcon: Image.asset(
                                        'assets/images/darkbluecalendar.png',
                                        color: const Color(0xFF3E78AA),
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
                            : SelectDateFromToDate(
                                function: getFromDate,
                                function1: getEndDate,
                              ),
                    selectedRadio == 2
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.1,
                                      child: Radio(
                                        visualDensity: const VisualDensity(
                                            horizontal: -4.0),
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        value: 'name',
                                        groupValue: nameOrAdm,
                                        onChanged: (value) {
                                          if (selectedAcademicYear == null) {
                                            Fluttertoast.showToast(
                                                msg: 'Select academic year');
                                          } else if (selectedClass == null) {
                                            Fluttertoast.showToast(
                                                msg: 'Select class');
                                          } else if (selectedSection == null) {
                                            Fluttertoast.showToast(
                                                msg: 'Select section');
                                          } else {
                                            setState(() {
                                              nameOrAdm = value!;
                                              selectedStudent = null;
                                            });
                                            getStudentListData(value!);
                                          }
                                        },
                                      ),
                                    ),
                                    Text(
                                      "Name",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .merge(const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                              letterSpacing: 0.3)),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 30),
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 1.1,
                                      child: Radio(
                                        visualDensity: const VisualDensity(
                                            horizontal: -4.0),
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        value: 'admno',
                                        groupValue: nameOrAdm,
                                        onChanged: (value) {
                                          if (selectedAcademicYear == null) {
                                            Fluttertoast.showToast(
                                                msg: 'Select academic year');
                                          } else if (selectedClass == null) {
                                            Fluttertoast.showToast(
                                                msg: 'Select class');
                                          } else if (selectedSection == null) {
                                            Fluttertoast.showToast(
                                                msg: 'Select section');
                                          } else {
                                            setState(() {
                                              nameOrAdm = value!;
                                              selectedStudent = null;
                                            });
                                            getStudentListData(value!);
                                          }
                                        },
                                      ),
                                    ),
                                    Text(
                                      "Admin No.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .merge(const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                              letterSpacing: 0.3)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 15),
                    selectedRadio == 2
                        ? studentAttendanceController.isStudent.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container(
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
                                    DropdownButtonFormField<StudentListValue>(
                                  isExpanded: true,
                                  value: selectedStudent,
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
                                    hintText: studentAttendanceController
                                            .studentList.isNotEmpty
                                        ? 'Select student'
                                        : 'No data available',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    isDense: true,
                                    label: const CustomDropDownLabel(
                                      icon: 'assets/images/profileiconsa.png',
                                      containerColor:
                                          Color.fromRGBO(238, 232, 255, 1),
                                      text: 'Select Student',
                                      textColor:
                                          Color.fromRGBO(111, 88, 180, 1),
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
                                      studentAttendanceController
                                          .studentList.length, (index) {
                                    return DropdownMenuItem(
                                      value: studentAttendanceController
                                          .studentList[index],
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 13,
                                          left: 5,
                                        ),
                                        child: Text(
                                          studentAttendanceController
                                              .studentList[index].name!,
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
                                    selectedStudent = s!;
                                  },
                                ),
                              )
                        : const SizedBox(),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromWidth(150),
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 26, vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          if (selectedAcademicYear == null) {
                            Fluttertoast.showToast(msg: 'Select academic year');
                          } else if (selectedClass == null) {
                            Fluttertoast.showToast(msg: 'Select class');
                          } else if (selectedSection == null) {
                            Fluttertoast.showToast(msg: 'Select section');
                          } else if (configuration == 1 &&
                              selectedMonth == null) {
                            Fluttertoast.showToast(msg: 'Select month');
                          } else if (configuration == 2 &&
                              (selectedfromdate == null ||
                                  selectedtodate == null)) {
                            Fluttertoast.showToast(msg: 'Select date');
                          } else if (configuration == 3 &&
                              selectedfromdate == null) {
                            Fluttertoast.showToast(msg: 'Select date');
                          } else if (selectedRadio == 2 && nameOrAdm.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Select Name or AdminNo');
                          } else if (selectedRadio == 2 &&
                              selectedStudent == null) {
                            Fluttertoast.showToast(msg: 'Select student');
                          } else {
                            getAttendaceDetail();
                          }
                        },
                        child: studentAttendanceController.isDetail.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Search',
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
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
      ),
    );
  }
}
