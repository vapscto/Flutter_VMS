import 'dart:io';

import 'package:image_picker/image_picker.dart';

class GetDepts {
  String? type;
  List<GetDeptsValues>? values;

  GetDepts({this.type, this.values});

  GetDepts.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetDeptsValues>[];
      json['\$values'].forEach((v) {
        values!.add(  GetDeptsValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetDeptsValues {
  bool? returnval;
  bool? roleflag;
  bool? completed;
  bool? pending;
  bool? alreadyCnt;
  int? userId;
  int? ivrmrTId;
  bool? plannerextapproval;
  String? plannerMaxdate;
  String? hrmDDepartmentName;
  int? ismmaCId;
  int? mIId;
  int? miId;
  int? hrmEId;
  int? asmaYId;
  int? hrmDId;
  int? hrmdCID;
  int? ismmpRId;
  int? ivrmMId;
  int? ismmmDId;
  int? ismmmDModuleHeadId;
  int? ismtcRId;
  int? hrmpRId;
  int? ismmtcaTId;
  bool? ismtcRReOpenFlg;
  bool? ismtcRActiveFlg;
  int? ismtcRCreatedBy;
  int? ismtcRUpdatedBy;
  int? ismtcrcLId;
  int? ismmclTId;
  bool? ismtcrcLActiveFlg;
  int? ismtcrcLCreatedBy;
  int? ismtcrcLUpdatedBy;
  int? ismtcraTId;
  bool? ismtcraTActiveFlg;
  int? ismtcraTCreatedBy;
  int? ismtcraTUpdatedBy;
  int? prioritycheck;
  int? ismciMIEList;
  double? effortinhrs;

  GetDeptsValues(
      {this.returnval,
      this.roleflag,
      this.completed,
      this.pending,
      this.alreadyCnt,
      this.userId,
      this.ivrmrTId,
      this.plannerextapproval,
      this.plannerMaxdate,
      this.hrmDDepartmentName,
      this.ismmaCId,
      this.mIId,
      this.miId,
      this.hrmEId,
      this.asmaYId,
      this.hrmDId,
      this.hrmdCID,
      this.ismmpRId,
      this.ivrmMId,
      this.ismmmDId,
      this.ismmmDModuleHeadId,
      this.ismtcRId,
      this.hrmpRId,
      this.ismmtcaTId,
      this.ismtcRReOpenFlg,
      this.ismtcRActiveFlg,
      this.ismtcRCreatedBy,
      this.ismtcRUpdatedBy,
      this.ismtcrcLId,
      this.ismmclTId,
      this.ismtcrcLActiveFlg,
      this.ismtcrcLCreatedBy,
      this.ismtcrcLUpdatedBy,
      this.ismtcraTId,
      this.ismtcraTActiveFlg,
      this.ismtcraTCreatedBy,
      this.ismtcraTUpdatedBy,
      this.prioritycheck,
      this.ismciMIEList,
      this.effortinhrs});

  GetDeptsValues.fromJson(Map<String, dynamic> json) {
    returnval = json['returnval'];
    roleflag = json['roleflag'];
    completed = json['completed'];
    pending = json['pending'];
    alreadyCnt = json['already_cnt'];
    userId = json['userId'];
    ivrmrTId = json['ivrmrT_Id'];
    plannerextapproval = json['plannerextapproval'];
    plannerMaxdate = json['plannerMaxdate'];
    hrmDDepartmentName = json['hrmD_DepartmentName'];
    ismmaCId = json['ismmaC_Id'];
    mIId = json['mI_Id'];
    miId = json['miId'];
    hrmEId = json['hrmE_Id'];
    asmaYId = json['asmaY_Id'];
    hrmDId = json['hrmD_Id'];
    hrmdCID = json['hrmdC_ID'];
    ismmpRId = json['ismmpR_Id'];
    ivrmMId = json['ivrmM_Id'];
    ismmmDId = json['ismmmD_Id'];
    ismmmDModuleHeadId = json['ismmmD_ModuleHeadId'];
    ismtcRId = json['ismtcR_Id'];
    hrmpRId = json['hrmpR_Id'];
    ismmtcaTId = json['ismmtcaT_Id'];
    ismtcRReOpenFlg = json['ismtcR_ReOpenFlg'];
    ismtcRActiveFlg = json['ismtcR_ActiveFlg'];
    ismtcRCreatedBy = json['ismtcR_CreatedBy'];
    ismtcRUpdatedBy = json['ismtcR_UpdatedBy'];
    ismtcrcLId = json['ismtcrcL_Id'];
    ismmclTId = json['ismmclT_Id'];
    ismtcrcLActiveFlg = json['ismtcrcL_ActiveFlg'];
    ismtcrcLCreatedBy = json['ismtcrcL_CreatedBy'];
    ismtcrcLUpdatedBy = json['ismtcrcL_UpdatedBy'];
    ismtcraTId = json['ismtcraT_Id'];
    ismtcraTActiveFlg = json['ismtcraT_ActiveFlg'];
    ismtcraTCreatedBy = json['ismtcraT_CreatedBy'];
    ismtcraTUpdatedBy = json['ismtcraT_UpdatedBy'];
    prioritycheck = json['prioritycheck'];
    ismciMIEList = json['ismciM_IEList'];
    effortinhrs = json['effortinhrs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['returnval'] = this.returnval;
    data['roleflag'] = this.roleflag;
    data['completed'] = this.completed;
    data['pending'] = this.pending;
    data['already_cnt'] = this.alreadyCnt;
    data['userId'] = this.userId;
    data['ivrmrT_Id'] = this.ivrmrTId;
    data['plannerextapproval'] = this.plannerextapproval;
    data['plannerMaxdate'] = this.plannerMaxdate;
    data['hrmD_DepartmentName'] = this.hrmDDepartmentName;
    data['ismmaC_Id'] = this.ismmaCId;
    data['mI_Id'] = this.mIId;
    data['miId'] = this.miId;
    data['hrmE_Id'] = this.hrmEId;
    data['asmaY_Id'] = this.asmaYId;
    data['hrmD_Id'] = this.hrmDId;
    data['hrmdC_ID'] = this.hrmdCID;
    data['ismmpR_Id'] = this.ismmpRId;
    data['ivrmM_Id'] = this.ivrmMId;
    data['ismmmD_Id'] = this.ismmmDId;
    data['ismmmD_ModuleHeadId'] = this.ismmmDModuleHeadId;
    data['ismtcR_Id'] = this.ismtcRId;
    data['hrmpR_Id'] = this.hrmpRId;
    data['ismmtcaT_Id'] = this.ismmtcaTId;
    data['ismtcR_ReOpenFlg'] = this.ismtcRReOpenFlg;
    data['ismtcR_ActiveFlg'] = this.ismtcRActiveFlg;
    data['ismtcR_CreatedBy'] = this.ismtcRCreatedBy;
    data['ismtcR_UpdatedBy'] = this.ismtcRUpdatedBy;
    data['ismtcrcL_Id'] = this.ismtcrcLId;
    data['ismmclT_Id'] = this.ismmclTId;
    data['ismtcrcL_ActiveFlg'] = this.ismtcrcLActiveFlg;
    data['ismtcrcL_CreatedBy'] = this.ismtcrcLCreatedBy;
    data['ismtcrcL_UpdatedBy'] = this.ismtcrcLUpdatedBy;
    data['ismtcraT_Id'] = this.ismtcraTId;
    data['ismtcraT_ActiveFlg'] = this.ismtcraTActiveFlg;
    data['ismtcraT_CreatedBy'] = this.ismtcraTCreatedBy;
    data['ismtcraT_UpdatedBy'] = this.ismtcraTUpdatedBy;
    data['prioritycheck'] = this.prioritycheck;
    data['ismciM_IEList'] = this.ismciMIEList;
    data['effortinhrs'] = this.effortinhrs;
    return data;
  }
}

class AtachmentFile{
  int? id;
  String? FileName;
  XFile? file;
 AtachmentFile({required this.id,required this.FileName,   this.file}) ;
}
class UploadAttachment {
  String? iSMTCRATAttatchment;
  String? iSMTCRATFile;

  UploadAttachment({ required this.iSMTCRATAttatchment,required this.iSMTCRATFile});

  UploadAttachment.fromJson(Map<String, dynamic> json) {
    iSMTCRATAttatchment = json['ISMTCRAT_Attatchment'];
    iSMTCRATFile = json['ISMTCRAT_File'];
  }
 
factory  UploadAttachment.fromMap(Map<String, dynamic> map) {
  return UploadAttachment(
iSMTCRATAttatchment: map['ISMTCRAT_Attatchment'] as String,
iSMTCRATFile:map['ISMTCRAT_File'] as String
  );
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ISMTCRAT_Attatchment'] = this.iSMTCRATAttatchment;
    data['ISMTCRAT_File'] = this.iSMTCRATFile;
    return data;
  }
}
