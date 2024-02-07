import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certificate_approval_model.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certificate_doc_model.dart';
import 'package:m_skool_flutter/vms/certificate_approval/model/certificate_list_model.dart';

class CertificateController extends GetxController {
  RxBool isLoading = RxBool(false);
  void loading(bool v) {
    isLoading.value = v;
  }

  RxBool isApprovedloading = RxBool(false);
  void approvedloading(bool l) {
    isApprovedloading.value = l;
  }

  RxList<CertificatelistModelValues> certificatelist =
      <CertificatelistModelValues>[].obs;
  RxList<CertificateApprovalListModelValues> certificateApprovalList =
      <CertificateApprovalListModelValues>[].obs;
  RxList<CertificateDocumentModelValues> certificatDocList =
      <CertificateDocumentModelValues>[].obs;
  RxString employeeRemarks = ''.obs;
}
