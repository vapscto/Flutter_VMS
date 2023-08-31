import 'package:get/get.dart';
import 'package:m_skool_flutter/student/fees/model/academic_year_fee_detail_model.dart';
import 'package:m_skool_flutter/student/fees/model/fill_student_model.dart';
import 'package:m_skool_flutter/student/fees/model/installment_model.dart';

class PayOnlineDataController extends GetxController {
  final RxBool isPageLoading = RxBool(false);
  final RxBool isAcademicFeeDetailLoaded = RxBool(false);
  final RxBool isInstallmentDetailLoaded = RxBool(false);
  final RxBool isPayingStarted = RxBool(false);
  final RxList<FillStudentModelValues> fillStudent = RxList();

  void updateisPageLoading(bool b) {
    isPageLoading.value = b;
  }

  void updateFillStudent(List<FillStudentModelValues> model) {
    if (fillStudent.isNotEmpty) {
      fillStudent.clear();
    }
    fillStudent.addAll(model);
  }

  void updateIsAcademicFeeDetailLoaded(bool b) {
    isAcademicFeeDetailLoaded.value = b;
  }

  void updateIsInstallmentDetailLoaded(bool b) {
    isInstallmentDetailLoaded.value = b;
  }

  void updateIsPayingStarted(bool b) {
    isPayingStarted.value = b;
  }

  RxList<AcademicYearFeeDtlModelValues> academicYearFeeDet = RxList();

  void updateAcademicYearFeeDet(List<AcademicYearFeeDtlModelValues> newData) {
    if (academicYearFeeDet.isNotEmpty) {
      academicYearFeeDet.clear();
    }
    academicYearFeeDet.addAll(newData);
  }

  RxList<InstallmentModel> installment = RxList([]);

  void updateInstallment(List<InstallmentModel> installments) {
    if (installment.isNotEmpty) {
      installment.clear();
    }
    installment.addAll(installments);
  }

  RxList<bool> installmentCheckbox = RxList([]);
}
