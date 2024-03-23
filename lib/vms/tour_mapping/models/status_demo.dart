class StatusDemoModel {
  String? type;
  List<StatusDemoModelValues>? values;

  StatusDemoModel({this.type, this.values});

  StatusDemoModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <StatusDemoModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(StatusDemoModelValues.fromJson(v));
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

class StatusDemoModelValues {
  int? ismsmsTId;
  int? mIId;
  String? ismsmsTStatusName;
  String? ismsmsTRemarks;
  bool? ismsmsTActiveFlag;
  String? createdDate;
  String? updatedDate;
  int? ismsmsTCreatedBy;
  int? ismsmsTUpdatedBy;

  StatusDemoModelValues(
      {this.ismsmsTId,
      this.mIId,
      this.ismsmsTStatusName,
      this.ismsmsTRemarks,
      this.ismsmsTActiveFlag,
      this.createdDate,
      this.updatedDate,
      this.ismsmsTCreatedBy,
      this.ismsmsTUpdatedBy});

  StatusDemoModelValues.fromJson(Map<String, dynamic> json) {
    ismsmsTId = json['ismsmsT_Id'];
    mIId = json['mI_Id'];
    ismsmsTStatusName = json['ismsmsT_StatusName'];
    ismsmsTRemarks = json['ismsmsT_Remarks'];
    ismsmsTActiveFlag = json['ismsmsT_ActiveFlag'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    ismsmsTCreatedBy = json['ismsmsT_CreatedBy'];
    ismsmsTUpdatedBy = json['ismsmsT_UpdatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ismsmsT_Id'] = ismsmsTId;
    data['mI_Id'] = mIId;
    data['ismsmsT_StatusName'] = ismsmsTStatusName;
    data['ismsmsT_Remarks'] = ismsmsTRemarks;
    data['ismsmsT_ActiveFlag'] = ismsmsTActiveFlag;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['ismsmsT_CreatedBy'] = ismsmsTCreatedBy;
    data['ismsmsT_UpdatedBy'] = ismsmsTUpdatedBy;
    return data;
  }
}
