class NoticeEmployeeDataModel {
  String? type;
  List<NoticeEmployeeDataModelValues>? values;

  NoticeEmployeeDataModel({this.type, this.values});

  NoticeEmployeeDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <NoticeEmployeeDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(NoticeEmployeeDataModelValues.fromJson(v));
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

class NoticeEmployeeDataModelValues {
  String? type;
  String? userEmpName;
  int? hRMEId;
  String? hRMDDepartmentName;
  int? mIId;

  NoticeEmployeeDataModelValues(
      {this.type,
      this.userEmpName,
      this.hRMEId,
      this.hRMDDepartmentName,
      this.mIId});

  NoticeEmployeeDataModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    userEmpName = json['userEmpName'];
    hRMEId = json['HRME_Id'];
    hRMDDepartmentName = json['HRMD_DepartmentName'];
    mIId = json['MI_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['userEmpName'] = userEmpName;
    data['HRME_Id'] = hRMEId;
    data['HRMD_DepartmentName'] = hRMDDepartmentName;
    data['MI_Id'] = mIId;
    return data;
  }
}
