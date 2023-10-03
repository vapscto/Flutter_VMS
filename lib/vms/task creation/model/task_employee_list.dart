class TaskEmployeeListModel {
  String? type;
  List<TaskEmployeeListModelValues>? values;

  TaskEmployeeListModel({this.type, this.values});

  TaskEmployeeListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TaskEmployeeListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new TaskEmployeeListModelValues.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    data['HRME_Id'] = this.hRMEId;
    data['HRMD_Id'] = this.hRMDId;
    data['HRMDC_ID'] = this.hRMDCID;
    data['employeeName'] = this.employeeName;
    data['HRMD_DepartmentName'] = this.hRMDDepartmentName;
    data['HRMDES_DesignationName'] = this.hRMDESDesignationName;
    return data;
  }
}
