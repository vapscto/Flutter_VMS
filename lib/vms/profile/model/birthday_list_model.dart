class BirthDayListModel {
  String? type;
  List<BirthDayListModelValues>? values;

  BirthDayListModel({this.type, this.values});

  BirthDayListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <BirthDayListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(BirthDayListModelValues.fromJson(v));
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

class BirthDayListModelValues {
  int? userId;
  int? ismmaCId;
  int? mIId;
  int? ivrmmSId;
  int? yearid;
  int? month;
  String? hrmEPhoto;
  int? ivrmrTId;
  int? asmaYId;
  int? ismmpRId;
  int? hrmEId;
  String? hrmEEmployeeFirstName;
  int? hrmEEmployeeCode;
  String? hrmEEmployeeLastName;
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

  BirthDayListModelValues(
      {this.userId,
      this.ismmaCId,
      this.mIId,
      this.ivrmmSId,
      this.yearid,
      this.month,
      this.hrmEPhoto,
      this.ivrmrTId,
      this.asmaYId,
      this.ismmpRId,
      this.hrmEId,
      this.hrmEEmployeeFirstName,
      this.hrmEEmployeeCode,
      this.hrmEEmployeeLastName,
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

  BirthDayListModelValues.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    ismmaCId = json['ismmaC_Id'];
    mIId = json['mI_Id'];
    ivrmmSId = json['ivrmmS_Id'];
    yearid = json['yearid'];
    month = json['month'];
    hrmEPhoto = json['hrmE_Photo'];
    ivrmrTId = json['ivrmrT_Id'];
    asmaYId = json['asmaY_Id'];
    ismmpRId = json['ismmpR_Id'];
    hrmEId = json['hrmE_Id'];
    hrmEEmployeeFirstName = json['hrmE_EmployeeFirstName'];
    hrmEEmployeeCode = json['hrmE_EmployeeCode'];
    hrmEEmployeeLastName = json['hrmE_EmployeeLastName'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['ismmaC_Id'] = ismmaCId;
    data['mI_Id'] = mIId;
    data['ivrmmS_Id'] = ivrmmSId;
    data['yearid'] = yearid;
    data['month'] = month;
    data['hrmE_Photo'] = hrmEPhoto;
    data['ivrmrT_Id'] = ivrmrTId;
    data['asmaY_Id'] = asmaYId;
    data['ismmpR_Id'] = ismmpRId;
    data['hrmE_Id'] = hrmEId;
    data['hrmE_EmployeeFirstName'] = hrmEEmployeeFirstName;
    data['hrmE_EmployeeCode'] = hrmEEmployeeCode;
    data['hrmE_EmployeeLastName'] = hrmEEmployeeLastName;
    data['hrmdeS_DesignationName'] = hrmdeSDesignationName;
    data['ivrmM_Id'] = ivrmMId;
    data['ismmmD_Id'] = ismmmDId;
    data['ismmclT_Id'] = ismmclTId;
    data['ismtcR_Id'] = ismtcRId;
    data['hrmpR_Id'] = hrmpRId;
    data['ismtcR_ReOpenFlg'] = ismtcRReOpenFlg;
    data['ismtcrastO_Id'] = ismtcrastOId;
    data['ismtcrastO_AssignedDate'] = ismtcrastOAssignedDate;
    data['ismtcrastO_AssignedBy'] = ismtcrastOAssignedBy;
    data['ismtcrastO_EffortInHrs'] = ismtcrastOEffortInHrs;
    data['ismtcrastO_ActiveFlg'] = ismtcrastOActiveFlg;
    data['ismtpltA_Id'] = ismtpltAId;
    data['ismtpL_Id'] = ismtpLId;
    data['ismtpltA_EffortInHrs'] = ismtpltAEffortInHrs;
    data['ismtplaptA_Id'] = ismtplaptAId;
    data['hrelS_TotalLeaves'] = hrelSTotalLeaves;
    data['hrelS_CBLeaves'] = hrelSCBLeaves;
    data['totalcount'] = totalcount;
    data['projectCount'] = projectCount;
    data['taskCount'] = taskCount;
    data['openCount'] = openCount;
    data['closedCount'] = closedCount;
    data['completedCount'] = completedCount;
    data['inprogressCount'] = inprogressCount;
    data['foeP_Id'] = foePId;
    data['totdayspresent'] = totdayspresent;
    data['totholiday'] = totholiday;
    data['fromdate'] = fromdate;
    data['todate'] = todate;
    data['hrmemnO_MobileNo'] = hrmemnOMobileNo;
    data['checkdeptheadcode'] = checkdeptheadcode;
    data['dR_NotApprovedTL'] = dRNotApprovedTL;
    data['blockedcount'] = blockedcount;
    data['qrflag'] = qrflag;
    data['hrmB_Id'] = hrmBId;
    data['hrmF_Id'] = hrmFId;
    data['hrmaR_Id'] = hrmaRId;
    data['currenT_DATE'] = currenTDATE;
    data['hrmdC_Id'] = hrmdCId;
    return data;
  }
}
