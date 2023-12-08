import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/vms/interaction/model/interaction_staff_list_mode.dart';

class StaffInteractionComposeController extends GetxController {
  // RxList<GetdetailsValues> getDetailList = <GetdetailsValues>[].obs;

  // RxList<InteractionSectionListValue> interactionSectionList =
  //     <InteractionSectionListValue>[].obs;

  // RxList<GetStudentValue> studentList = <GetStudentValue>[].obs;

  RxString selectedradio = ''.obs;
  RxString grpOrInd = 'Individual'.obs;

  RxBool isInteraction = RxBool(false);
  RxBool isGetDetail = RxBool(false);
  RxBool isSection = RxBool(false);
  RxBool isStudent = RxBool(false);
  RxBool isSubmit = RxBool(false);
  RxBool isButton = RxBool(true);

  void isbutton(bool loading) {
    isButton.value = loading;
  }

  void isInteractionloading(bool loading) {
    isInteraction.value = loading;
  }

  void isgetdetailloading(bool loading) {
    isGetDetail.value = loading;
  }

  void issectionloading(bool loading) {
    isSection.value = loading;
  }

  void isstudentloading(bool loading) {
    isStudent.value = loading;
  }

  void issubmitloading(bool loading) {
    isSubmit.value = loading;
  }

  void selectedValue(String value) {
    selectedradio.value = value;
  }

  void groupOrIndividual(String value) {
    grpOrInd.value = value;
  }

  final List<XFile?> attachment = RxList();
  final List<PlatformFile> attFiles = RxList();

  void addMultipleAttachment(List<XFile?> att) {
    attachment.addAll(att);
  }

  void addToAttachment(XFile f) {
    attachment.add(f);
  }

  void removeAttachment(int index) {
    attachment.removeAt(index);
  }

  void addMultipleAttFiles(List<PlatformFile> att) {
    attFiles.addAll(att);
  }

  void addToFile(PlatformFile f) {
    attFiles.add(f);
  }

  void removeAtt(int index) {
    attFiles.removeAt(index);
  }

  RxList<InteractionStaffListModelValues> interactionStaffList =
      <InteractionStaffListModelValues>[].obs;
  RxBool isDataLoading = RxBool(false);
  void dataLoading(bool loading) {
    isDataLoading.value = loading;
  }

  getStaffList(List<InteractionStaffListModelValues> interactionStaff) {
    if (interactionStaffList.isNotEmpty) {
      interactionStaffList.clear();
    }
    for (int index = 0; index < interactionStaff.length; index++) {
      interactionStaffList.add(interactionStaff.elementAt(index));
    }
  }
}
