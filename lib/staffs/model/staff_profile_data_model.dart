class StaffProfileDataModel {
  String? type;
  List<StaffProfileDataModelValues>? values;

  StaffProfileDataModel({this.type, this.values});

  StaffProfileDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <StaffProfileDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(StaffProfileDataModelValues.fromJson(v));
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

class StaffProfileDataModelValues {
  String? type;
  int? hRMEId;
  String? hRMEPhoto;
  String? empName;
  int? hRMEMobileNo;
  String? hRMEEmployeeCode;
  int? hRMEMNOMobileNo;
  String? hRMEMEmailId;
  String? hRMDDepartmentName;
  String? hRMDESDesignationName;
  String? mIName;
  String? mIAddress;

  StaffProfileDataModelValues(
      {this.type,
      this.hRMEId,
      this.hRMEPhoto,
      this.empName,
      this.hRMEMobileNo,
      this.hRMEEmployeeCode,
      this.hRMEMNOMobileNo,
      this.hRMEMEmailId,
      this.hRMDDepartmentName,
      this.hRMDESDesignationName,
      this.mIName,
      this.mIAddress});

  StaffProfileDataModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEId = json['HRME_Id'];
    hRMEPhoto = json['HRME_Photo'];
    empName = json['emp_name'];
    hRMEMobileNo = json['HRME_MobileNo'];
    hRMEMNOMobileNo = json['HRMEMNO_MobileNo'];
    hRMEMEmailId = json['HRMEM_EmailId'];
    hRMDDepartmentName = json['HRMD_DepartmentName'];
    hRMDESDesignationName = json['HRMDES_DesignationName'];
    mIName = json['MI_Name'];
    mIAddress = json['MI_address'];
    hRMEEmployeeCode = json['HRME_EmployeeCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRME_Id'] = hRMEId;
    data['HRME_Photo'] = hRMEPhoto;
    data['emp_name'] = empName;
    data['HRME_MobileNo'] = hRMEMobileNo;
    data['HRMEMNO_MobileNo'] = hRMEMNOMobileNo;
    data['HRMEM_EmailId'] = hRMEMEmailId;
    data['HRMD_DepartmentName'] = hRMDDepartmentName;
    data['HRMDES_DesignationName'] = hRMDESDesignationName;
    data['MI_Name'] = mIName;
    data['MI_address'] = mIAddress;
    data['HRME_EmployeeCode'] = hRMEEmployeeCode;
    return data;
  }
}
