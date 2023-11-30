class DemoResponseModel {
  String? type;
  List<DemoResponseModelValues>? values;

  DemoResponseModel({this.type, this.values});

  DemoResponseModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DemoResponseModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DemoResponseModelValues.fromJson(v));
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

class DemoResponseModelValues {
  int? ismsledMId;
  int? hrmRId;
  int? mIId;
  int? ismslEId;
  int? hrmEId;
  String? ismsledMDemoDate;
  bool? ismsledMActiveFlag;
  int? ismsledMCreatedBy;
  int? ismsledMUpdatedBy;
  int? userId;
  String? ismsmsTStatusName;
  int? ismsmsTId;
  String? ismsmpRProductName;
  int? ismsledmpRId;
  int? ismsmpRId;
  String? ismsledmpRDiscussionPoints;
  bool? ismsledmpRActiveFlag;
  int? viewall;
  String? ismsledmpRRemarks;

  DemoResponseModelValues(
      {this.ismsledMId,
      this.hrmRId,
      this.mIId,
      this.ismslEId,
      this.hrmEId,
      this.ismsledMDemoDate,
      this.ismsledMActiveFlag,
      this.ismsledMCreatedBy,
      this.ismsledMUpdatedBy,
      this.userId,
      this.ismsmsTStatusName,
      this.ismsmsTId,
      this.ismsmpRProductName,
      this.ismsledmpRId,
      this.ismsmpRId,
      this.ismsledmpRDiscussionPoints,
      this.ismsledmpRActiveFlag,
      this.viewall,
      this.ismsledmpRRemarks});

  DemoResponseModelValues.fromJson(Map<String, dynamic> json) {
    ismsledMId = json['ismsledM_Id'];
    hrmRId = json['hrmR_Id'];
    mIId = json['mI_Id'];
    ismslEId = json['ismslE_Id'];
    hrmEId = json['hrmE_Id'];
    ismsledMDemoDate = json['ismsledM_DemoDate'];
    ismsledMActiveFlag = json['ismsledM_ActiveFlag'];
    ismsledMCreatedBy = json['ismsledM_CreatedBy'];
    ismsledMUpdatedBy = json['ismsledM_UpdatedBy'];
    userId = json['user_id'];
    ismsmsTStatusName = json['ismsmsT_StatusName'];
    ismsmsTId = json['ismsmsT_Id'];
    ismsmpRProductName = json['ismsmpR_ProductName'];
    ismsledmpRId = json['ismsledmpR_Id'];
    ismsmpRId = json['ismsmpR_Id'];
    ismsledmpRDiscussionPoints = json['ismsledmpR_DiscussionPoints'];
    ismsledmpRActiveFlag = json['ismsledmpR_ActiveFlag'];
    viewall = json['viewall'];
    ismsledmpRRemarks = json['ismsledmpR_Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ismsledM_Id'] = ismsledMId;
    data['hrmR_Id'] = hrmRId;
    data['mI_Id'] = mIId;
    data['ismslE_Id'] = ismslEId;
    data['hrmE_Id'] = hrmEId;
    data['ismsledM_DemoDate'] = ismsledMDemoDate;
    data['ismsledM_ActiveFlag'] = ismsledMActiveFlag;
    data['ismsledM_CreatedBy'] = ismsledMCreatedBy;
    data['ismsledM_UpdatedBy'] = ismsledMUpdatedBy;
    data['user_id'] = userId;
    data['ismsmsT_StatusName'] = ismsmsTStatusName;
    data['ismsmsT_Id'] = ismsmsTId;
    data['ismsmpR_ProductName'] = ismsmpRProductName;
    data['ismsledmpR_Id'] = ismsledmpRId;
    data['ismsmpR_Id'] = ismsmpRId;
    data['ismsledmpR_DiscussionPoints'] = ismsledmpRDiscussionPoints;
    data['ismsledmpR_ActiveFlag'] = ismsledmpRActiveFlag;
    data['viewall'] = viewall;
    data['ismsledmpR_Remarks'] = ismsledmpRRemarks;
    return data;
  }
}
