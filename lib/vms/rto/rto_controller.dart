import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_skool_flutter/vms/rto/model/rto_emp_model.dart';
import 'package:m_skool_flutter/vms/rto/model/rto_fine_model.dart';
import 'package:m_skool_flutter/vms/rto/model/rto_v_model.dart';
import 'package:m_skool_flutter/vms/rto/model/rto_violation_model.dart';

class RTOController extends GetxController {
  RxBool isViolationLoading = RxBool(false);
  RxBool isSaving = RxBool(false);
  RxList<RtoVehicleModelValues> vehicleList = <RtoVehicleModelValues>[].obs;
  RtoVehicleModelValues? selectedVehicle;
  RxList<RtoEmpModelValues> empList = <RtoEmpModelValues>[].obs;
  RtoEmpModelValues? selectedEmp;
  RxList<RtoFineModelValues> fineList = <RtoFineModelValues>[].obs;
  RtoFineModelValues? selectedFine;
  RxList<RtoViolationModelValues> violationList =
      <RtoViolationModelValues>[].obs;
  RtoViolationModelValues? selectedViolation;
  //Attachments
  RxList<AtachmentFile> addListBrowser = <AtachmentFile>[].obs;
  RxList<bool> checkBox = <bool>[].obs;
  RxList<int> newList = <int>[].obs;

  RxList<TextEditingController> newRemarksController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> fileNameController =
      <TextEditingController>[].obs;
  //******//
}

class AtachmentFile {
  int? id;
  String? fileName;
  XFile? file;
  AtachmentFile({required this.id, required this.fileName, this.file});
}

class UploadAttachment {
  String? iSMTCRATAttatchment;
  String? iSMTCRATFile;

  UploadAttachment(
      {required this.iSMTCRATAttatchment, required this.iSMTCRATFile});

  UploadAttachment.fromJson(Map<String, dynamic> json) {
    iSMTCRATAttatchment = json['ISMTCRAT_Attatchment'];
    iSMTCRATFile = json['ISMTCRAT_File'];
  }

  factory UploadAttachment.fromMap(Map<String, dynamic> map) {
    return UploadAttachment(
        iSMTCRATAttatchment: map['ISMTCRAT_Attatchment'] as String,
        iSMTCRATFile: map['ISMTCRAT_File'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ISMTCRAT_Attatchment'] = iSMTCRATAttatchment;
    data['ISMTCRAT_File'] = iSMTCRATFile;
    return data;
  }
}
