class DepartmentPcRequestModel {
  String? type;
  List<DepartmentPcRequestModelValues>? values;

  DepartmentPcRequestModel({this.type, this.values});

  DepartmentPcRequestModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DepartmentPcRequestModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new DepartmentPcRequestModelValues.fromJson(v));
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

class DepartmentPcRequestModelValues {
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

  DepartmentPcRequestModelValues(
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

  DepartmentPcRequestModelValues.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hrmD_Id'] = this.hrmDId;
    data['mI_Id'] = this.mIId;
    data['hrmD_DepartmentName'] = this.hrmDDepartmentName;
    data['hrmD_Order'] = this.hrmDOrder;
    data['hrmD_ActiveFlag'] = this.hrmDActiveFlag;
    data['hrmdC_ID'] = this.hrmdCID;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['hrmD_UpdatedBy'] = this.hrmDUpdatedBy;
    data['hrmD_CreatedBy'] = this.hrmDCreatedBy;
    return data;
  }
}
