import 'package:get/get.dart';
import 'package:m_skool_flutter/manager/student_details/model/academic_history_model.dart';
import 'package:m_skool_flutter/manager/student_details/model/exam_model.dart';
import 'package:m_skool_flutter/manager/student_details/model/manager_attendance_model.dart';
import 'package:m_skool_flutter/manager/student_details/model/manager_get_fee_details.dart';
import 'package:m_skool_flutter/manager/student_details/model/personal_details.dart';

class ViewStudentDetailsController extends GetxController {
  RxBool isLoading = RxBool(false);
  RxString status = RxString("");

  void updateStatus(String st) {
    status.value = st;
  }

  void updateIsLoading(bool b) {
    isLoading.value = b;
  }

  RxBool isErrorOccured = RxBool(false);

  void updateIsErrorOccured(bool b) {
    isErrorOccured.value = b;
  }

  RxBool isHistoryLoading = RxBool(false);
  RxString historyStatus = RxString("");
  RxBool isErrorOccuredInHistory = RxBool(false);

  void updateIsHistoryLoading(bool b) {
    isHistoryLoading.value = b;
  }

  void updateHistoryStatus(String status) {
    historyStatus.value = status;
  }

  void updateIsErrorOccuredInHistory(bool b) {
    isErrorOccuredInHistory.value = b;
  }

  RxList<AcademicHistoryValues> academicHistory = RxList();
  RxList<PersonalDetailsValues> personalData = RxList();
  RxList<ManagerAttendanceModelValues> attendance = RxList();
  RxList<GetFeeDetailsValues> feeDetails = RxList();
  RxList<GetTermFeeDetailsValues> getTermFee = RxList();
  RxList<ManagerExamModelValues> managerExam = RxList();

  void updateAcademicHistoryModel(List<AcademicHistoryValues> his) {
    if (academicHistory.isNotEmpty) {
      academicHistory.clear();
    }
    academicHistory.addAll(his);
  }

  void updatePersonalData(List<PersonalDetailsValues> d) {
    if (personalData.isNotEmpty) {
      personalData.clear();
    }
    personalData.addAll(d);
  }

  void updateAttendance(List<ManagerAttendanceModelValues> att) {
    if (attendance.isNotEmpty) {
      attendance.clear();
    }
    attendance.addAll(att);
  }

  void updateFeeDetails(List<GetFeeDetailsValues> fee) {
    if (feeDetails.isNotEmpty) {
      feeDetails.clear();
    }
    feeDetails.addAll(fee);
  }

  void updateGetTermFee(List<GetTermFeeDetailsValues> term) {
    if (getTermFee.isNotEmpty) {
      getTermFee.clear();
    }
    getTermFee.addAll(term);
  }

  void updateManagerExam(List<ManagerExamModelValues> manager) {
    if (managerExam.isNotEmpty) {
      managerExam.clear();
    }
    managerExam.addAll(manager);
  }
}
