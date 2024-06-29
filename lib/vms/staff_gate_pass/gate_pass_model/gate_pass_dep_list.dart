class GatePassDepartmentModel {
  String? type;
  List<GatePassDepartmentModelValues>? values;

  GatePassDepartmentModel({this.type, this.values});

  GatePassDepartmentModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GatePassDepartmentModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(GatePassDepartmentModelValues.fromJson(v));
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

class GatePassDepartmentModelValues {
  int? hrmDId;
  int? mIId;
  String? hrmDDepartmentName;
  bool? hrmDActiveFlag;
  int? hrmdCID;
  int? hrmDUpdatedBy;
  String? updatedDate;
  int? hrmDCreatedBy;
  int? hrmDOrder;
  String? createdDate;

  GatePassDepartmentModelValues(
      {this.hrmDId,
      this.mIId,
      this.hrmDDepartmentName,
      this.hrmDActiveFlag,
      this.hrmdCID,
      this.hrmDUpdatedBy,
      this.updatedDate,
      this.hrmDCreatedBy,
      this.hrmDOrder,
      this.createdDate});

  GatePassDepartmentModelValues.fromJson(Map<String, dynamic> json) {
    hrmDId = json['hrmD_Id'];
    mIId = json['mI_Id'];
    hrmDDepartmentName = json['hrmD_DepartmentName'];
    hrmDActiveFlag = json['hrmD_ActiveFlag'];
    hrmdCID = json['hrmdC_ID'];
    hrmDUpdatedBy = json['hrmD_UpdatedBy'];
    updatedDate = json['updatedDate'];
    hrmDCreatedBy = json['hrmD_CreatedBy'];
    hrmDOrder = json['hrmD_Order'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hrmD_Id'] = hrmDId;
    data['mI_Id'] = mIId;
    data['hrmD_DepartmentName'] = hrmDDepartmentName;
    data['hrmD_ActiveFlag'] = hrmDActiveFlag;
    data['hrmdC_ID'] = hrmdCID;
    data['hrmD_UpdatedBy'] = hrmDUpdatedBy;
    data['updatedDate'] = updatedDate;
    data['hrmD_CreatedBy'] = hrmDCreatedBy;
    data['hrmD_Order'] = hrmDOrder;
    data['createdDate'] = createdDate;
    return data;
  }
}
