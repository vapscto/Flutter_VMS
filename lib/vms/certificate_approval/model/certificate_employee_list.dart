class CertificateEmployeeModel {
  String? type;
  List<CertificateEmployeeModelValues>? values;

  CertificateEmployeeModel({this.type, this.values});

  CertificateEmployeeModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CertificateEmployeeModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CertificateEmployeeModelValues.fromJson(v));
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

class CertificateEmployeeModelValues {
  String? type;
  String? employeename;
  String? hRMEEmployeeCode;
  String? hRMEDOJ;
  int? hRMEMobileNo;
  int? hRMEAadharCardNo;
  String? hRMEPANCardNo;
  String? hRMEEmailId;
  int? hRMEMNOMobileNo;
  String? hRMDDepartmentName;
  String? hRMDESDesignationName;
  String? mIName;
  bool? hRMELeftFlag;
  String? hRMEDOL;
  String? hRMELeavingReason;
  String? hRMEPhoto;

  CertificateEmployeeModelValues(
      {this.type,
      this.employeename,
      this.hRMEEmployeeCode,
      this.hRMEDOJ,
      this.hRMEMobileNo,
      this.hRMEAadharCardNo,
      this.hRMEPANCardNo,
      this.hRMEEmailId,
      this.hRMEMNOMobileNo,
      this.hRMDDepartmentName,
      this.hRMDESDesignationName,
      this.mIName,
      this.hRMELeftFlag,
      this.hRMEDOL,
      this.hRMELeavingReason,
      this.hRMEPhoto});

  CertificateEmployeeModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    employeename = json['employeename'];
    hRMEEmployeeCode = json['HRME_EmployeeCode'];
    hRMEDOJ = json['HRME_DOJ'];
    hRMEMobileNo = json['HRME_MobileNo'];
    hRMEAadharCardNo = json['HRME_AadharCardNo'];
    hRMEPANCardNo = json['HRME_PANCardNo'];
    hRMEEmailId = json['HRME_EmailId'];
    hRMEMNOMobileNo = json['HRMEMNO_MobileNo'];
    hRMDDepartmentName = json['HRMD_DepartmentName'];
    hRMDESDesignationName = json['HRMDES_DesignationName'];
    mIName = json['MI_Name'];
    hRMELeftFlag = json['HRME_LeftFlag'];
    hRMEDOL = json['HRME_DOL'];
    hRMELeavingReason = json['HRME_LeavingReason'];
    hRMEPhoto = json['HRME_Photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['employeename'] = employeename;
    data['HRME_EmployeeCode'] = hRMEEmployeeCode;
    data['HRME_DOJ'] = hRMEDOJ;
    data['HRME_MobileNo'] = hRMEMobileNo;
    data['HRME_AadharCardNo'] = hRMEAadharCardNo;
    data['HRME_PANCardNo'] = hRMEPANCardNo;
    data['HRME_EmailId'] = hRMEEmailId;
    data['HRMEMNO_MobileNo'] = hRMEMNOMobileNo;
    data['HRMD_DepartmentName'] = hRMDDepartmentName;
    data['HRMDES_DesignationName'] = hRMDESDesignationName;
    data['MI_Name'] = mIName;
    data['HRME_LeftFlag'] = hRMELeftFlag;
    data['HRME_DOL'] = hRMEDOL;
    data['HRME_LeavingReason'] = hRMELeavingReason;
    data['HRME_Photo'] = hRMEPhoto;
    return data;
  }
}
