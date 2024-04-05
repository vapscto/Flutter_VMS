import 'package:get/get.dart';

class InterviewScController extends GetxController {
  RxBool isLoading = RxBool(false);
  void loading(bool l) {
    isLoading.value = l;
  }
}
