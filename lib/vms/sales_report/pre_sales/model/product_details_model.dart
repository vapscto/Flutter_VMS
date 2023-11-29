class PreSalesProductModel {
  String? type;
  List<PreSalesProductModelValues>? values;

  PreSalesProductModel({this.type, this.values});

  PreSalesProductModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PreSalesProductModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(PreSalesProductModelValues.fromJson(v));
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

class PreSalesProductModelValues {
  int? hrmRId;
  int? mIId;
  int? ismslEId;
  int? hrmEId;
  String? ismsledMDemoDate;
  bool? ismsledMActiveFlag;
  int? ismsledMCreatedBy;
  int? ismsledMUpdatedBy;
  int? userId;
  String? ismsmpRProductName;
  int? ismsledmpRId;
  int? ismsmpRId;
  String? ismsledmpRDiscussionPoints;
  bool? ismsledmpRActiveFlag;
  int? viewall;

  PreSalesProductModelValues(
      {this.hrmRId,
      this.mIId,
      this.ismslEId,
      this.hrmEId,
      this.ismsledMDemoDate,
      this.ismsledMActiveFlag,
      this.ismsledMCreatedBy,
      this.ismsledMUpdatedBy,
      this.userId,
      this.ismsmpRProductName,
      this.ismsledmpRId,
      this.ismsmpRId,
      this.ismsledmpRDiscussionPoints,
      this.ismsledmpRActiveFlag,
      this.viewall});

  PreSalesProductModelValues.fromJson(Map<String, dynamic> json) {
    hrmRId = json['hrmR_Id'];
    mIId = json['mI_Id'];
    ismslEId = json['ismslE_Id'];
    hrmEId = json['hrmE_Id'];
    ismsledMDemoDate = json['ismsledM_DemoDate'];
    ismsledMActiveFlag = json['ismsledM_ActiveFlag'];
    ismsledMCreatedBy = json['ismsledM_CreatedBy'];
    ismsledMUpdatedBy = json['ismsledM_UpdatedBy'];
    userId = json['user_id'];
    ismsmpRProductName = json['ismsmpR_ProductName'];
    ismsledmpRId = json['ismsledmpR_Id'];
    ismsmpRId = json['ismsmpR_Id'];
    ismsledmpRDiscussionPoints = json['ismsledmpR_DiscussionPoints'];
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
    data['ismsledM_ActiveFlag'] = ismsledMActiveFlag;
    data['ismsledM_CreatedBy'] = ismsledMCreatedBy;
    data['ismsledM_UpdatedBy'] = ismsledMUpdatedBy;
    data['user_id'] = userId;
    data['ismsmpR_ProductName'] = ismsmpRProductName;
    data['ismsledmpR_Id'] = ismsledmpRId;
    data['ismsmpR_Id'] = ismsmpRId;
    data['ismsledmpR_DiscussionPoints'] = ismsledmpRDiscussionPoints;
    data['ismsledmpR_ActiveFlag'] = ismsledmpRActiveFlag;
    data['viewall'] = viewall;
    return data;
  }
}
