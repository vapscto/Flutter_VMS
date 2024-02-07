class PreviousApprovedModel {
  String? type;
  List<PreviousApprovedModelValues>? values;

  PreviousApprovedModel({this.type, this.values});

  PreviousApprovedModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PreviousApprovedModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(PreviousApprovedModelValues.fromJson(v));
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

class PreviousApprovedModelValues {
  int? ismcertreQId;
  int? hrmEId;
  int? mIId;
  int? userId;
  int? empCode;
  String? ismcertreQRequestDate;
  String? ismcertreQRemarks;
  bool? ismcertreQActiveFlag;
  bool? returnval;
  String? hrmEEmployeeFirstName;
  int? maxmumlevel;
  int? roleid;
  int? ismcertreqapPId;
  int? hrmedSId;
  int? yearid;
  String? ismcertreqapPRemarks;
  String? ismcertreqapPAppRejFlag;
  String? ismcertreqapPApprovedDate;
  String? ismcertreqapPReceiningDate;
  bool? ismcertreqapPFinalFlg;
  bool? approvedFlag;
  String? receiningdate;

  PreviousApprovedModelValues(
      {this.ismcertreQId,
      this.hrmEId,
      this.mIId,
      this.userId,
      this.empCode,
      this.ismcertreQRequestDate,
      this.ismcertreQRemarks,
      this.ismcertreQActiveFlag,
      this.returnval,
      this.hrmEEmployeeFirstName,
      this.maxmumlevel,
      this.roleid,
      this.ismcertreqapPId,
      this.hrmedSId,
      this.yearid,
      this.ismcertreqapPRemarks,
      this.ismcertreqapPAppRejFlag,
      this.ismcertreqapPApprovedDate,
      this.ismcertreqapPReceiningDate,
      this.ismcertreqapPFinalFlg,
      this.approvedFlag,
      this.receiningdate});

  PreviousApprovedModelValues.fromJson(Map<String, dynamic> json) {
    ismcertreQId = json['ismcertreQ_Id'];
    hrmEId = json['hrmE_Id'];
    mIId = json['mI_Id'];
    userId = json['userId'];
    empCode = json['emp_Code'];
    ismcertreQRequestDate = json['ismcertreQ_RequestDate'];
    ismcertreQRemarks = json['ismcertreQ_Remarks'];
    ismcertreQActiveFlag = json['ismcertreQ_ActiveFlag'];
    returnval = json['returnval'];
    hrmEEmployeeFirstName = json['hrmE_EmployeeFirstName'];
    maxmumlevel = json['maxmumlevel'];
    roleid = json['roleid'];
    ismcertreqapPId = json['ismcertreqapP_Id'];
    hrmedSId = json['hrmedS_Id'];
    yearid = json['yearid'];
    ismcertreqapPRemarks = json['ismcertreqapP_Remarks'];
    ismcertreqapPAppRejFlag = json['ismcertreqapP_AppRejFlag'];
    ismcertreqapPApprovedDate = json['ismcertreqapP_ApprovedDate'];
    ismcertreqapPReceiningDate = json['ismcertreqapP_ReceiningDate'];
    ismcertreqapPFinalFlg = json['ismcertreqapP_FinalFlg'];
    approvedFlag = json['approved_flag'];
    receiningdate = json['receiningdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ismcertreQ_Id'] = ismcertreQId;
    data['hrmE_Id'] = hrmEId;
    data['mI_Id'] = mIId;
    data['userId'] = userId;
    data['emp_Code'] = empCode;
    data['ismcertreQ_RequestDate'] = ismcertreQRequestDate;
    data['ismcertreQ_Remarks'] = ismcertreQRemarks;
    data['ismcertreQ_ActiveFlag'] = ismcertreQActiveFlag;
    data['returnval'] = returnval;
    data['hrmE_EmployeeFirstName'] = hrmEEmployeeFirstName;
    data['maxmumlevel'] = maxmumlevel;
    data['roleid'] = roleid;
    data['ismcertreqapP_Id'] = ismcertreqapPId;
    data['hrmedS_Id'] = hrmedSId;
    data['yearid'] = yearid;
    data['ismcertreqapP_Remarks'] = ismcertreqapPRemarks;
    data['ismcertreqapP_AppRejFlag'] = ismcertreqapPAppRejFlag;
    data['ismcertreqapP_ApprovedDate'] = ismcertreqapPApprovedDate;
    data['ismcertreqapP_ReceiningDate'] = ismcertreqapPReceiningDate;
    data['ismcertreqapP_FinalFlg'] = ismcertreqapPFinalFlg;
    data['approved_flag'] = approvedFlag;
    data['receiningdate'] = receiningdate;
    return data;
  }
}
