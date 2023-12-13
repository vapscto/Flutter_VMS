import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/model/company_model.dart';
import 'package:m_skool_flutter/vms/checkbook_approval/model/otp_response.dart';

class ChequeController extends GetxController {
  RxBool isErrorOccuredWhileLoading = RxBool(false);
  RxBool isLoading = RxBool(false);
  RxBool updateBtn = RxBool(false);
  final RxList<CompanyListValues> companiesList = RxList();
  RxList<OtpResponse> otpResponseList = <OtpResponse>[].obs;
  updateErrorLoading(bool val) {
    isErrorOccuredWhileLoading.value = val;
  }
  
  updateisLoading(bool val) {
    isLoading.value = val;
  }
  updateBtns(bool val){
   updateBtn.value = val;
  }
}
