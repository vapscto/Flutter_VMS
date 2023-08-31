import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/api/attendance_entry_related_api.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/attendanceEntryRecordModel.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/dailyonceAndDailytwiceStudentListModel.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/initialdataModel.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/monthwiseStudentListModel.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/periodwiseStudentlistModel.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/sectionModel.dart';
import 'package:m_skool_flutter/staffs/attendance_entry/model/subjectModel.dart'
    as PWM;

class AttendanceEntryController extends GetxController {
  RxList<AcademicYearListValue> academicYearList =
      <AcademicYearListValue>[].obs;
  RxList<ClassListValue> classList = <ClassListValue>[].obs;
  RxList<SectionListValue> sectionList = <SectionListValue>[].obs;
  RxList<PWM.SubjectListValue> subjectList = <PWM.SubjectListValue>[].obs;
  RxList<PeriodlistValue> periodList = <PeriodlistValue>[].obs;
  RxList<MonthListValue> monthList = <MonthListValue>[].obs;
  RxList<ViewStudentPeriodWiseAttDetailsValue> attendanceEntryRecordList =
      <ViewStudentPeriodWiseAttDetailsValue>[].obs;
  RxList<CurrentYearValue> currentYear = <CurrentYearValue>[].obs;

  // student data list for table of monthwise attendance entry.
  RxList<MonthWiseStudentListValue> monthwiseStudentList =
      <MonthWiseStudentListValue>[].obs;
  // student data list for table of daily and dailytwice attendance entry.

  RxList<DailyOnceAndDailyTwiceStudentListValue>
      dailyOnceAndDailyTwiceStudentList =
      <DailyOnceAndDailyTwiceStudentListValue>[].obs;
  // student data list for table of periodwise attendance entry.

  RxList<PeroidWiseStudentListValue> periodwiseStudentList =
      <PeroidWiseStudentListValue>[].obs;

  RxList<TextEditingController> textEditingController =
      <TextEditingController>[].obs;
  RxList<bool> boolList = <bool>[].obs;
  RxList<bool> boolList2 = <bool>[].obs;
  RxInt updateButton = RxInt(0);

  RxString attendanceEntry = ''.obs;
  RxString attendanceEntryType = ''.obs;
  RxNum countClassHeld = RxNum(0.0);
  RxInt asaId = RxInt(0);

  RxBool isInitialData = RxBool(false);
  RxBool isClass = RxBool(false);
  RxBool isSection = RxBool(false);
  RxBool isStudentData = RxBool(false);
  RxBool isSubject = RxBool(false);
  RxBool isSave = RxBool(false);
  RxBool isViewRecord = RxBool(false);

  // void addToTextFeildList(TextEditingController value) {
  //   textEditingController.add(value);
  // }

  // void addToBoolList(bool value) {
  //   boolList.add(value);
  // }

  void isinitialdataloading(bool loading) async {
    isInitialData.value = loading;
  }

  void isclassloading(bool loading) async {
    isClass.value = loading;
  }

  void issectionloading(bool loading) async {
    isSection.value = loading;
  }

  void isstudentdataloading(bool loading) async {
    isStudentData.value = loading;
  }

  void issubjectloading(bool loading) async {
    isSubject.value = loading;
  }

  void issaveloading(bool loading) async {
    isSave.value = loading;
  }

  void isviewrecordloading(bool loading) async {
    isViewRecord.value = loading;
  }

