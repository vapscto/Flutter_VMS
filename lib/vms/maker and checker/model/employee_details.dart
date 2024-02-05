class GetEmployeeDetail {
  String? type;
  List<GetEmployeeDetailValues>? values;

  GetEmployeeDetail({this.type, this.values});

  GetEmployeeDetail.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetEmployeeDetailValues>[];
      json['\$values'].forEach((v) {
        values!.add(GetEmployeeDetailValues.fromJson(v));
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

class GetEmployeeDetailValues {
  String? type;
  int? hRMEId;
  String? hRMEEmployeeCode;
  String? empName;
  String? hRMDDepartmentName;
  String? hRMDESDesignationName;
  String? fOEPPunchDate;
  String? startTime;
  String? endTime;
  String? workingHours;

  GetEmployeeDetailValues(
      {this.type,
      this.hRMEId,
      this.hRMEEmployeeCode,
      this.empName,
      this.hRMDDepartmentName,
      this.hRMDESDesignationName,
      this.fOEPPunchDate,
      this.startTime,
      this.endTime,
      this.workingHours});

  GetEmployeeDetailValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    hRMEId = json['HRME_Id'];
    hRMEEmployeeCode = json['HRME_EmployeeCode'];
    empName = json['EmpName'];
    hRMDDepartmentName = json['HRMD_DepartmentName'];
    hRMDESDesignationName = json['HRMDES_DesignationName'];
    fOEPPunchDate = json['FOEP_PunchDate'];
    startTime = json['StartTime'];
    endTime = json['EndTime'];
    workingHours = json['WorkingHours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    data['HRME_Id'] = hRMEId;
    data['HRME_EmployeeCode'] = hRMEEmployeeCode;
    data['EmpName'] = empName;
    data['HRMD_DepartmentName'] = hRMDDepartmentName;
    data['HRMDES_DesignationName'] = hRMDESDesignationName;
    data['FOEP_PunchDate'] = fOEPPunchDate;
    data['StartTime'] = startTime;
    data['EndTime'] = endTime;
    data['WorkingHours'] = workingHours;
    return data;
  }
}
