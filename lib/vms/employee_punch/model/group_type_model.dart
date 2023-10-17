class GroupTypeDropdownModel {
  String? type;
  List<GroupTypeDropdownValues>? values;

  GroupTypeDropdownModel({this.type, this.values});

  GroupTypeDropdownModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GroupTypeDropdownValues>[];
      json['\$values'].forEach((v) {
        values!.add( GroupTypeDropdownValues.fromJson(v));
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

class GroupTypeDropdownValues {
  int? mIId;
  int? hrmDId;
  String? hrmDDepartmentName;
  int? hrmdeSId;
  int? hrmEId;

  GroupTypeDropdownValues(
      {this.mIId,
      this.hrmDId,
      this.hrmDDepartmentName,
      this.hrmdeSId,
      this.hrmEId});

  GroupTypeDropdownValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    hrmDId = json['hrmD_Id'];
    hrmDDepartmentName = json['hrmD_DepartmentName'];
    hrmdeSId = json['hrmdeS_Id'];
    hrmEId = json['hrmE_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mI_Id'] = this.mIId;
    data['hrmD_Id'] = this.hrmDId;
    data['hrmD_DepartmentName'] = this.hrmDDepartmentName;
    data['hrmdeS_Id'] = this.hrmdeSId;
    data['hrmE_Id'] = this.hrmEId;
    return data;
  }
  
}
