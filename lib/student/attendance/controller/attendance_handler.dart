import 'package:get/get.dart';
import 'package:m_skool_flutter/student/attendance/model/academic_year_model.dart';
import 'package:m_skool_flutter/student/attendance/model/attendance_detail_model.dart';

class AttendanceHandler extends GetxController {
  RxList<AttyearlistValues> academicYearList = RxList<AttyearlistValues>();
  void updateAcademicYearList(List<AttyearlistValues> attList) {
    if (academicYearList.isNotEmpty) {
      academicYearList.clear();
    }
    academicYearList.addAll(attList);
  }

  RxBool errorHappend = RxBool(false);
  void updateErrorHappend(bool isError) {
    errorHappend.value = isError;
  }

  RxBool isLoadingWholeScreen = RxBool(true);
  void updateIsLoadingWholeScreen(bool loading) {
    isLoadingWholeScreen.value = loading;
  }

  RxBool isLoadingAttendanceDetails = RxBool(false);
  void updateIsLoadingAttendanceDetails(bool load) {
    isLoadingAttendanceDetails.value = load;
  }

  Rx<AttyearlistValues> selectedInDorpDown =
      Rx<AttyearlistValues>(AttyearlistValues());
  void updateSelectedInDropDown(AttyearlistValues newSelectedValue) {
    selectedInDorpDown.value = newSelectedValue;
  }

  RxInt asmayId = RxInt(0);
  void updateAsmayId(int newId) {
    asmayId.value = newId;
  }

  RxList<AttendanceDetailValues> attendanceData =
      RxList<AttendanceDetailValues>();
  void updateAttendanceData(List<AttendanceDetailValues> newAttendanceData) {
    if (attendanceData.isNotEmpty) {
      attendanceData.clear();
    }
    attendanceData.addAll(newAttendanceData);
  }
}
