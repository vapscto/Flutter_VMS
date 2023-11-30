class ViewLeadModel {
  String? type;
  List<ViewLeadModelValues>? values;

  ViewLeadModel({this.type, this.values});

  ViewLeadModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ViewLeadModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ViewLeadModelValues.fromJson(v));
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

class ViewLeadModelValues {
  int? hrmRId;
  int? mIId;
  int? ismslEId;
  int? hrmEId;
  String? ismsledMDemoDate;
  String? ismsledMContactPerson;
  String? ismsledMDemoAddress;
  String? ismsledMRemarks;
  bool? ismsledMActiveFlag;
  int? ismsledMCreatedBy;
  int? ismsledMUpdatedBy;
  int? userId;
  String? employeename;
  String? ismslELeadName;
  int? ismsledmpRId;
  int? ismsmpRId;
  bool? ismsledmpRActiveFlag;
  int? viewall;

  ViewLeadModelValues(
      {this.hrmRId,
      this.mIId,
      this.ismslEId,
      this.hrmEId,
      this.ismsledMDemoDate,
      this.ismsledMContactPerson,
      this.ismsledMDemoAddress,
      this.ismsledMRemarks,
      this.ismsledMActiveFlag,
      this.ismsledMCreatedBy,
      this.ismsledMUpdatedBy,
      this.userId,
      this.employeename,
      this.ismslELeadName,
      this.ismsledmpRId,
      this.ismsmpRId,
      this.ismsledmpRActiveFlag,
      this.viewall});

  ViewLeadModelValues.fromJson(Map<String, dynamic> json) {
    hrmRId = json['hrmR_Id'];
    mIId = json['mI_Id'];
    ismslEId = json['ismslE_Id'];
    hrmEId = json['hrmE_Id'];
    ismsledMDemoDate = json['ismsledM_DemoDate'];
    ismsledMContactPerson = json['ismsledM_ContactPerson'];
    ismsledMDemoAddress = json['ismsledM_DemoAddress'];
    ismsledMRemarks = json['ismsledM_Remarks'];
    ismsledMActiveFlag = json['ismsledM_ActiveFlag'];
    ismsledMCreatedBy = json['ismsledM_CreatedBy'];
    ismsledMUpdatedBy = json['ismsledM_UpdatedBy'];
    userId = json['user_id'];
    employeename = json['employeename'];
    ismslELeadName = json['ismslE_LeadName'];
    ismsledmpRId = json['ismsledmpR_Id'];
    ismsmpRId = json['ismsmpR_Id'];
    ismsledmpRActiveFlag = json['ismsledmpR_ActiveFlag'];
    viewall = json['viewall'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hrmR_Id'] = hrmRId;
    data['mI_Id'] = mIId;
    data['ismslE_Id'] = ismslEId;
    data['hrmE_Id'] = hrmEId;
    data['ismsledM_DemoDate'] = ismsledMDemoDate;
    data['ismsledM_ContactPerson'] = ismsledMContactPerson;
    data['ismsledM_DemoAddress'] = ismsledMDemoAddress;
    data['ismsledM_Remarks'] = ismsledMRemarks;
    data['ismsledM_ActiveFlag'] = ismsledMActiveFlag;
    data['ismsledM_CreatedBy'] = ismsledMCreatedBy;
    data['ismsledM_UpdatedBy'] = ismsledMUpdatedBy;
    data['user_id'] = userId;
    data['employeename'] = employeename;
    data['ismslE_LeadName'] = ismslELeadName;
    data['ismsledmpR_Id'] = ismsledmpRId;
    data['ismsmpR_Id'] = ismsmpRId;
    data['ismsledmpR_ActiveFlag'] = ismsledmpRActiveFlag;
    data['viewall'] = viewall;
    return data;
  }
}
