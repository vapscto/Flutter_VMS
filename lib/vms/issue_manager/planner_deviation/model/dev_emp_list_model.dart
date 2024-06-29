class DeviationEmpModel {
  String? type;
  List<DeviationEmpModelValues>? values;

  DeviationEmpModel({this.type, this.values});

  DeviationEmpModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DeviationEmpModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DeviationEmpModelValues.fromJson(v));
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

class DeviationEmpModelValues {
  String? type;
  int? hRMEId;
  int? hRMDId;
  String? userEmpName;
  String? hRMDDepartmentName;
  int? mIId;

  DeviationEmpModelValues(
      {this.type,
      this.hRMEId,
      this.hRMDId,
      this.userEmpName,
      this.hRMDDepartmentName,
      this.mIId});

  DeviationEmpModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEId = json['HRME_Id'];
    hRMDId = json['HRMD_Id'];
    userEmpName = json['userEmpName'];
    hRMDDepartmentName = json['HRMD_DepartmentName'];
    mIId = json['MI_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRME_Id'] = hRMEId;
    data['HRMD_Id'] = hRMDId;
    data['userEmpName'] = userEmpName;
    data['HRMD_DepartmentName'] = hRMDDepartmentName;
    data['MI_Id'] = mIId;
    return data;
  }
}