  Future<bool> getAttendanceEntryInitialData({
    required int asmayId,
    required int userId,
    required int miId,
    required String username,
    required int roleId,
    required String base,
  }) async {
    InitialDataModel? initialDataModel = await getAttendanceEntryIntialData(
        asmayId: asmayId,
        userId: userId,
        miId: miId,
        username: username,
        roleId: roleId,
        base: base);
    try {
      if (initialDataModel!.academicYearList != null ||
          initialDataModel.academicYearList!.values != null) {
        academicYearList.clear();
        for (var i = 0;
            i < initialDataModel.academicYearList!.values!.length;
            i++) {
          academicYearList
              .add(initialDataModel.academicYearList!.values!.elementAt(i)!);
        }
      }

      // if (initialDataModel.classList != null ||
      //     initialDataModel.classList!.values != null) {
      //   classList.clear();
      //   for (var i = 0; i < initialDataModel.classList!.values!.length; i++) {
      //     classList.add(initialDataModel.classList!.values!.elementAt(i)!);
      //   }
      // }

      if (initialDataModel.monthList != null ||
          initialDataModel.monthList!.values != null) {
        monthList.clear();
        for (var i = 0; i < initialDataModel.monthList!.values!.length; i++) {
          monthList.add(initialDataModel.monthList!.values!.elementAt(i)!);
        }
      }
      if (initialDataModel.currentYear != null ||
          initialDataModel.currentYear!.values != null) {
        currentYear.add(initialDataModel.currentYear!.values!.first!);
      }

      if (initialDataModel.periodlist != null ||
          initialDataModel.periodlist!.values != null) {
        periodList.clear();
        for (var i = 0; i < initialDataModel.periodlist!.values!.length; i++) {
          periodList.add(initialDataModel.periodlist!.values!.elementAt(i)!);
        }
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getAttendanceEntryClassData({
    required int asmayId,
    required int userId,
    required int miId,
    required String username,
    required int roleId,
    required String base,
  }) async {
    InitialDataModel? initialDataModel = await getAttendanceEntryIntialData(
        asmayId: asmayId,
        userId: userId,
        miId: miId,
        username: username,
        roleId: roleId,
        base: base);
    try {
      if (initialDataModel!.classList != null ||
          initialDataModel.classList!.values != null) {
        classList.clear();
        for (var i = 0; i < initialDataModel.classList!.values!.length; i++) {
          classList.add(initialDataModel.classList!.values!.elementAt(i)!);
        }
        return true;
      }

      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getSection({
    required int asmayId,
    required String asmclId,
    required int miId,
    required String username,
    required int roleId,
    required int userId,
    required String base,
  }) async {
    SectionModel? sectionModel = await getSectionData(
        asmayId: asmayId,
        asmclId: asmclId,
        miId: miId,
        username: username,
        roleId: roleId,
        userId: userId,
        base: base);

    try {
      if (sectionModel!.sectionList != null ||
          sectionModel.sectionList!.values != null) {
        sectionList.clear();
        attendanceEntryType.value = '';
        attendanceEntry.value = '';
        for (var i = 0; i < sectionModel.sectionList!.values!.length; i++) {
          sectionList.add(sectionModel.sectionList!.values!.elementAt(i)!);
        }
        attendanceEntry.value = sectionModel.asAAttEntryType!;
        attendanceEntryType.value = sectionModel.attendanceentryflag!;
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getAttendanceDataOnchangeofMonth({
    required int miId,
    required int asmayId,
    required int asmclId,
    required int asmsId,
    required int monthId,
    required String base,
  }) async {
    MonthWiseStudentListModel? studentListModel =
        await getAttendanceDataOnChangeofMonth(
            miId: miId,
            asmayId: asmayId,
            asmclId: asmclId,
            asmsId: asmsId,
            monthId: monthId,
            base: base);
    monthwiseStudentList.clear();
    try {
      if (studentListModel!.studentList != null ||
          studentListModel.studentList!.values != null) {
        for (var i = 0; i < studentListModel.studentList!.values!.length; i++) {
          monthwiseStudentList
              .add(studentListModel.studentList!.values!.elementAt(i)!);
          textEditingController.add(TextEditingController(
              text: studentListModel.studentList!.values!
                  .elementAt(i)!
                  .pdays!
                  .toString()));
        }
        countClassHeld.value = studentListModel.countclass!;
        attendanceEntryType.value = studentListModel.attendanceentryflag!;
        asaId.value = studentListModel.asAId!;
        updateButton.value = studentListModel.countclass1!;
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getAttendanceDataOnChangeOfSection({
    required int asmayId,
    required int userId,
    required int miId,
    required String username,
    required int roleId,
    required String fromDate,
    required String asmclId,
    required String asmsId,
    required String monthFlag,
    required String monthFlag1,
    required String base,
  }) async {
    DailyOnceAndDailyTwiceStudentListModel? studentListModel1 =
        await onChangeOfSection(
            asmayId: asmayId,
            userId: userId,
            miId: miId,
            username: username,
            roleId: roleId,
            fromDate: fromDate,
            asmclId: asmclId,
            asmsId: asmsId,
            monthFlag: monthFlag,
            monthFlag1: monthFlag1,
            base: base);

    try {
      if (studentListModel1!.studentList != null ||
          studentListModel1.studentList!.values != null) {
        dailyOnceAndDailyTwiceStudentList.clear();
        boolList.clear();
        for (var i = 0;
            i < studentListModel1.studentList!.values!.length;
            i++) {
          dailyOnceAndDailyTwiceStudentList
              .add(studentListModel1.studentList!.values!.elementAt(i)!);
          if (studentListModel1.asaAttEntryType == 'D') {
            if (studentListModel1.attendanceEntryFlag == 'A') {
              logger.d(
                  "Pdays -> ${studentListModel1.studentList!.values!.elementAt(i)!.pdays}");
              if (studentListModel1.studentList!.values!.elementAt(i)!.pdays ==
                  null) {
                logger.d("message1");
                boolList.add(false);
              } else if (studentListModel1.studentList!.values!
                      .elementAt(i)!
                      .pdays! ==
                  0.00) {
                logger.d("message");
                boolList.add(true);
              } else {
                logger.d("message2");
                boolList.add(false);
              }
            } else if (studentListModel1.attendanceEntryFlag == 'P') {
              if (studentListModel1.studentList!.values!.elementAt(i)!.pdays ==
                  null) {
                boolList.add(false);
              } else if (studentListModel1.studentList!.values!
                      .elementAt(i)!
                      .pdays! >
                  0.00) {
                boolList.add(true);
              } else {
                boolList.add(false);
              }
            }
          } else if (studentListModel1.asaAttEntryType == 'H') {
            if (studentListModel1.attendanceEntryFlag == 'A') {
              if (studentListModel1.studentList!.values!.elementAt(i)!.pdays ==
                  null) {
                boolList.add(false);
                boolList2.add(false);
              } else if (studentListModel1.studentList!.values!
                      .elementAt(i)!
                      .pdays! ==
                  0.50) {
                if (studentListModel1.studentList!.values!
                        .elementAt(i)!
                        .asaDailytwiceFlag ==
                    'firsthalf') {
                  boolList.add(false);
                  boolList2.add(true);
                } else if (studentListModel1.studentList!.values!
                        .elementAt(i)!
                        .asaDailytwiceFlag ==
                    'Secondhalf') {
                  boolList.add(true);
                  boolList2.add(false);
                }
              } else if (studentListModel1.studentList!.values!
                      .elementAt(i)!
                      .pdays! ==
                  1.00) {
                boolList.add(false);
                boolList2.add(false);
              } else if (studentListModel1.studentList!.values!
                      .elementAt(i)!
                      .pdays! ==
                  0.00) {
                boolList.add(true);
                boolList2.add(true);
              } else {
                boolList.add(false);
                boolList2.add(false);
              }
            } else if (studentListModel1.attendanceEntryFlag == 'P') {
              if (studentListModel1.studentList!.values!.elementAt(i)!.pdays ==
                  null) {
                boolList.add(false);
              } else if (studentListModel1.studentList!.values!
                      .elementAt(i)!
                      .pdays! ==
                  0.50) {
                if (studentListModel1.studentList!.values!
                        .elementAt(i)!
                        .asaDailytwiceFlag ==
                    'firsthalf') {
                  boolList.add(true);
                  boolList2.add(false);
                } else if (studentListModel1.studentList!.values!
                        .elementAt(i)!
                        .asaDailytwiceFlag ==
                    'Secondhalf') {
                  boolList.add(false);
                  boolList2.add(true);
                }
              } else if (studentListModel1.studentList!.values!
                      .elementAt(i)!
                      .pdays! ==
                  1.00) {
                boolList.add(true);
                boolList2.add(true);
              } else {
                boolList.add(false);
                boolList2.add(false);
              }
            }
          }
        }
        asaId.value = studentListModel1.asAId!;
        attendanceEntryType.value = studentListModel1.attendanceEntryFlag!;
        updateButton.value = studentListModel1.countclass1!;
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getSubjectListOnChangeSection({
    required int asmayId,
    required String asmclId,
    required int asmsId,
    required int userId,
    required int miId,
    required String username,
    required int roleId,
    required String base,
  }) async {
    PWM.SubjectModel? subjectModel = await onChangeSection(
        asmayId: asmayId,
        asmclId: asmclId,
        asmsId: asmsId,
        userId: userId,
        miId: miId,
        username: username,
        roleId: roleId,
        base: base);
    try {
      if (subjectModel!.subjectList != null ||
          subjectModel.subjectList!.values != null) {
        subjectList.clear();
        for (var i = 0; i < subjectModel.subjectList!.values!.length; i++) {
          subjectList.add(subjectModel.subjectList!.values!.elementAt(i)!);
        }
        return true;
      }
      // if (subjectModel.studentList != null ||
      //     subjectModel.studentList!.values != null) {
      //   studentList2.clear();
      //   for (var i = 0; i < subjectModel.studentList!.values!.length; i++) {
      //     studentList2.add(subjectModel.studentList!.values!.elementAt(i)!);
      //   }
      //   asaId.value = subjectModel.asAId!;
      //   return true;
      // }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getStudentListOnChangePeriod({
    required int asmayId,
    required int asmclId,
    required int asmsId,
    required int ttmpId,
    required int ismsId,
    required int miId,
    required String fromeDate,
    required String base,
  }) async {
    PeriodWiseStudentListModel? periodWiseStudentListModel =
        await onChangeOfPeriod(
            asmayId: asmayId,
            asmclId: asmclId,
            asmsId: asmsId,
            ttmpId: ttmpId,
            ismsId: ismsId,
            miId: miId,
            fromDate: fromeDate,
            base: base);
    try {
      if (periodWiseStudentListModel!.studentList != null ||
          periodWiseStudentListModel.studentList!.values != null) {
        for (var i = 0;
            i < periodWiseStudentListModel.studentList!.values!.length;
            i++) {
          periodwiseStudentList.add(
              periodWiseStudentListModel.studentList!.values!.elementAt(i)!);
          if (periodWiseStudentListModel.attendanceEntryFlag == 'A') {
            if (periodWiseStudentListModel.studentList!.values!
                    .elementAt(i)!
                    .pdays! ==
                0.00) {
              boolList.add(true);
            } else {
              boolList.add(false);
            }
          } else if (periodWiseStudentListModel.attendanceEntryFlag == 'P') {
            if (periodWiseStudentListModel.studentList!.values!
                    .elementAt(i)!
                    .pdays! >
                0.00) {
              boolList.add(true);
            } else {
              boolList.add(false);
            }
          }
        }
        asaId.value = periodWiseStudentListModel.asAId!;
        attendanceEntryType.value =
            periodWiseStudentListModel.attendanceEntryFlag!;
        updateButton.value = periodWiseStudentListModel.countclass1!;
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getAttendanceEntryRecord({
    required String base,
    required int miId,
    required int asmayId,
    required int asmclId,
    required int asmsId,
    required String username,
    required int userId,
    required String attentrytype,
  }) async {
    attendanceEntryRecordList.clear();
    AttendanceEntryRecordModel? attendanceEntryRecordModel =
        await getAttendanceEntryRecords(
            base: base,
            miId: miId,
            asmayId: asmayId,
            asmclId: asmclId,
            asmsId: asmsId,
            username: username,
            userId: userId,
            attentrytype: attentrytype);
    try {
      if (attendanceEntryRecordModel!.viewStudentPeriodWiseAttDetails != null ||
          attendanceEntryRecordModel.viewStudentPeriodWiseAttDetails!.values !=
              null) {
        for (var i = 0;
            i <
                attendanceEntryRecordModel
                    .viewStudentPeriodWiseAttDetails!.values!.length;
            i++) {
          attendanceEntryRecordList.add(attendanceEntryRecordModel
              .viewStudentPeriodWiseAttDetails!.values!
              .elementAt(i)!);
        }
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }
}
