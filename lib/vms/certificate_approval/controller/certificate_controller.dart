import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certi_emp_list.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certificate_approval_model.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certificate_doc_model.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certificate_employee_list.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certificate_list_model.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certificate_view_model.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/final_approval_model.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/previous_approved_model.dart';
import 'package:m_skool_flutter/vms/rating_report/screen/report_data_screen.dart';

import '../../tadaModule/tada_apply_module/controller/tada_apply_controller.dart';

class CertificateController extends GetxController {
  RxBool isLoading = RxBool(false);
  void loading(bool v) {
    isLoading.value = v;
  }

  RxBool isApprovedloading = RxBool(false);
  void approvedloading(bool l) {
    isApprovedloading.value = l;
  }

  RxBool isApprove = RxBool(false);
  void aprove(bool v) {
    isApprove.value = v;
  }

  RxList<CertificatelistModelValues> certificatelist =
      <CertificatelistModelValues>[].obs;
  RxList<CertificateApprovalListModelValues> certificateApprovalList =
      <CertificateApprovalListModelValues>[].obs;
  RxList<CertificateDocumentModelValues> certificatDocList =
      <CertificateDocumentModelValues>[].obs;
  RxString employeeRemarks = ''.obs;
  RxInt maxLevel = 0.obs;
  RxList<PreviousApprovedModelValues> previousApprovedList =
      <PreviousApprovedModelValues>[].obs;
  RxList<PreviousApprovedViewModelValues> viewList =
      <PreviousApprovedViewModelValues>[].obs;
  RxList<CertificateEmployeeModelValues> employeeData =
      <CertificateEmployeeModelValues>[].obs;
  void loadEmployee(List<CertificateEmployeeModelValues> l) {
    if (employeeData.isNotEmpty) {
      employeeData.clear();
    }
    for (int i = 0; i < l.length; i++) {
      employeeData.add(l.elementAt(i));
    }
  }

  RxList<CerEmployListModelValues> employeeList =
      <CerEmployListModelValues>[].obs;

  RxList<CertificateFinalApprovalModelValues> finalApprovalList =
      <CertificateFinalApprovalModelValues>[].obs;
  RxList<AtachmentFile> addListBrowser = <AtachmentFile>[].obs;
}
