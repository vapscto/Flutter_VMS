class DrUploadedFileModel {
  String? type;
  List<DrUploadedFileModelValues>? values;

  DrUploadedFileModel({this.type, this.values});

  DrUploadedFileModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DrUploadedFileModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DrUploadedFileModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DrUploadedFileModelValues {
  int? ismdrpTId;
  int? mIId;
  int? ismmtcaTId;
  int? dRNotification;
  int? hrmEId;
  int? hrmETo;
  int? ismtpLId;
  int? ismtplaPId;
  int? ismtcRId;
  int? deptHeadId;
  bool? ismdrpTDeviationFlg;
  bool? ismdrpTExtraFlg;
  bool? ismdrpTActiveFlg;
  int? ismdrpTCreatedBy;
  int? ismdrpTUpdatedBy;
  int? userId;
  int? asmaYId;
  int? roleId;
  bool? returnval;
  int? plannerlength;
  bool? approvalflag;
  bool? othersdayenable;
  bool? ismdrpTOrdersDateFlg;
  int? blockedcount;
  bool? ismdrpTBlockedFlag;
  int? deviationId;
  bool? roleflag;
  int? ivrmrTId;
  String? ismdrptfLFileName;
  String? ismdrptfLRefNo;
  String? ismdrptfLRemarks;
  String? ismdrptfLFilePath;
  String? ismmtcatcLCheckListName;
  int? ismmtcatcLId;
  int? ismdrptfLId;
  int? ismtpltAId;

  DrUploadedFileModelValues(
      {this.ismdrpTId,
      this.mIId,
      this.ismmtcaTId,
      this.dRNotification,
      this.hrmEId,
      this.hrmETo,
      this.ismtpLId,
      this.ismtplaPId,
      this.ismtcRId,
      this.deptHeadId,
      this.ismdrpTDeviationFlg,
      this.ismdrpTExtraFlg,
      this.ismdrpTActiveFlg,
      this.ismdrpTCreatedBy,
      this.ismdrpTUpdatedBy,
      this.userId,
      this.asmaYId,
      this.roleId,
      this.returnval,
      this.plannerlength,
      this.approvalflag,
      this.othersdayenable,
      this.ismdrpTOrdersDateFlg,
      this.blockedcount,
      this.ismdrpTBlockedFlag,
      this.deviationId,
      this.roleflag,
      this.ivrmrTId,
      this.ismdrptfLFileName,
      this.ismdrptfLRefNo,
      this.ismdrptfLRemarks,
      this.ismdrptfLFilePath,
      this.ismmtcatcLCheckListName,
      this.ismmtcatcLId,
      this.ismdrptfLId,
      this.ismtpltAId});

  DrUploadedFileModelValues.fromJson(Map<String, dynamic> json) {
    ismdrpTId = json['ismdrpT_Id'];
    mIId = json['mI_Id'];
    ismmtcaTId = json['ismmtcaT_Id'];
    dRNotification = json['dR_Notification'];
    hrmEId = json['hrmE_Id'];
    hrmETo = json['hrmE_To'];
    ismtpLId = json['ismtpL_Id'];
    ismtplaPId = json['ismtplaP_Id'];
    ismtcRId = json['ismtcR_Id'];
    deptHeadId = json['dept_Head_Id'];
    ismdrpTDeviationFlg = json['ismdrpT_DeviationFlg'];
    ismdrpTExtraFlg = json['ismdrpT_ExtraFlg'];
    ismdrpTActiveFlg = json['ismdrpT_ActiveFlg'];
    ismdrpTCreatedBy = json['ismdrpT_CreatedBy'];
    ismdrpTUpdatedBy = json['ismdrpT_UpdatedBy'];
    userId = json['userId'];
    asmaYId = json['asmaY_Id'];
    roleId = json['roleId'];
    returnval = json['returnval'];
    plannerlength = json['plannerlength'];
    approvalflag = json['approvalflag'];
    othersdayenable = json['othersdayenable'];
    ismdrpTOrdersDateFlg = json['ismdrpT_OrdersDateFlg'];
    blockedcount = json['blockedcount'];
    ismdrpTBlockedFlag = json['ismdrpT_BlockedFlag'];
    deviationId = json['deviation_id'];
    roleflag = json['roleflag'];
    ivrmrTId = json['ivrmrT_Id'];
    ismdrptfLFileName = json['ismdrptfL_FileName'];
    ismdrptfLRefNo = json['ismdrptfL_RefNo'];
    ismdrptfLRemarks = json['ismdrptfL_Remarks'];
    ismdrptfLFilePath = json['ismdrptfL_FilePath'];
    ismmtcatcLCheckListName = json['ismmtcatcL_CheckListName'];
    ismmtcatcLId = json['ismmtcatcL_Id'];
    ismdrptfLId = json['ismdrptfL_Id'];
    ismtpltAId = json['ismtpltA_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ismdrpT_Id'] = ismdrpTId;
    data['mI_Id'] = mIId;
    data['ismmtcaT_Id'] = ismmtcaTId;
    data['dR_Notification'] = dRNotification;
    data['hrmE_Id'] = hrmEId;
    data['hrmE_To'] = hrmETo;
    data['ismtpL_Id'] = ismtpLId;
    data['ismtplaP_Id'] = ismtplaPId;
    data['ismtcR_Id'] = ismtcRId;
    data['dept_Head_Id'] = deptHeadId;
    data['ismdrpT_DeviationFlg'] = ismdrpTDeviationFlg;
    data['ismdrpT_ExtraFlg'] = ismdrpTExtraFlg;
    data['ismdrpT_ActiveFlg'] = ismdrpTActiveFlg;
    data['ismdrpT_CreatedBy'] = ismdrpTCreatedBy;
    data['ismdrpT_UpdatedBy'] = ismdrpTUpdatedBy;
    data['userId'] = userId;
    data['asmaY_Id'] = asmaYId;
    data['roleId'] = roleId;
    data['returnval'] = returnval;
    data['plannerlength'] = plannerlength;
    data['approvalflag'] = approvalflag;
    data['othersdayenable'] = othersdayenable;
    data['ismdrpT_OrdersDateFlg'] = ismdrpTOrdersDateFlg;
    data['blockedcount'] = blockedcount;
    data['ismdrpT_BlockedFlag'] = ismdrpTBlockedFlag;
    data['deviation_id'] = deviationId;
    data['roleflag'] = roleflag;
    data['ivrmrT_Id'] = ivrmrTId;
    data['ismdrptfL_FileName'] = ismdrptfLFileName;
    data['ismdrptfL_RefNo'] = ismdrptfLRefNo;
    data['ismdrptfL_Remarks'] = ismdrptfLRemarks;
    data['ismdrptfL_FilePath'] = ismdrptfLFilePath;
    data['ismmtcatcL_CheckListName'] = ismmtcatcLCheckListName;
    data['ismmtcatcL_Id'] = ismmtcatcLId;
    data['ismdrptfL_Id'] = ismdrptfLId;
    data['ismtpltA_Id'] = ismtpltAId;
    return data;
  }
}
