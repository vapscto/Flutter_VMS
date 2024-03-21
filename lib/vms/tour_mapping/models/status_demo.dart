class StatusDemoModel {
  String? type;
  List<StatusDemoModelValues>? values;

  StatusDemoModel({this.type, this.values});

  StatusDemoModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <StatusDemoModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new StatusDemoModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ismsmsT_Id'] = this.ismsmsTId;
    data['mI_Id'] = this.mIId;
    data['ismsmsT_StatusName'] = this.ismsmsTStatusName;
    data['ismsmsT_Remarks'] = this.ismsmsTRemarks;
    data['ismsmsT_ActiveFlag'] = this.ismsmsTActiveFlag;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['ismsmsT_CreatedBy'] = this.ismsmsTCreatedBy;
    data['ismsmsT_UpdatedBy'] = this.ismsmsTUpdatedBy;
    return data;
  }
}
