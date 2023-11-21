class CategoryCheckListModel {
  String? type;
  List<CategoryCheckListModelValues>? values;

  CategoryCheckListModel({this.type, this.values});

  CategoryCheckListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CategoryCheckListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new CategoryCheckListModelValues.fromJson(v));
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

class CategoryCheckListModelValues {
  int? ismmtcatcLId;
  int? ismmtcaTId;
  String? ismmtcatcLCheckListName;
  bool? ismmtcatcLUploadEnterFlg;
  bool? ismmtcatcLActiveFlag;
  int? ismmtcatcLCreatedBy;
  int? ismmtcatcLUpdatedBy;
  String? ismmtcatcLCreatedDate;

  CategoryCheckListModelValues(
      {this.ismmtcatcLId,
      this.ismmtcaTId,
      this.ismmtcatcLCheckListName,
      this.ismmtcatcLUploadEnterFlg,
      this.ismmtcatcLActiveFlag,
      this.ismmtcatcLCreatedBy,
      this.ismmtcatcLUpdatedBy,
      this.ismmtcatcLCreatedDate});

  CategoryCheckListModelValues.fromJson(Map<String, dynamic> json) {
    ismmtcatcLId = json['ismmtcatcL_Id'];
    ismmtcaTId = json['ismmtcaT_Id'];
    ismmtcatcLCheckListName = json['ismmtcatcL_CheckListName'];
    ismmtcatcLUploadEnterFlg = json['ismmtcatcL_UploadEnterFlg'];
    ismmtcatcLActiveFlag = json['ismmtcatcL_ActiveFlag'];
    ismmtcatcLCreatedBy = json['ismmtcatcL_CreatedBy'];
    ismmtcatcLUpdatedBy = json['ismmtcatcL_UpdatedBy'];
    ismmtcatcLCreatedDate = json['ismmtcatcL_CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ismmtcatcL_Id'] = this.ismmtcatcLId;
    data['ismmtcaT_Id'] = this.ismmtcaTId;
    data['ismmtcatcL_CheckListName'] = this.ismmtcatcLCheckListName;
    data['ismmtcatcL_UploadEnterFlg'] = this.ismmtcatcLUploadEnterFlg;
    data['ismmtcatcL_ActiveFlag'] = this.ismmtcatcLActiveFlag;
    data['ismmtcatcL_CreatedBy'] = this.ismmtcatcLCreatedBy;
    data['ismmtcatcL_UpdatedBy'] = this.ismmtcatcLUpdatedBy;
    data['ismmtcatcL_CreatedDate'] = this.ismmtcatcLCreatedDate;
    return data;
  }
}
