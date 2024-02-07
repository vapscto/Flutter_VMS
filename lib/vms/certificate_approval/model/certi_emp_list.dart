class CerEmployListModel {
  String? type;
  List<CerEmployListModelValues>? values;

  CerEmployListModel({this.type, this.values});

  CerEmployListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CerEmployListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CerEmployListModelValues.fromJson(v));
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

class CerEmployListModelValues {
  int? ismcertreQId;
  int? hrmEId;
  int? mIId;
  int? userId;
  int? empCode;
  String? ismcertreQRequestDate;
  bool? ismcertreQActiveFlag;
  bool? returnval;
  String? hrmEEmployeeFirstName;
  int? maxmumlevel;
  int? roleid;
  int? ismcertreqapPId;
  int? hrmedSId;
  int? yearid;
  String? ismcertreqapPApprovedDate;
  bool? ismcertreqapPFinalFlg;
  bool? approvedFlag;
  String? receiningdate;

  CerEmployListModelValues(
      {this.ismcertreQId,
      this.hrmEId,
      this.mIId,
      this.userId,
      this.empCode,
      this.ismcertreQRequestDate,
      this.ismcertreQActiveFlag,
      this.returnval,
      this.hrmEEmployeeFirstName,
      this.maxmumlevel,
      this.roleid,
      this.ismcertreqapPId,
      this.hrmedSId,
      this.yearid,
      this.ismcertreqapPApprovedDate,
      this.ismcertreqapPFinalFlg,
      this.approvedFlag,
      this.receiningdate});

  CerEmployListModelValues.fromJson(Map<String, dynamic> json) {
    ismcertreQId = json['ismcertreQ_Id'];
    hrmEId = json['hrmE_Id'];
    mIId = json['mI_Id'];
    userId = json['userId'];
    empCode = json['emp_Code'];
    ismcertreQRequestDate = json['ismcertreQ_RequestDate'];
    ismcertreQActiveFlag = json['ismcertreQ_ActiveFlag'];
    returnval = json['returnval'];
    hrmEEmployeeFirstName = json['hrmE_EmployeeFirstName'];
    maxmumlevel = json['maxmumlevel'];
    roleid = json['roleid'];
    ismcertreqapPId = json['ismcertreqapP_Id'];
    hrmedSId = json['hrmedS_Id'];
    yearid = json['yearid'];
    ismcertreqapPApprovedDate = json['ismcertreqapP_ApprovedDate'];
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
    data['ismcertreQ_ActiveFlag'] = ismcertreQActiveFlag;
    data['returnval'] = returnval;
    data['hrmE_EmployeeFirstName'] = hrmEEmployeeFirstName;
    data['maxmumlevel'] = maxmumlevel;
    data['roleid'] = roleid;
    data['ismcertreqapP_Id'] = ismcertreqapPId;
    data['hrmedS_Id'] = hrmedSId;
    data['yearid'] = yearid;
    data['ismcertreqapP_ApprovedDate'] = ismcertreqapPApprovedDate;
    data['ismcertreqapP_FinalFlg'] = ismcertreqapPFinalFlg;
    data['approved_flag'] = approvedFlag;
    data['receiningdate'] = receiningdate;
    return data;
  }
}
