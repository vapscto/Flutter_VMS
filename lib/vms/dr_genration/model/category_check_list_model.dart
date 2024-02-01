class CategoryCheckListModel {
  String? type;
  List<CategoryCheckListModelValues>? values;

  CategoryCheckListModel({this.type, this.values});

  CategoryCheckListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CategoryCheckListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CategoryCheckListModelValues.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ismmtcatcL_Id'] = ismmtcatcLId;
    data['ismmtcaT_Id'] = ismmtcaTId;
    data['ismmtcatcL_CheckListName'] = ismmtcatcLCheckListName;
    data['ismmtcatcL_UploadEnterFlg'] = ismmtcatcLUploadEnterFlg;
    data['ismmtcatcL_ActiveFlag'] = ismmtcatcLActiveFlag;
    data['ismmtcatcL_CreatedBy'] = ismmtcatcLCreatedBy;
    data['ismmtcatcL_UpdatedBy'] = ismmtcatcLUpdatedBy;
    data['ismmtcatcL_CreatedDate'] = ismmtcatcLCreatedDate;
    return data;
  }
}
