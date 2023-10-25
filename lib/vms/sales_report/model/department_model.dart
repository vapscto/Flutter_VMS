class DepartmentListModel {
  String? type;
  List<DepartmentListModelValues>? values;

  DepartmentListModel({this.type, this.values});

  DepartmentListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DepartmentListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DepartmentListModelValues.fromJson(v));
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

class DepartmentListModelValues {
  int? hrmDId;
  int? mIId;
  String? hrmDDepartmentName;
  int? hrmDOrder;
  bool? hrmDActiveFlag;
  int? hrmdCID;
  String? createdDate;
  String? updatedDate;
  int? hrmDUpdatedBy;
  int? hrmDCreatedBy;

  DepartmentListModelValues(
      {this.hrmDId,
      this.mIId,
      this.hrmDDepartmentName,
      this.hrmDOrder,
      this.hrmDActiveFlag,
      this.hrmdCID,
      this.createdDate,
      this.updatedDate,
      this.hrmDUpdatedBy,
      this.hrmDCreatedBy});

  DepartmentListModelValues.fromJson(Map<String, dynamic> json) {
    hrmDId = json['hrmD_Id'];
    mIId = json['mI_Id'];
    hrmDDepartmentName = json['hrmD_DepartmentName'];
    hrmDOrder = json['hrmD_Order'];
    hrmDActiveFlag = json['hrmD_ActiveFlag'];
    hrmdCID = json['hrmdC_ID'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    hrmDUpdatedBy = json['hrmD_UpdatedBy'];
    hrmDCreatedBy = json['hrmD_CreatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hrmD_Id'] = hrmDId;
    data['mI_Id'] = mIId;
    data['hrmD_DepartmentName'] = hrmDDepartmentName;
    data['hrmD_Order'] = hrmDOrder;
    data['hrmD_ActiveFlag'] = hrmDActiveFlag;
    data['hrmdC_ID'] = hrmdCID;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['hrmD_UpdatedBy'] = hrmDUpdatedBy;
    data['hrmD_CreatedBy'] = hrmDCreatedBy;
    return data;
  }
}
