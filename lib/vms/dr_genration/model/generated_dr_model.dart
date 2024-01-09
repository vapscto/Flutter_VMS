class GeneratedDrDetailsModel {
  String? type;
  List<GeneratedDrDetailsModelValues>? values;

  GeneratedDrDetailsModel({this.type, this.values});

  GeneratedDrDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GeneratedDrDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(GeneratedDrDetailsModelValues.fromJson(v));
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

class GeneratedDrDetailsModelValues {
  int? ismdrpTId;
  int? mIId;
  int? hrmEId;
  int? ismtpLId;
  int? ismtplaPId;
  int? ismtpltAId;
  int? ismtcRId;
  String? ismdrpTDate;
  String? ismdrpTRemarks;
  int? ismdrpTTimeTakenInHrs;
  String? ismdrpTStatus;
  bool? ismdrpTDeviationFlg;
  bool? ismdrpTExtraFlg;
  bool? ismdrpTActiveFlg;
  String? createdDate;
  String? updatedDate;
  int? ismdrpTCreatedBy;
  int? ismdrpTUpdatedBy;
  bool? ismdrpTBlockedFlag;
  bool? ismdrpTOrdersDateFlg;
  String? ismdrpTOthersDateReason;
  bool? ismdrpTHalfDayFlag;
  String? ismdrpTTimeTakenFlg;
  bool? ismdrpTApprovedFlg;
  int? ismdrpTApprovedTime;
  String? ismdrpTApprovedTimeFlg;
  int? ismdRId;

  GeneratedDrDetailsModelValues(
      {this.ismdrpTId,
      this.mIId,
      this.hrmEId,
      this.ismtpLId,
      this.ismtplaPId,
      this.ismtpltAId,
      this.ismtcRId,
      this.ismdrpTDate,
      this.ismdrpTRemarks,
      this.ismdrpTTimeTakenInHrs,
      this.ismdrpTStatus,
      this.ismdrpTDeviationFlg,
      this.ismdrpTExtraFlg,
      this.ismdrpTActiveFlg,
      this.createdDate,
      this.updatedDate,
      this.ismdrpTCreatedBy,
      this.ismdrpTUpdatedBy,
      this.ismdrpTBlockedFlag,
      this.ismdrpTOrdersDateFlg,
      this.ismdrpTOthersDateReason,
      this.ismdrpTHalfDayFlag,
      this.ismdrpTTimeTakenFlg,
      this.ismdrpTApprovedFlg,
      this.ismdrpTApprovedTime,
      this.ismdrpTApprovedTimeFlg,
      this.ismdRId});

  GeneratedDrDetailsModelValues.fromJson(Map<String, dynamic> json) {
    ismdrpTId = json['ismdrpT_Id'];
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    ismtpLId = json['ismtpL_Id'];
    ismtplaPId = json['ismtplaP_Id'];
    ismtpltAId = json['ismtpltA_Id'];
    ismtcRId = json['ismtcR_Id'];
    ismdrpTDate = json['ismdrpT_Date'];
    ismdrpTRemarks = json['ismdrpT_Remarks'];
    ismdrpTTimeTakenInHrs = json['ismdrpT_TimeTakenInHrs'];
    ismdrpTStatus = json['ismdrpT_Status'];
    ismdrpTDeviationFlg = json['ismdrpT_DeviationFlg'];
    ismdrpTExtraFlg = json['ismdrpT_ExtraFlg'];
    ismdrpTActiveFlg = json['ismdrpT_ActiveFlg'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    ismdrpTCreatedBy = json['ismdrpT_CreatedBy'];
    ismdrpTUpdatedBy = json['ismdrpT_UpdatedBy'];
    ismdrpTBlockedFlag = json['ismdrpT_BlockedFlag'];
    ismdrpTOrdersDateFlg = json['ismdrpT_OrdersDateFlg'];
    ismdrpTOthersDateReason = json['ismdrpT_OthersDateReason'];
    ismdrpTHalfDayFlag = json['ismdrpT_HalfDayFlag'];
    ismdrpTTimeTakenFlg = json['ismdrpT_TimeTakenFlg'];
    ismdrpTApprovedFlg = json['ismdrpT_ApprovedFlg'];
    ismdrpTApprovedTime = json['ismdrpT_ApprovedTime'];
    ismdrpTApprovedTimeFlg = json['ismdrpT_ApprovedTimeFlg'];
    ismdRId = json['ismdR_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ismdrpT_Id'] = ismdrpTId;
    data['mI_Id'] = mIId;
    data['hrmE_Id'] = hrmEId;
    data['ismtpL_Id'] = ismtpLId;
    data['ismtplaP_Id'] = ismtplaPId;
    data['ismtpltA_Id'] = ismtpltAId;
    data['ismtcR_Id'] = ismtcRId;
    data['ismdrpT_Date'] = ismdrpTDate;
    data['ismdrpT_Remarks'] = ismdrpTRemarks;
    data['ismdrpT_TimeTakenInHrs'] = ismdrpTTimeTakenInHrs;
    data['ismdrpT_Status'] = ismdrpTStatus;
    data['ismdrpT_DeviationFlg'] = ismdrpTDeviationFlg;
    data['ismdrpT_ExtraFlg'] = ismdrpTExtraFlg;
    data['ismdrpT_ActiveFlg'] = ismdrpTActiveFlg;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['ismdrpT_CreatedBy'] = ismdrpTCreatedBy;
    data['ismdrpT_UpdatedBy'] = ismdrpTUpdatedBy;
    data['ismdrpT_BlockedFlag'] = ismdrpTBlockedFlag;
    data['ismdrpT_OrdersDateFlg'] = ismdrpTOrdersDateFlg;
    data['ismdrpT_OthersDateReason'] = ismdrpTOthersDateReason;
    data['ismdrpT_HalfDayFlag'] = ismdrpTHalfDayFlag;
    data['ismdrpT_TimeTakenFlg'] = ismdrpTTimeTakenFlg;
    data['ismdrpT_ApprovedFlg'] = ismdrpTApprovedFlg;
    data['ismdrpT_ApprovedTime'] = ismdrpTApprovedTime;
    data['ismdrpT_ApprovedTimeFlg'] = ismdrpTApprovedTimeFlg;
    data['ismdR_Id'] = ismdRId;
    return data;
  }
}
