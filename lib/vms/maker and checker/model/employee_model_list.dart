class EmployeeModelList {
  String? type;
  List<EmployeeModelListValues>? values;

  EmployeeModelList({this.type, this.values});

  EmployeeModelList.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <EmployeeModelListValues>[];
      json['\$values'].forEach((v) {
        values!.add(  EmployeeModelListValues.fromJson(v));
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

class EmployeeModelListValues {
  String? type;
  int? hRMEId;
  int? hRMDId;
  String? userEmpName;
  String? hRMDDepartmentName;
  int? mIId;

  EmployeeModelListValues(
      {this.type,
      this.hRMEId,
      this.hRMDId,
      this.userEmpName,
      this.hRMDDepartmentName,
      this.mIId});

  EmployeeModelListValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    hRMEId = json['HRME_Id'];
    hRMDId = json['HRMD_Id'];
    userEmpName = json['userEmpName'];
    hRMDDepartmentName = json['HRMD_DepartmentName'];
    mIId = json['MI_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    data['HRME_Id'] = this.hRMEId;
    data['HRMD_Id'] = this.hRMDId;
    data['userEmpName'] = this.userEmpName;
    data['HRMD_DepartmentName'] = this.hRMDDepartmentName;
    data['MI_Id'] = this.mIId;
    return data;
  }
}
