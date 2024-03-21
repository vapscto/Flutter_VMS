import 'package:get/get.dart';

class ScheduleInterviewController extends GetxController {
  RxBool isDataLoading = RxBool(false);
  void dataLoading(bool l) {
    isDataLoading.value = l;
  }

  RxBool isSving = RxBool(false);
  void saving(bool l) {
    isSving.value = l;
  }
}
