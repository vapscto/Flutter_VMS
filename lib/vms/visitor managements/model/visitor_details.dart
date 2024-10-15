class VisitorDetailsModel {
  String? type;
  List<VisitorDetailsModelValues>? values;

  VisitorDetailsModel({this.type, this.values});

  VisitorDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <VisitorDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(VisitorDetailsModelValues.fromJson(v));
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

class VisitorDetailsModelValues {
  int? vmmVId;
  int? mIId;
  String? vmmVVisitorName;
  int? vmmVVisitorContactNo;
  String? vmmVVisitorEmailid;
  String? vmmVIdentityCardType;
  String? vmmVCardNo;
  String? vmmVFromPlace;
  String? vmmVMeetingDuration;
  String? vmmVMeetingDateTime;
  String? vmmVMeetingPurpose;
  String? vmmVAuthorisationBy;
  int? vmmVToMeet;
  String? vmmVEntryDateTime;
  String? vmmVVisitTypeFlg;
  String? vmmVCkeckedInOutStatus;
  bool? vmmVActiveFlag;
  int? vmmVUpdatedBy;
  int? vmmVCreatedBy;
  bool? vmmVDeptFlag;
  String? vmmVPersonToMeet;
  int? tenantagRId;
  String? vmmVQRCode;
  String? createdDate;
  String? updatedDate;

  VisitorDetailsModelValues(
      {this.vmmVId,
      this.mIId,
      this.vmmVVisitorName,
      this.vmmVVisitorContactNo,
      this.vmmVVisitorEmailid,
      this.vmmVIdentityCardType,
      this.vmmVCardNo,
      this.vmmVFromPlace,
      this.vmmVMeetingDuration,
      this.vmmVMeetingDateTime,
      this.vmmVMeetingPurpose,
      this.vmmVAuthorisationBy,
      this.vmmVToMeet,
      this.vmmVEntryDateTime,
      this.vmmVVisitTypeFlg,
      this.vmmVCkeckedInOutStatus,
      this.vmmVActiveFlag,
      this.vmmVUpdatedBy,
      this.vmmVCreatedBy,
      this.vmmVDeptFlag,
      this.vmmVPersonToMeet,
      this.tenantagRId,
      this.vmmVQRCode,
      this.createdDate,
      this.updatedDate});

  VisitorDetailsModelValues.fromJson(Map<String, dynamic> json) {
    vmmVId = json['vmmV_Id'];
    mIId = json['mI_Id'];
    vmmVVisitorName = json['vmmV_VisitorName'];
    vmmVVisitorContactNo = json['vmmV_VisitorContactNo'] ?? 0;
    vmmVVisitorEmailid = json['vmmV_VisitorEmailid'];
    vmmVIdentityCardType = json['vmmV_IdentityCardType'];
    vmmVCardNo = json['vmmV_CardNo'];
    vmmVFromPlace = json['vmmV_FromPlace'];
    vmmVMeetingDuration = json['vmmV_MeetingDuration'];
    vmmVMeetingDateTime = json['vmmV_MeetingDateTime'];
    vmmVMeetingPurpose = json['vmmV_MeetingPurpose'];
    vmmVAuthorisationBy = json['vmmV_AuthorisationBy'];
    vmmVToMeet = json['vmmV_ToMeet'];
    vmmVEntryDateTime = json['vmmV_EntryDateTime'];
    vmmVVisitTypeFlg = json['vmmV_VisitTypeFlg'];
    vmmVCkeckedInOutStatus = json['vmmV_CkeckedInOutStatus'];
    vmmVActiveFlag = json['vmmV_ActiveFlag'];
    vmmVUpdatedBy = json['vmmV_UpdatedBy'];
    vmmVCreatedBy = json['vmmV_CreatedBy'];
    vmmVDeptFlag = json['vmmV_DeptFlag'];
    vmmVPersonToMeet = json['vmmV_PersonToMeet'];
    tenantagRId = json['tenantagR_Id'];
    vmmVQRCode = json['vmmV_QRCode'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vmmV_Id'] = vmmVId;
    data['mI_Id'] = mIId;
    data['vmmV_VisitorName'] = vmmVVisitorName;
    data['vmmV_VisitorContactNo'] = vmmVVisitorContactNo;
    data['vmmV_VisitorEmailid'] = vmmVVisitorEmailid;
    data['vmmV_IdentityCardType'] = vmmVIdentityCardType;
    data['vmmV_CardNo'] = vmmVCardNo;
    data['vmmV_FromPlace'] = vmmVFromPlace;
    data['vmmV_MeetingDuration'] = vmmVMeetingDuration;
    data['vmmV_MeetingDateTime'] = vmmVMeetingDateTime;
    data['vmmV_MeetingPurpose'] = vmmVMeetingPurpose;
    data['vmmV_AuthorisationBy'] = vmmVAuthorisationBy;
    data['vmmV_ToMeet'] = vmmVToMeet;
    data['vmmV_EntryDateTime'] = vmmVEntryDateTime;
    data['vmmV_VisitTypeFlg'] = vmmVVisitTypeFlg;
    data['vmmV_CkeckedInOutStatus'] = vmmVCkeckedInOutStatus;
    data['vmmV_ActiveFlag'] = vmmVActiveFlag;
    data['vmmV_UpdatedBy'] = vmmVUpdatedBy;
    data['vmmV_CreatedBy'] = vmmVCreatedBy;
    data['vmmV_DeptFlag'] = vmmVDeptFlag;
    data['vmmV_PersonToMeet'] = vmmVPersonToMeet;
    data['tenantagR_Id'] = tenantagRId;
    data['vmmV_QRCode'] = vmmVQRCode;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
