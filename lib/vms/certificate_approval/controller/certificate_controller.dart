import 'package:get/get.dart';

class CertificateController extends GetxController {
  RxBool isLoading = RxBool(false);
  void loading(bool v) {
    isLoading.value = v;
  }

  RxBool isApprovedloading = RxBool(false);
  void approvedloading(bool l) {
    isApprovedloading.value = l;
  }
}
