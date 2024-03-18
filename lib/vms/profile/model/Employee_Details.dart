class EmployeeDetails {
  String? type;
  List<EmployeeDetailsValues>? values;

  EmployeeDetails({this.type, this.values});

  EmployeeDetails.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <EmployeeDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(EmployeeDetailsValues.fromJson(v));
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

class EmployeeDetailsValues {
  int? userId;
  int? ismmaCId;
  int? mIId;
  int? ivrmmSId;
  int? yearid;
  int? month;
  String? hrmEPhoto;
  int? ivrmrTId;
  int? asmaYId;
  int? hrmDId;
  int? hrmdeSId;
  int? ismmpRId;
  int? hrmEId;
  String? hrmEEmployeeFirstName;
  int? hrmEEmployeeCode;
  String? hrmEEmployeeLastName;
  String? hrmDDepartmentName;
  String? hrmdeSDesignationName;
  int? ivrmMId;
  int? ismmmDId;
  int? ismmclTId;
  int? ismtcRId;
  int? hrmpRId;
  bool? ismtcRReOpenFlg;
  int? ismtcrastOId;
  String? ismtcrastOAssignedDate;
  int? ismtcrastOAssignedBy;
  int? ismtcrastOEffortInHrs;
  bool? ismtcrastOActiveFlg;
  String? deviceID;
  int? ismtpltAId;
  int? ismtpLId;
  int? ismtpltAEffortInHrs;
  int? ismtplaptAId;
  double? hrelSTotalLeaves;
  double? hrelSCBLeaves;
  int? totalcount;
  int? projectCount;
  int? taskCount;
  int? openCount;
  int? closedCount;
  int? completedCount;
  int? inprogressCount;
  String? hrmEDOB;
  int? foePId;
  int? totdayspresent;
  int? totholiday;
  String? fromdate;
  String? todate;
  int? hrmemnOMobileNo;
  int? checkdeptheadcode;
  int? dRNotApprovedTL;
  int? blockedcount;
  bool? qrflag;
  int? hrmBId;
  int? hrmFId;
  int? hrmaRId;
  String? currenTDATE;
  int? hrmdCId;

  EmployeeDetailsValues(
      {this.userId,
      this.ismmaCId,
      this.mIId,
      this.ivrmmSId,
      this.yearid,
      this.month,
      this.hrmEPhoto,
      this.ivrmrTId,
      this.asmaYId,
      this.hrmDId,
      this.hrmdeSId,
      this.ismmpRId,
      this.hrmEId,
      this.hrmEEmployeeFirstName,
      this.hrmEEmployeeCode,
      this.hrmEEmployeeLastName,
      this.hrmDDepartmentName,
      this.hrmdeSDesignationName,
      this.ivrmMId,
      this.ismmmDId,
      this.ismmclTId,
      this.ismtcRId,
      this.hrmpRId,
      this.ismtcRReOpenFlg,
      this.ismtcrastOId,
      this.ismtcrastOAssignedDate,
      this.ismtcrastOAssignedBy,
      this.ismtcrastOEffortInHrs,
      this.ismtcrastOActiveFlg,
      this.deviceID,
      this.ismtpltAId,
      this.ismtpLId,
      this.ismtpltAEffortInHrs,
      this.ismtplaptAId,
      this.hrelSTotalLeaves,
      this.hrelSCBLeaves,
      this.totalcount,
      this.projectCount,
      this.taskCount,
      this.openCount,
      this.closedCount,
      this.completedCount,
      this.inprogressCount,
      this.hrmEDOB,
      this.foePId,
      this.totdayspresent,
      this.totholiday,
      this.fromdate,
      this.todate,
      this.hrmemnOMobileNo,
      this.checkdeptheadcode,
      this.dRNotApprovedTL,
      this.blockedcount,
      this.qrflag,
      this.hrmBId,
      this.hrmFId,
      this.hrmaRId,
      this.currenTDATE,
      this.hrmdCId});

  EmployeeDetailsValues.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    ismmaCId = json['ismmaC_Id'];
    mIId = json['mI_Id'];
    ivrmmSId = json['ivrmmS_Id'];
    yearid = json['yearid'];
    month = json['month'];
    hrmEPhoto = json['hrmE_Photo'];
    ivrmrTId = json['ivrmrT_Id'];
    asmaYId = json['asmaY_Id'];
    hrmDId = json['hrmD_Id'];
    hrmdeSId = json['hrmdeS_Id'];
    ismmpRId = json['ismmpR_Id'];
    hrmEId = json['hrmE_Id'];
    hrmEEmployeeFirstName = json['hrmE_EmployeeFirstName'];
    hrmEEmployeeCode = json['hrmE_EmployeeCode'];
    hrmEEmployeeLastName = json['hrmE_EmployeeLastName'];
    hrmDDepartmentName = json['hrmD_DepartmentName'];
    hrmdeSDesignationName = json['hrmdeS_DesignationName'];
    ivrmMId = json['ivrmM_Id'];
    ismmmDId = json['ismmmD_Id'];
    ismmclTId = json['ismmclT_Id'];
    ismtcRId = json['ismtcR_Id'];
    hrmpRId = json['hrmpR_Id'];
    ismtcRReOpenFlg = json['ismtcR_ReOpenFlg'];
    ismtcrastOId = json['ismtcrastO_Id'];
    ismtcrastOAssignedDate = json['ismtcrastO_AssignedDate'];
    ismtcrastOAssignedBy = json['ismtcrastO_AssignedBy'];
    ismtcrastOEffortInHrs = json['ismtcrastO_EffortInHrs'];
    ismtcrastOActiveFlg = json['ismtcrastO_ActiveFlg'];
    deviceID = json['deviceID'];
    ismtpltAId = json['ismtpltA_Id'];
    ismtpLId = json['ismtpL_Id'];
    ismtpltAEffortInHrs = json['ismtpltA_EffortInHrs'];
    ismtplaptAId = json['ismtplaptA_Id'];
    hrelSTotalLeaves = json['hrelS_TotalLeaves'];
    hrelSCBLeaves = json['hrelS_CBLeaves'];
    totalcount = json['totalcount'];
    projectCount = json['projectCount'];
    taskCount = json['taskCount'];
    openCount = json['openCount'];
    closedCount = json['closedCount'];
    completedCount = json['completedCount'];
    inprogressCount = json['inprogressCount'];
    hrmEDOB = json['hrmE_DOB'];
    foePId = json['foeP_Id'];
    totdayspresent = json['totdayspresent'];
    totholiday = json['totholiday'];
    fromdate = json['fromdate'];
    todate = json['todate'];
    hrmemnOMobileNo = json['hrmemnO_MobileNo'];
    checkdeptheadcode = json['checkdeptheadcode'];
    dRNotApprovedTL = json['dR_NotApprovedTL'];
    blockedcount = json['blockedcount'];
    qrflag = json['qrflag'];
    hrmBId = json['hrmB_Id'];
    hrmFId = json['hrmF_Id'];
    hrmaRId = json['hrmaR_Id'];
    currenTDATE = json['currenT_DATE'];
    hrmdCId = json['hrmdC_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['ismmaC_Id'] = this.ismmaCId;
    data['mI_Id'] = this.mIId;
    data['ivrmmS_Id'] = this.ivrmmSId;
    data['yearid'] = this.yearid;
    data['month'] = this.month;
    data['hrmE_Photo'] = this.hrmEPhoto;
    data['ivrmrT_Id'] = this.ivrmrTId;
    data['asmaY_Id'] = this.asmaYId;
    data['hrmD_Id'] = this.hrmDId;
    data['hrmdeS_Id'] = this.hrmdeSId;
    data['ismmpR_Id'] = this.ismmpRId;
    data['hrmE_Id'] = this.hrmEId;
    data['hrmE_EmployeeFirstName'] = this.hrmEEmployeeFirstName;
    data['hrmE_EmployeeCode'] = this.hrmEEmployeeCode;
    data['hrmE_EmployeeLastName'] = this.hrmEEmployeeLastName;
    data['hrmD_DepartmentName'] = this.hrmDDepartmentName;
    data['hrmdeS_DesignationName'] = this.hrmdeSDesignationName;
    data['ivrmM_Id'] = this.ivrmMId;
    data['ismmmD_Id'] = this.ismmmDId;
    data['ismmclT_Id'] = this.ismmclTId;
    data['ismtcR_Id'] = this.ismtcRId;
    data['hrmpR_Id'] = this.hrmpRId;
    data['ismtcR_ReOpenFlg'] = this.ismtcRReOpenFlg;
    data['ismtcrastO_Id'] = this.ismtcrastOId;
    data['ismtcrastO_AssignedDate'] = this.ismtcrastOAssignedDate;
    data['ismtcrastO_AssignedBy'] = this.ismtcrastOAssignedBy;
    data['ismtcrastO_EffortInHrs'] = this.ismtcrastOEffortInHrs;
    data['ismtcrastO_ActiveFlg'] = this.ismtcrastOActiveFlg;
    data['deviceID'] = this.deviceID;
    data['ismtpltA_Id'] = this.ismtpltAId;
    data['ismtpL_Id'] = this.ismtpLId;
    data['ismtpltA_EffortInHrs'] = this.ismtpltAEffortInHrs;
    data['ismtplaptA_Id'] = this.ismtplaptAId;
    data['hrelS_TotalLeaves'] = this.hrelSTotalLeaves;
    data['hrelS_CBLeaves'] = this.hrelSCBLeaves;
    data['totalcount'] = this.totalcount;
    data['projectCount'] = this.projectCount;
    data['taskCount'] = this.taskCount;
    data['openCount'] = this.openCount;
    data['closedCount'] = this.closedCount;
    data['completedCount'] = this.completedCount;
    data['inprogressCount'] = this.inprogressCount;
    data['hrmE_DOB'] = this.hrmEDOB;
    data['foeP_Id'] = this.foePId;
    data['totdayspresent'] = this.totdayspresent;
    data['totholiday'] = this.totholiday;
    data['fromdate'] = this.fromdate;
    data['todate'] = this.todate;
    data['hrmemnO_MobileNo'] = this.hrmemnOMobileNo;
    data['checkdeptheadcode'] = this.checkdeptheadcode;
    data['dR_NotApprovedTL'] = this.dRNotApprovedTL;
    data['blockedcount'] = this.blockedcount;
    data['qrflag'] = this.qrflag;
    data['hrmB_Id'] = this.hrmBId;
    data['hrmF_Id'] = this.hrmFId;
    data['hrmaR_Id'] = this.hrmaRId;
    data['currenT_DATE'] = this.currenTDATE;
    data['hrmdC_Id'] = this.hrmdCId;
    return data;
  }
}
