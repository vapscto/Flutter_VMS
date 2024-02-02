class ExtensionEmployeeModel {
  String? type;
  List<ExtensionEmployeeModelValues>? values;

  ExtensionEmployeeModel({this.type, this.values});

  ExtensionEmployeeModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ExtensionEmployeeModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ExtensionEmployeeModelValues.fromJson(v));
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

class ExtensionEmployeeModelValues {
  String? type;
  int? hRMEId;
  int? hRMDId;
  String? employeeName;
  String? hRMEEmployeeCode;
  String? hRMDDepartmentName;
  String? mIName;

  ExtensionEmployeeModelValues(
      {this.type,
      this.hRMEId,
      this.hRMDId,
      this.employeeName,
      this.hRMEEmployeeCode,
      this.hRMDDepartmentName,
      this.mIName});

  ExtensionEmployeeModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEId = json['HRME_Id'];
    hRMDId = json['HRMD_Id'];
    employeeName = json['employeeName'];
    hRMEEmployeeCode = json['HRME_EmployeeCode'];
    hRMDDepartmentName = json['HRMD_DepartmentName'];
    mIName = json['MI_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRME_Id'] = hRMEId;
    data['HRMD_Id'] = hRMDId;
    data['employeeName'] = employeeName;
    data['HRME_EmployeeCode'] = hRMEEmployeeCode;
    data['HRMD_DepartmentName'] = hRMDDepartmentName;
    data['MI_Name'] = mIName;
    return data;
  }
}
