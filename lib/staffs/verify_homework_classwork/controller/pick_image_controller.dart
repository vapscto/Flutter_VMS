import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/filtered_attachment_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/images_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/upload_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/verify_cw_model.dart';
import 'package:m_skool_flutter/staffs/verify_homework_classwork/model/verify_hw_model.dart';

class PickImageController extends GetxController {
  // PickImageController.init();
  // static PickImageController instance = PickImageController.init();

  RxList<ImageModel> images = RxList();

  void addToImages(List<ImageModel> file) {
    images.addAll(file);
  }

  RxList<PlatformFile> platformFile = RxList();

  void addPlatformFile(List<PlatformFile> files) {
    platformFile.addAll(files);
  }

  RxString uploadStatus = RxString("Connecting to Server");
  void updateUploadStatus(String status) {
    uploadStatus.value = status;
  }

  RxList<UploadAttModel> hwCwModel = RxList();

  void addToUpload(UploadAttModel model) {
    hwCwModel.add(model);
  }

  RxBool isErrorOccured = RxBool(false);

  void updateIsErrorOccured(bool f) {
    isErrorOccured.value = f;
  }

  RxBool isUploading = RxBool(false);

  void updateIsUploading(bool b) {
    isUploading.value = b;
  }

  RxList<TextEditingController> textEditingControllers = RxList();

  void updateTextEditingControllers(TextEditingController controller) {
    textEditingControllers.add(controller);
  }

  RxList<TextEditingController> selectedEntry = RxList();

  void addToSelectedEntry(TextEditingController controller) {
    selectedEntry.add(controller);
  }

  RxList<VerifyHwListModelValues> hwList = RxList();

  void addSingleHwEntry(VerifyHwListModelValues value) {
    hwList.add(value);
  }

  void updateHwList(List<VerifyHwListModelValues> hw) {
    if (hwList.isNotEmpty) {
      hwList.clear();
    }
    hwList.addAll(hw);
  }

  RxList<VerifyClassworkListValues> cwList = RxList();

  void addToCwList(VerifyClassworkListValues val) {
    cwList.add(val);
  }

  void updateCwList(List<VerifyClassworkListValues> lst) {
    if (cwList.isNotEmpty) {
      cwList.clear();
    }
    cwList.addAll(lst);
  }

  RxList<FilteredAttachment> filteredAttachment = RxList();

  void updateFilteredAttachment(List<FilteredAttachment> mList) {
    if (filteredAttachment.isNotEmpty) {
      filteredAttachment.clear();
    }
    filteredAttachment.addAll(mList);
  }

  RxList<FilteredAttachment> saveAttachment = RxList();

  void updateSaveAttachment(FilteredAttachment fA) {
    saveAttachment.add(fA);
  }
}
