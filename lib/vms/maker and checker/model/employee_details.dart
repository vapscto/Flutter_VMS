class GetEmployeeDetail {
  String? type;
  List<GetEmployeeDetailValues>? values;

  GetEmployeeDetail({this.type, this.values});

  GetEmployeeDetail.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetEmployeeDetailValues>[];
      json['\$values'].forEach((v) {
        values!.add(new GetEmployeeDetailValues.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    data['HRME_Id'] = this.hRMEId;
    data['HRME_EmployeeCode'] = this.hRMEEmployeeCode;
    data['EmpName'] = this.empName;
    data['HRMD_DepartmentName'] = this.hRMDDepartmentName;
    data['HRMDES_DesignationName'] = this.hRMDESDesignationName;
    data['FOEP_PunchDate'] = this.fOEPPunchDate;
    data['StartTime'] = this.startTime;
    data['EndTime'] = this.endTime;
    data['WorkingHours'] = this.workingHours;
    return data;
  }
}
