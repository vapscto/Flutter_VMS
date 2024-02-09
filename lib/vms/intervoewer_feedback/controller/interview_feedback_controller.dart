import 'package:get/get.dart';

class InterviewFeedbackController extends GetxController {
  RxBool isListLoading = RxBool(false);
  void listLoading(bool l) {
    isListLoading.value = l;
  }

  RxBool isUpdateLoading = RxBool(false);
  void updateLoading(bool l) {
    isUpdateLoading.value = l;
  }
}
