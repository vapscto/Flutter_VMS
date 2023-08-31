import 'package:get/get.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/staffs/student_attendance_staff/model/initialData.dart';
import 'package:m_skool_flutter/staffs/student_attendance_staff/model/studentAttendanceDetailModel.dart';
import 'package:m_skool_flutter/staffs/student_attendance_staff/model/studentModel.dart';

import '../api/student_attendance_related_api.dart';

class StudentAttendanceController extends GetxController {
  RxList<AcademicListValue> academicYearList = <AcademicListValue>[].obs;
  RxList<ClasslistValue> classList = <ClasslistValue>[].obs;
  RxList<SectionListValue> sectionList = <SectionListValue>[].obs;
  RxList<MonthListValue> monthList = <MonthListValue>[].obs;
  RxList<StudentListValue> studentList = <StudentListValue>[].obs;
  RxList<StudentAttendanceListValue> studentAttendanceDetailsList =
      <StudentAttendanceListValue>[].obs;

  RxBool isAcademicYear = RxBool(false);
  RxBool isStudent = RxBool(false);
  RxBool isDetail = RxBool(false);

  void isacademicyearloading(bool loading) {
    isAcademicYear.value = loading;
  }

  void isstudentloading(bool loading) {
    isStudent.value = loading;
  }

  void isdetailloading(bool loading) {
    isDetail.value = loading;
  }

  Future<bool> getInitialData({
    required String base,
    required int miId,
    required int asmayId,
    required String username,
    required int roleId,
    required int userId,
  }) async {
    InitialDataModel? initialDataModel = await getStudentAttendanceInitialData(
        base: base,
        miId: miId,
        asmayId: asmayId,
        username: username,
        roleId: roleId,
        userId: userId);
    try {
      if (initialDataModel!.academicList != null ||
          initialDataModel.academicList!.values != null) {
        academicYearList.clear();
        for (var i = 0;
            i < initialDataModel.academicList!.values!.length;
            i++) {
          academicYearList
              .add(initialDataModel.academicList!.values!.elementAt(i)!);
        }
      }
      if (initialDataModel.classList != null ||
          initialDataModel.classList!.values != null) {
        classList.clear();
        for (var i = 0; i < initialDataModel.classList!.values!.length; i++) {
          classList.add(initialDataModel.classList!.values!.elementAt(i)!);
        }
      }
      if (initialDataModel.sectionList != null ||
          initialDataModel.sectionList!.values != null) {
        sectionList.clear();
        for (var i = 0; i < initialDataModel.sectionList!.values!.length; i++) {
          sectionList.add(initialDataModel.sectionList!.values!.elementAt(i)!);
        }
      }
      if (initialDataModel.monthList != null ||
          initialDataModel.monthList!.values != null) {
        monthList.clear();
        for (var i = 0; i < initialDataModel.monthList!.values!.length; i++) {
          monthList.add(initialDataModel.monthList!.values!.elementAt(i)!);
        }
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getStudentListData({
    required int asmayId,
    required int asmclId,
    required int asmsId,
    required int radiotype,
    required String type1,
    required int miId,
    required String base,
  }) async {
    StudentModel? studentModel = await getStudentData(
        asmayId: asmayId,
        asmclId: asmclId,
        asmsId: asmsId,
        radiotype: radiotype,
        type1: type1,
        miId: miId,
        base: base);
    try {
      if (studentModel!.studentAttendanceList != null ||
          studentModel.studentAttendanceList!.values != null) {
        studentList.clear();
        for (var i = 0;
            i < studentModel.studentAttendanceList!.values!.length;
            i++) {
          studentList
              .add(studentModel.studentAttendanceList!.values!.elementAt(i)!);
        }
        return true;
      }
      return false;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> getStudentAttendanceDetails({
    required int asmayId,
    required int asmclId,
    required int asmsId,
    required int monthId,
    required int radioType,
    required int datewise,
    required String fromdate,
    required String todate,
    required int type,
    required int amstId,
    required int miId,
    required String base,
  }) async {
    StudentAttendanceDetailModel? studentAttendanceDetailModel =
        await getStudentAttendanceDetail(
      asmayId: asmayId,
      asmclId: asmclId,
      asmsId: asmsId,
      radioType: radioType,
      datewise: datewise,
      type: type,
      miId: miId,
      base: base,
      amstId: amstId,
      fromdate: fromdate,
      monthId: monthId,
      todate: todate,
    );
    try {
      if (studentAttendanceDetailModel!.studentAttendanceList != null ||
          studentAttendanceDetailModel.studentAttendanceList!.values != null) {
        studentAttendanceDetailsList.clear();
        for (var i = 0;
            i <
                studentAttendanceDetailModel
                    .studentAttendanceList!.values!.length;
            i++) {
          studentAttendanceDetailsList.add(studentAttendanceDetailModel
              .studentAttendanceList!.values!
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
