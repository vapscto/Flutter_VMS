class GetGpsEmployeeDetails {
  String? type;
  List<GetGpsEmployeeDetailsValues>? values;

  GetGpsEmployeeDetails({this.type, this.values});

  GetGpsEmployeeDetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetGpsEmployeeDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(new GetGpsEmployeeDetailsValues.fromJson(v));
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

class GetGpsEmployeeDetailsValues {
  int? vmsatgpsLId;
  int? mIId;
  int? hrmEId;
  int? ismmclTId;
  int? ismslEId;
  bool? vmsatgpsLActiveFlg;
  int? vmsatgpsLCreatedBy;
  int? vmsatgpsLUpdatedBy;
  int? userId;
  String? hrmEEmployeeFirstName;
  String? hrmEDOJ;
  int? hrmEMobileNo;
  String? hrmEEmailId;
  String? hrmdeSDesignationName;
  String? hrmEEmployeeCode;
  bool? punchflag;

  GetGpsEmployeeDetailsValues(
      {this.vmsatgpsLId,
      this.mIId,
      this.hrmEId,
      this.ismmclTId,
      this.ismslEId,
      this.vmsatgpsLActiveFlg,
      this.vmsatgpsLCreatedBy,
      this.vmsatgpsLUpdatedBy,
      this.userId,
      this.hrmEEmployeeFirstName,
      this.hrmEDOJ,
      this.hrmEMobileNo,
      this.hrmEEmailId,
      this.hrmdeSDesignationName,
      this.hrmEEmployeeCode,
      this.punchflag});

  GetGpsEmployeeDetailsValues.fromJson(Map<String, dynamic> json) {
    vmsatgpsLId = json['vmsatgpsL_Id'];
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    ismmclTId = json['ismmclT_Id'];
    ismslEId = json['ismslE_Id'];
    vmsatgpsLActiveFlg = json['vmsatgpsL_ActiveFlg'];
    vmsatgpsLCreatedBy = json['vmsatgpsL_CreatedBy'];
    vmsatgpsLUpdatedBy = json['vmsatgpsL_UpdatedBy'];
    userId = json['userId'];
    hrmEEmployeeFirstName = json['hrmE_EmployeeFirstName'];
    hrmEDOJ = json['hrmE_DOJ'];
    hrmEMobileNo = json['hrmE_MobileNo'];
    hrmEEmailId = json['hrmE_EmailId'];
    hrmdeSDesignationName = json['hrmdeS_DesignationName'];
    hrmEEmployeeCode = json['hrmE_EmployeeCode'];
    punchflag = json['punchflag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vmsatgpsL_Id'] = this.vmsatgpsLId;
    data['mI_Id'] = this.mIId;
    data['hrmE_Id'] = this.hrmEId;
    data['ismmclT_Id'] = this.ismmclTId;
    data['ismslE_Id'] = this.ismslEId;
    data['vmsatgpsL_ActiveFlg'] = this.vmsatgpsLActiveFlg;
    data['vmsatgpsL_CreatedBy'] = this.vmsatgpsLCreatedBy;
    data['vmsatgpsL_UpdatedBy'] = this.vmsatgpsLUpdatedBy;
    data['userId'] = this.userId;
    data['hrmE_EmployeeFirstName'] = this.hrmEEmployeeFirstName;
    data['hrmE_DOJ'] = this.hrmEDOJ;
    data['hrmE_MobileNo'] = this.hrmEMobileNo;
    data['hrmE_EmailId'] = this.hrmEEmailId;
    data['hrmdeS_DesignationName'] = this.hrmdeSDesignationName;
    data['hrmE_EmployeeCode'] = this.hrmEEmployeeCode;
    data['punchflag'] = this.punchflag;
    return data;
  }
}
