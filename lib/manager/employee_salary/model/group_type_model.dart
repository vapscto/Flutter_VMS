class GroupTypeDropdownModel {
  String? type;
  List<GroupTypeDropdownValues>? values;

  GroupTypeDropdownModel({this.type, this.values});

  GroupTypeDropdownModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GroupTypeDropdownValues>[];
      json['\$values'].forEach((v) {
        values!.add(GroupTypeDropdownValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    if (values != null) {
      data['$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupTypeDropdownValues {
  int? hrmDId;
  int? mIId;
  String? hrmDDepartmentName;
  int? hrmDOrder;
  bool? hrmDActiveFlag;
  String? createdDate;
  String? updatedDate;

  GroupTypeDropdownValues(
      {this.hrmDId,
      this.mIId,
      this.hrmDDepartmentName,
      this.hrmDOrder,
      this.hrmDActiveFlag,
      this.createdDate,
      this.updatedDate});

  GroupTypeDropdownValues.fromJson(Map<String, dynamic> json) {
    hrmDId = json['hrmD_Id'];
    mIId = json['mI_Id'];
    hrmDDepartmentName = json['hrmD_DepartmentName'];
    hrmDOrder = json['hrmD_Order'];
    hrmDActiveFlag = json['hrmD_ActiveFlag'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hrmD_Id'] = hrmDId;
    data['mI_Id'] = mIId;
    data['hrmD_DepartmentName'] = hrmDDepartmentName;
    data['hrmD_Order'] = hrmDOrder;
    data['hrmD_ActiveFlag'] = hrmDActiveFlag;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
