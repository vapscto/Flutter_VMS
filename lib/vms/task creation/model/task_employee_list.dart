class TaskEmployeeListModel {
  String? type;
  List<TaskEmployeeListModelValues>? values;

  TaskEmployeeListModel({this.type, this.values});

  TaskEmployeeListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TaskEmployeeListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TaskEmployeeListModelValues.fromJson(v));
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

class TaskEmployeeListModelValues {
  String? type;
  int? hRMEId;
  int? hRMDId;
  int? hRMDCID;
  String? employeeName;
  String? hRMDDepartmentName;
  String? hRMDESDesignationName;

  TaskEmployeeListModelValues(
      {this.type,
      this.hRMEId,
      this.hRMDId,
      this.hRMDCID,
      this.employeeName,
      this.hRMDDepartmentName,
      this.hRMDESDesignationName});

  TaskEmployeeListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    hRMEId = json['HRME_Id'];
    hRMDId = json['HRMD_Id'];
    hRMDCID = json['HRMDC_ID'];
    employeeName = json['employeeName'];
    hRMDDepartmentName = json['HRMD_DepartmentName'];
    hRMDESDesignationName = json['HRMDES_DesignationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    data['HRME_Id'] = hRMEId;
    data['HRMD_Id'] = hRMDId;
    data['HRMDC_ID'] = hRMDCID;
    data['employeeName'] = employeeName;
    data['HRMD_DepartmentName'] = hRMDDepartmentName;
    data['HRMDES_DesignationName'] = hRMDESDesignationName;
    return data;
  }
}
