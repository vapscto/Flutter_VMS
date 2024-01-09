class VisitorApprovalModel {
  String? type;
  List<VisitorApprovalModelValues>? values;

  VisitorApprovalModel({this.type, this.values});

  VisitorApprovalModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <VisitorApprovalModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(VisitorApprovalModelValues.fromJson(v));
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

class VisitorApprovalModelValues {
  String? type;
  int? mIId;
  String? mIName;
  int? vMAPId;
  String? vMAPVisitorName;
  String? vMAPVisitTypeFlg;
  String? vMAPToMeet;
  String? vMAPEntryDateTime;
  String? vMAPFromPlace;
  String? vMAPStatus;
  String? vMAPMeetingPurpose;
  int? fCNT;
  String? vMAPMeetingLocation;
  int? hrmEId;
  String? hrmEEmployeeFirstName;
  String? vMAPMeetingTiming;
  String? vMAPMeetingDateTime;
  int? vMAPVisitorContactNo;
  String? vMAPVisitorEmailid;
  String? vMAPMeetingTiming1;
  String? vMAPMeetingToTime1;
  String? vMAPMeetingToTime;
  String? vMAPRemarks;
  String? createdby;
  String? vMAPRequestFromTime;
  String? vMAPRequestToTime;

  VisitorApprovalModelValues(
      {this.type,
      this.mIId,
      this.mIName,
      this.vMAPId,
      this.vMAPVisitorName,
      this.vMAPVisitTypeFlg,
      this.vMAPToMeet,
      this.vMAPEntryDateTime,
      this.vMAPFromPlace,
      this.vMAPStatus,
      this.vMAPMeetingPurpose,
      this.fCNT,
      this.vMAPMeetingLocation,
      this.hrmEId,
      this.hrmEEmployeeFirstName,
      this.vMAPMeetingTiming,
      this.vMAPMeetingDateTime,
      this.vMAPVisitorContactNo,
      this.vMAPVisitorEmailid,
      this.vMAPMeetingTiming1,
      this.vMAPMeetingToTime1,
      this.vMAPMeetingToTime,
      this.vMAPRemarks,
      this.createdby,
      this.vMAPRequestFromTime,
      this.vMAPRequestToTime});

  VisitorApprovalModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    mIId = json['mI_Id'];
    mIName = json['MI_Name'];
    vMAPId = json['VMAP_Id'];
    vMAPVisitorName = json['VMAP_VisitorName'];
    vMAPVisitTypeFlg = json['VMAP_VisitTypeFlg'];
    vMAPToMeet = json['VMAP_ToMeet'];
    vMAPEntryDateTime = json['VMAP_EntryDateTime'];
    vMAPFromPlace = json['VMAP_FromPlace'];
    vMAPStatus = json['VMAP_Status'];
    vMAPMeetingPurpose = json['VMAP_MeetingPurpose'];
    fCNT = json['FCNT'];
    vMAPMeetingLocation = json['VMAP_MeetingLocation'];
    hrmEId = json['hrmE_Id'];
    hrmEEmployeeFirstName = json['hrmE_EmployeeFirstName'];
    vMAPMeetingTiming = json['VMAP_MeetingTiming'];
    vMAPMeetingDateTime = json['VMAP_MeetingDateTime'];
    vMAPVisitorContactNo = json['VMAP_VisitorContactNo'];
    vMAPVisitorEmailid = json['VMAP_VisitorEmailid'];
    vMAPMeetingTiming1 = json['VMAP_MeetingTiming1'];
    vMAPMeetingToTime1 = json['VMAP_MeetingToTime1'];
    vMAPMeetingToTime = json['VMAP_MeetingToTime'];
    vMAPRemarks = json['VMAP_Remarks'];
    createdby = json['createdby'];
    vMAPRequestFromTime = json['VMAP_RequestFromTime'];
    vMAPRequestToTime = json['VMAP_RequestToTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['mI_Id'] = mIId;
    data['MI_Name'] = mIName;
    data['VMAP_Id'] = vMAPId;
    data['VMAP_VisitorName'] = vMAPVisitorName;
    data['VMAP_VisitTypeFlg'] = vMAPVisitTypeFlg;
    data['VMAP_ToMeet'] = vMAPToMeet;
    data['VMAP_EntryDateTime'] = vMAPEntryDateTime;
    data['VMAP_FromPlace'] = vMAPFromPlace;
    data['VMAP_Status'] = vMAPStatus;
    data['VMAP_MeetingPurpose'] = vMAPMeetingPurpose;
    data['FCNT'] = fCNT;
    data['VMAP_MeetingLocation'] = vMAPMeetingLocation;
    data['hrmE_Id'] = hrmEId;
    data['hrmE_EmployeeFirstName'] = hrmEEmployeeFirstName;
    data['VMAP_MeetingTiming'] = vMAPMeetingTiming;
    data['VMAP_MeetingDateTime'] = vMAPMeetingDateTime;
    data['VMAP_VisitorContactNo'] = vMAPVisitorContactNo;
    data['VMAP_VisitorEmailid'] = vMAPVisitorEmailid;
    data['VMAP_MeetingTiming1'] = vMAPMeetingTiming1;
    data['VMAP_MeetingToTime1'] = vMAPMeetingToTime1;
    data['VMAP_MeetingToTime'] = vMAPMeetingToTime;
    data['VMAP_Remarks'] = vMAPRemarks;
    data['createdby'] = createdby;
    data['VMAP_RequestFromTime'] = vMAPRequestFromTime;
    data['VMAP_RequestToTime'] = vMAPRequestToTime;
    return data;
  }
}
