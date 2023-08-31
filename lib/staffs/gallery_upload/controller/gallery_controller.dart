import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/model/gallery_Section_Model.dart';
import 'package:m_skool_flutter/staffs/gallery_upload/model/gallery_classList_model.dart';
 

// import 'package:m_skool_flutter/staffs/gallery_upload/model/gallery_Section_Model.dart';
// import 'package:m_skool_flutter/staffs/gallery_upload/model/gallery_classList_model.dart';

class StaffGalleryController extends GetxController {
  //***IF NO USE OF FILTER , REMOVE IT ***//
  RxBool showFilter = RxBool(false);
  RxString galleryName = RxString("Gallery Name");
  RxString selectedradio = ''.obs;
  RxString grpOrInd = 'Class'.obs;
  RxString videoOrImage = 'I'.obs;
  RxBool allSectionCheck = RxBool(false);
  RxList<File> selectedMedia = <File>[].obs;
  RxList<File> selectedVideos = <File>[].obs;
  final List<XFile?> attachment = RxList();
  final List<PlatformFile> attFiles = RxList();
  void updateShowFilter(bool b) {
    showFilter.value = b;
  }

  RxInt filterCount = RxInt(0);

  void updateFilterCount(int b) {
    filterCount.value = b;
  }

  RxBool isSaving = RxBool(false);
  RxBool isErrorOccuredSavingHw = RxBool(false);
  RxBool isUploadingFiles = RxBool(false);
  RxString saveStatus = RxString("Connecting to server");

  RxBool isClassLoading = RxBool(false);
  void updateIsClassLoading(bool ok) {
    isClassLoading.value = ok;
  }

  void updateSaveStatus(String status) {
    saveStatus.value = status;
  }

  void groupOrIndividual(String value) {
    grpOrInd.value = value;
  }

  void updateIsErrorOccuredSavingHw(bool f) {
    isErrorOccuredSavingHw.value = f;
  }

  void checkallSections(bool check) {
    allSectionCheck.value = check;
  }

  void checkVideoOrImage(String value) {
    videoOrImage.value = value;
  }

  RxBool isErrorOccuredLoadingClass = RxBool(false);
  void updateIsErrorOccuredLoadingClass(bool ok) {
    isErrorOccuredLoadingClass.value = ok;
  }

  RxList<StaffGalleryClassListModelValues> classes = RxList();

  void updateClasses(List<StaffGalleryClassListModelValues> clas) {
    if (classes.isNotEmpty) {
      classes.clear();
    }
    classes.addAll(clas);
  }

  Rx<StaffGalleryClassListModelValues> selectedClass =
      Rx(StaffGalleryClassListModelValues());

  void updateSelectedClass(StaffGalleryClassListModelValues selClass) {
    selectedClass.value = selClass;
  }

  RxBool isSectionLoading = RxBool(false);
  void updateIsSectionLoading(bool ok) {
    isSectionLoading.value = ok;
  }

  RxBool isErrorOccuredLoadingSection = RxBool(false);
  void updateIsErrorOccuredLoadingSection(bool ok) {
    isErrorOccuredLoadingSection.value = ok;
  }

  RxList<GallerySectionModelValues> sections = RxList();
  void updateSections(List<GallerySectionModelValues> li) {
    if (sections.isNotEmpty) {
      sections.clear();
    }
    sections.addAll(li);
  }

  RxList<GallerySectionModelValues> selectedSection = RxList();

  void updateSelectedSection(GallerySectionModelValues val) {
    selectedSection.add(val);
  }

  Rx<GallerySectionModelValues> verifySelectedSection =
      Rx<GallerySectionModelValues>(GallerySectionModelValues());

  void updateVerifySelectedSection(GallerySectionModelValues val) {
    verifySelectedSection.value = val;
  }

  final RxList<TextEditingController> textEditors = RxList([]);

  void addToEditors(TextEditingController controller) {
    textEditors.add(controller);
  }

  void removeEditor(int index) {
    textEditors.removeAt(index);
  }

  RxString loadingStatus = RxString("");
  void updateLoadingStatus(String status) {
    loadingStatus.value = status;
  }

  RxString errorStatus = RxString("");
  void updateErrorStatus(String status) {
    errorStatus.value = status;
  }
}
