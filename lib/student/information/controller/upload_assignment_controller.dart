import 'package:get/get.dart';

class UploadAssignmentController extends GetxController {
  RxString status = RxString("Uploading Files");
  RxString desc = RxString("Connecting to Server");
  void updateUploadStatus(String newStatus) {
    status.value = newStatus;
  }

  void updateDesc(String val) {
    desc.value = val;
  }
}
