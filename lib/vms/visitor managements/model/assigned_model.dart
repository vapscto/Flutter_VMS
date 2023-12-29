class AssignedlistModel {
  String? type;
  List<AssignedlistModelValues>? values;

  AssignedlistModel({this.type, this.values});

  AssignedlistModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <AssignedlistModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(AssignedlistModelValues.fromJson(v));
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

class AssignedlistModelValues {
  String? type;
  int? vMMVId;
  String? vMMVVisitorName;
  String? vMMVFromPlace;
  String? vMMVMeetingPurpose;
  String? vMMVMeetingDateTime;
  String? vMMVEntryDateTime;
  String? aSSIGNEDBY;
  int? vMVTMTId;
  String? vMVTMTDateTime;
  String? mIName;
  bool? vMVTMTMetFlg;
  String? vMMVCkeckedInOutStatus;

  AssignedlistModelValues(
      {this.type,
      this.vMMVId,
      this.vMMVVisitorName,
      this.vMMVFromPlace,
      this.vMMVMeetingPurpose,
      this.vMMVMeetingDateTime,
      this.vMMVEntryDateTime,
      this.aSSIGNEDBY,
      this.vMVTMTId,
      this.vMVTMTDateTime,
      this.mIName,
      this.vMVTMTMetFlg,
      this.vMMVCkeckedInOutStatus});

  AssignedlistModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    vMMVId = json['VMMV_Id'];
    vMMVVisitorName = json['VMMV_VisitorName'];
    vMMVFromPlace = json['VMMV_FromPlace'];
    vMMVMeetingPurpose = json['VMMV_MeetingPurpose'];
    vMMVMeetingDateTime = json['VMMV_MeetingDateTime'];
    vMMVEntryDateTime = json['VMMV_EntryDateTime'];
    aSSIGNEDBY = json['ASSIGNEDBY'];
    vMVTMTId = json['VMVTMT_Id'];
    vMVTMTDateTime = json['VMVTMT_DateTime'];
    mIName = json['MI_Name'];
    vMVTMTMetFlg = json['VMVTMT_MetFlg'];
    vMMVCkeckedInOutStatus = json['VMMV_CkeckedInOutStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['VMMV_Id'] = vMMVId;
    data['VMMV_VisitorName'] = vMMVVisitorName;
    data['VMMV_FromPlace'] = vMMVFromPlace;
    data['VMMV_MeetingPurpose'] = vMMVMeetingPurpose;
    data['VMMV_MeetingDateTime'] = vMMVMeetingDateTime;
    data['VMMV_EntryDateTime'] = vMMVEntryDateTime;
    data['ASSIGNEDBY'] = aSSIGNEDBY;
    data['VMVTMT_Id'] = vMVTMTId;
    data['VMVTMT_DateTime'] = vMVTMTDateTime;
    data['MI_Name'] = mIName;
    data['VMVTMT_MetFlg'] = vMVTMTMetFlg;
    data['VMMV_CkeckedInOutStatus'] = vMMVCkeckedInOutStatus;
    return data;
  }
}
