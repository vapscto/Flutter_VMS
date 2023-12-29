class GridOptionslistModel {
  String? type;
  List<GridOptionslistModelValues>? values;

  GridOptionslistModel({this.type, this.values});

  GridOptionslistModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GridOptionslistModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(GridOptionslistModelValues.fromJson(v));
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

class GridOptionslistModelValues {
  String? type;
  int? vMMVId;
  String? vMMVVisitorName;
  String? vMMVFromPlace;
  String? vMMVMeetingPurpose;
  String? vMMVMeetingDateTime;
  String? vMMVEntryDateTime;
  String? tOMEET;
  String? aSSIGNEDBY;
  int? vMVTMTId;
  String? vMVTMTDateTime;

  GridOptionslistModelValues(
      {this.type,
      this.vMMVId,
      this.vMMVVisitorName,
      this.vMMVFromPlace,
      this.vMMVMeetingPurpose,
      this.vMMVMeetingDateTime,
      this.vMMVEntryDateTime,
      this.tOMEET,
      this.aSSIGNEDBY,
      this.vMVTMTId,
      this.vMVTMTDateTime});

  GridOptionslistModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    vMMVId = json['VMMV_Id'];
    vMMVVisitorName = json['VMMV_VisitorName'];
    vMMVFromPlace = json['VMMV_FromPlace'];
    vMMVMeetingPurpose = json['VMMV_MeetingPurpose'];
    vMMVMeetingDateTime = json['VMMV_MeetingDateTime'];
    vMMVEntryDateTime = json['VMMV_EntryDateTime'];
    tOMEET = json['TOMEET'];
    aSSIGNEDBY = json['ASSIGNEDBY'];
    vMVTMTId = json['VMVTMT_Id'];
    vMVTMTDateTime = json['VMVTMT_DateTime'];
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
    data['TOMEET'] = tOMEET;
    data['ASSIGNEDBY'] = aSSIGNEDBY;
    data['VMVTMT_Id'] = vMVTMTId;
    data['VMVTMT_DateTime'] = vMVTMTDateTime;
    return data;
  }
}
