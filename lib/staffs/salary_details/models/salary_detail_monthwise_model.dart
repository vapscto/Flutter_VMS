class SalaryDetailsMonthwise {
  String? type;
  List<SalaryDetailsMonthwiseValues>? values;

  SalaryDetailsMonthwise({this.type, this.values});

  SalaryDetailsMonthwise.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <SalaryDetailsMonthwiseValues>[];
      json['\$values'].forEach((v) {
        values!.add(SalaryDetailsMonthwiseValues.fromJson(v));
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

class SalaryDetailsMonthwiseValues {
  int? emeRId;
  int? intBId;
  int? roleid;
  int? paymentNootificationStaff;
  bool? disabledint;
  bool? blockdashboard;
  bool? disabledorg;
  bool? disablesubscription;
  bool? subscriptionover;
  String? monthName;
  double? salary;
  int? mIId;
  int? hrmEId;
  int? asmaYId;
  int? periodCount;
  bool? ttmdpTActiveFlag;
  int? asmcLId;
  int? asmSId;
  int? ismSId;
  bool? asmcLActiveFlag;
  int? dayCount;
  int? ttmDId;
  int? studentcount;
  int? amstId;
  String? amstDob;
  int? amayRollNo;
  int? rollno;
  int? amstMobile;
  String? studentdob;
  int? id;
  int? hreSId;
  int? hresId;
  String? hreSYear;
  int? userId;
  bool? hrmLLeaveCreditFlg;
  int? ivrMMonthId;
  bool? isActive;
  int? ivrMMonthMaxDays;
  String? hrmEDOL;
  int? hreobLId;
  int? hrmlYId;
  String? hreobLDate;
  int? hreobLOBLeaves;
  int? hrelTId;
  int? hrelTLeaveId;
  String? hrelTFromDate;
  String? hrelTToDate;
  double? hrelTTotDays;
  String? hrelTReportingdate;
  bool? hrelTActiveFlag;
  int? hrmldcfMId;
  int? hrmldcFId;
  int? hrmldcfMMonthId;
  int? hrelCId;
  String? hrelCDate;
  int? hrelCCrLeaves;
  double? hrmGPayScaleFrom;
  double? hrmGIncrementOf;
  double? hrmGPayScaleTo;
  int? hrmGOrder;
  bool? hrmGActiveFlag;
  int? hrlAId;
  int? hrlaoNId;
  int? hrlaoNSanctionLevelNo;
  bool? hrlaoNFinalFlg;
  int? hreltDId;
  String? hreltDFromDate;
  String? hreltDToDate;
  bool? hreltDLWPFlag;
  int? hrelSId;
  double? hrelSOBLeaves;
  double? hrelSCreditedLeaves;
  double? hrelSTotalLeaves;
  double? hrelSTransLeaves;
  int? hrelSEncashedLeaves;
  double? hrelSCBLeaves;
  int? hrelaPId;
  int? hrelaPApplicationID;
  int? hrelaPTotalDays;
  int? hrelaPContactNoOnLeave;
  bool? hrelaPFinalFlag;
  bool? hrelaPActiveFlag;
  String? hrmlYFromDate;
  String? hrmlYToDate;
  bool? hrmlYActiveFlag;
  int? hrmldcMId;
  bool? hrmldcFMaxLeaveAplFlg;
  int? hrmldcFMaxLeaveCF;
  int? hrmldeCId;
  bool? hrmldeCServiceAplFlg;
  bool? hrmldeCMaxLeaveFlg;
  int? hrmldeCMaxLeaves;
  bool? hrmldeCMinLeaveFlg;
  int? hrmldeCMinLeaves;
  bool? hrmldeCVariableFixedFlg;
  double? hrmldeCFixedAmount;
  int? month;
  int? year;
  int? hrelapAId;
  bool? hrelapAFinalFlag;
  int? igAId;
  String? igADate;
  bool? igACommonGalleryFlg;
  int? igaPId;
  bool? igaPCoverPhotoFlag;
  int? hrmLId;
  int? leavecode;
  int? count;
  bool? returnval;
  bool? editFlag;
  int? miid;
  int? hrmDId;
  int? hrmdeSId;
  int? emEId;
  double? present;
  double? classheld;
  int? type;
  double? perc;
  int? monthid;
  bool? emeRActiveFlag;
  int? ivrmuLId;
  double? ttmBAfterPeriod;

  SalaryDetailsMonthwiseValues(
      {this.emeRId,
      this.intBId,
      this.roleid,
      this.paymentNootificationStaff,
      this.disabledint,
      this.blockdashboard,
      this.disabledorg,
      this.disablesubscription,
      this.subscriptionover,
      this.monthName,
      this.salary,
      this.mIId,
      this.hrmEId,
      this.asmaYId,
      this.periodCount,
      this.ttmdpTActiveFlag,
      this.asmcLId,
      this.asmSId,
      this.ismSId,
      this.asmcLActiveFlag,
      this.dayCount,
      this.ttmDId,
      this.studentcount,
      this.amstId,
      this.amstDob,
      this.amayRollNo,
      this.rollno,
      this.amstMobile,
      this.studentdob,
      this.id,
      this.hreSId,
      this.hresId,
      this.hreSYear,
      this.userId,
      this.hrmLLeaveCreditFlg,
      this.ivrMMonthId,
      this.isActive,
      this.ivrMMonthMaxDays,
      this.hrmEDOL,
      this.hreobLId,
      this.hrmlYId,
      this.hreobLDate,
      this.hreobLOBLeaves,
      this.hrelTId,
      this.hrelTLeaveId,
      this.hrelTFromDate,
      this.hrelTToDate,
      this.hrelTTotDays,
      this.hrelTReportingdate,
      this.hrelTActiveFlag,
      this.hrmldcfMId,
      this.hrmldcFId,
      this.hrmldcfMMonthId,
      this.hrelCId,
      this.hrelCDate,
      this.hrelCCrLeaves,
      this.hrmGPayScaleFrom,
      this.hrmGIncrementOf,
      this.hrmGPayScaleTo,
      this.hrmGOrder,
      this.hrmGActiveFlag,
      this.hrlAId,
      this.hrlaoNId,
      this.hrlaoNSanctionLevelNo,
      this.hrlaoNFinalFlg,
      this.hreltDId,
      this.hreltDFromDate,
      this.hreltDToDate,
      this.hreltDLWPFlag,
      this.hrelSId,
      this.hrelSOBLeaves,
      this.hrelSCreditedLeaves,
      this.hrelSTotalLeaves,
      this.hrelSTransLeaves,
      this.hrelSEncashedLeaves,
      this.hrelSCBLeaves,
      this.hrelaPId,
      this.hrelaPApplicationID,
      this.hrelaPTotalDays,
      this.hrelaPContactNoOnLeave,
      this.hrelaPFinalFlag,
      this.hrelaPActiveFlag,
      this.hrmlYFromDate,
      this.hrmlYToDate,
      this.hrmlYActiveFlag,
      this.hrmldcMId,
      this.hrmldcFMaxLeaveAplFlg,
      this.hrmldcFMaxLeaveCF,
      this.hrmldeCId,
      this.hrmldeCServiceAplFlg,
      this.hrmldeCMaxLeaveFlg,
      this.hrmldeCMaxLeaves,
      this.hrmldeCMinLeaveFlg,
      this.hrmldeCMinLeaves,
      this.hrmldeCVariableFixedFlg,
      this.hrmldeCFixedAmount,
      this.month,
      this.year,
      this.hrelapAId,
      this.hrelapAFinalFlag,
      this.igAId,
      this.igADate,
      this.igACommonGalleryFlg,
      this.igaPId,
      this.igaPCoverPhotoFlag,
      this.hrmLId,
      this.leavecode,
      this.count,
      this.returnval,
      this.editFlag,
      this.miid,
      this.hrmDId,
      this.hrmdeSId,
      this.emEId,
      this.present,
      this.classheld,
      this.type,
      this.perc,
      this.monthid,
      this.emeRActiveFlag,
      this.ivrmuLId,
      this.ttmBAfterPeriod});

  SalaryDetailsMonthwiseValues.fromJson(Map<String, dynamic> json) {
    emeRId = json['emeR_Id'];
    intBId = json['intB_Id'];
    roleid = json['roleid'];
    paymentNootificationStaff = json['paymentNootificationStaff'];
    disabledint = json['disabledint'];
    blockdashboard = json['blockdashboard'];
    disabledorg = json['disabledorg'];
    disablesubscription = json['disablesubscription'];
    subscriptionover = json['subscriptionover'];
    monthName = json['monthName'];
    salary = json['salary'];
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    asmaYId = json['asmaY_Id'];
    periodCount = json['periodCount'];
    ttmdpTActiveFlag = json['ttmdpT_ActiveFlag'];
    asmcLId = json['asmcL_Id'];
    asmSId = json['asmS_Id'];
    ismSId = json['ismS_Id'];
    asmcLActiveFlag = json['asmcL_ActiveFlag'];
    dayCount = json['dayCount'];
    ttmDId = json['ttmD_Id'];
    studentcount = json['studentcount'];
    amstId = json['amst_Id'];
    amstDob = json['amst_dob'];
    amayRollNo = json['amay_RollNo'];
    rollno = json['rollno'];
    amstMobile = json['amst_mobile'];
    studentdob = json['studentdob'];
    id = json['id'];
    hreSId = json['hreS_Id'];
    hresId = json['hres_id'];
    hreSYear = json['hreS_Year'];
    userId = json['userId'];
    hrmLLeaveCreditFlg = json['hrmL_LeaveCreditFlg'];
    ivrMMonthId = json['ivrM_Month_Id'];
    isActive = json['is_Active'];
    ivrMMonthMaxDays = json['ivrM_Month_Max_Days'];
    hrmEDOL = json['hrmE_DOL'];
    hreobLId = json['hreobL_Id'];
    hrmlYId = json['hrmlY_Id'];
    hreobLDate = json['hreobL_Date'];
    hreobLOBLeaves = json['hreobL_OBLeaves'];
    hrelTId = json['hrelT_Id'];
    hrelTLeaveId = json['hrelT_LeaveId'];
    hrelTFromDate = json['hrelT_FromDate'];
    hrelTToDate = json['hrelT_ToDate'];
    hrelTTotDays = json['hrelT_TotDays'];
    hrelTReportingdate = json['hrelT_Reportingdate'];
    hrelTActiveFlag = json['hrelT_ActiveFlag'];
    hrmldcfMId = json['hrmldcfM_Id'];
    hrmldcFId = json['hrmldcF_Id'];
    hrmldcfMMonthId = json['hrmldcfM_MonthId'];
    hrelCId = json['hrelC_Id'];
    hrelCDate = json['hrelC_Date'];
    hrelCCrLeaves = json['hrelC_CrLeaves'];
    hrmGPayScaleFrom = json['hrmG_PayScaleFrom'];
    hrmGIncrementOf = json['hrmG_IncrementOf'];
    hrmGPayScaleTo = json['hrmG_PayScaleTo'];
    hrmGOrder = json['hrmG_Order'];
    hrmGActiveFlag = json['hrmG_ActiveFlag'];
    hrlAId = json['hrlA_Id'];
    hrlaoNId = json['hrlaoN_Id'];
    hrlaoNSanctionLevelNo = json['hrlaoN_SanctionLevelNo'];
    hrlaoNFinalFlg = json['hrlaoN_FinalFlg'];
    hreltDId = json['hreltD_Id'];
    hreltDFromDate = json['hreltD_FromDate'];
    hreltDToDate = json['hreltD_ToDate'];
    hreltDLWPFlag = json['hreltD_LWPFlag'];
    hrelSId = json['hrelS_Id'];
    hrelSOBLeaves = json['hrelS_OBLeaves'];
    hrelSCreditedLeaves = json['hrelS_CreditedLeaves'];
    hrelSTotalLeaves = json['hrelS_TotalLeaves'];
    hrelSTransLeaves = json['hrelS_TransLeaves'];
    hrelSEncashedLeaves = json['hrelS_EncashedLeaves'];
    hrelSCBLeaves = json['hrelS_CBLeaves'];
    hrelaPId = json['hrelaP_Id'];
    hrelaPApplicationID = json['hrelaP_ApplicationID'];
    hrelaPTotalDays = json['hrelaP_TotalDays'];
    hrelaPContactNoOnLeave = json['hrelaP_ContactNoOnLeave'];
    hrelaPFinalFlag = json['hrelaP_FinalFlag'];
    hrelaPActiveFlag = json['hrelaP_ActiveFlag'];
    hrmlYFromDate = json['hrmlY_FromDate'];
    hrmlYToDate = json['hrmlY_ToDate'];
    hrmlYActiveFlag = json['hrmlY_ActiveFlag'];
    hrmldcMId = json['hrmldcM_Id'];
    hrmldcFMaxLeaveAplFlg = json['hrmldcF_MaxLeaveAplFlg'];
    hrmldcFMaxLeaveCF = json['hrmldcF_MaxLeaveCF'];
    hrmldeCId = json['hrmldeC_Id'];
    hrmldeCServiceAplFlg = json['hrmldeC_ServiceAplFlg'];
    hrmldeCMaxLeaveFlg = json['hrmldeC_MaxLeaveFlg'];
    hrmldeCMaxLeaves = json['hrmldeC_MaxLeaves'];
    hrmldeCMinLeaveFlg = json['hrmldeC_MinLeaveFlg'];
    hrmldeCMinLeaves = json['hrmldeC_MinLeaves'];
    hrmldeCVariableFixedFlg = json['hrmldeC_VariableFixedFlg'];
    hrmldeCFixedAmount = json['hrmldeC_FixedAmount'];
    month = json['month'];
    year = json['year'];
    hrelapAId = json['hrelapA_Id'];
    hrelapAFinalFlag = json['hrelapA_FinalFlag'];
    igAId = json['igA_Id'];
    igADate = json['igA_Date'];
    igACommonGalleryFlg = json['igA_CommonGalleryFlg'];
    igaPId = json['igaP_Id'];
    igaPCoverPhotoFlag = json['igaP_CoverPhotoFlag'];
    hrmLId = json['hrmL_Id'];
    leavecode = json['leavecode'];
    count = json['count'];
    returnval = json['returnval'];
    editFlag = json['edit_flag'];
    miid = json['miid'];
    hrmDId = json['hrmD_Id'];
    hrmdeSId = json['hrmdeS_Id'];
    emEId = json['emE_Id'];
    present = json['present'];
    classheld = json['classheld'];
    type = json['type'];
    perc = json['perc'];
    monthid = json['monthid'];
    emeRActiveFlag = json['emeR_ActiveFlag'];
    ivrmuLId = json['ivrmuL_Id'];
    ttmBAfterPeriod = json['ttmB_AfterPeriod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emeR_Id'] = emeRId;
    data['intB_Id'] = intBId;
    data['roleid'] = roleid;
    data['paymentNootificationStaff'] = paymentNootificationStaff;
    data['disabledint'] = disabledint;
    data['blockdashboard'] = blockdashboard;
    data['disabledorg'] = disabledorg;
    data['disablesubscription'] = disablesubscription;
    data['subscriptionover'] = subscriptionover;
    data['monthName'] = monthName;
    data['salary'] = salary;
    data['mI_Id'] = mIId;
    data['hrmE_Id'] = hrmEId;
    data['asmaY_Id'] = asmaYId;
    data['periodCount'] = periodCount;
    data['ttmdpT_ActiveFlag'] = ttmdpTActiveFlag;
    data['asmcL_Id'] = asmcLId;
    data['asmS_Id'] = asmSId;
    data['ismS_Id'] = ismSId;
    data['asmcL_ActiveFlag'] = asmcLActiveFlag;
    data['dayCount'] = dayCount;
    data['ttmD_Id'] = ttmDId;
    data['studentcount'] = studentcount;
    data['amst_Id'] = amstId;
    data['amst_dob'] = amstDob;
    data['amay_RollNo'] = amayRollNo;
    data['rollno'] = rollno;
    data['amst_mobile'] = amstMobile;
    data['studentdob'] = studentdob;
    data['id'] = id;
    data['hreS_Id'] = hreSId;
    data['hres_id'] = hresId;
    data['hreS_Year'] = hreSYear;
    data['userId'] = userId;
    data['hrmL_LeaveCreditFlg'] = hrmLLeaveCreditFlg;
    data['ivrM_Month_Id'] = ivrMMonthId;
    data['is_Active'] = isActive;
    data['ivrM_Month_Max_Days'] = ivrMMonthMaxDays;
    data['hrmE_DOL'] = hrmEDOL;
    data['hreobL_Id'] = hreobLId;
    data['hrmlY_Id'] = hrmlYId;
    data['hreobL_Date'] = hreobLDate;
    data['hreobL_OBLeaves'] = hreobLOBLeaves;
    data['hrelT_Id'] = hrelTId;
    data['hrelT_LeaveId'] = hrelTLeaveId;
    data['hrelT_FromDate'] = hrelTFromDate;
    data['hrelT_ToDate'] = hrelTToDate;
    data['hrelT_TotDays'] = hrelTTotDays;
    data['hrelT_Reportingdate'] = hrelTReportingdate;
    data['hrelT_ActiveFlag'] = hrelTActiveFlag;
    data['hrmldcfM_Id'] = hrmldcfMId;
    data['hrmldcF_Id'] = hrmldcFId;
    data['hrmldcfM_MonthId'] = hrmldcfMMonthId;
    data['hrelC_Id'] = hrelCId;
    data['hrelC_Date'] = hrelCDate;
    data['hrelC_CrLeaves'] = hrelCCrLeaves;
    data['hrmG_PayScaleFrom'] = hrmGPayScaleFrom;
    data['hrmG_IncrementOf'] = hrmGIncrementOf;
    data['hrmG_PayScaleTo'] = hrmGPayScaleTo;
    data['hrmG_Order'] = hrmGOrder;
    data['hrmG_ActiveFlag'] = hrmGActiveFlag;
    data['hrlA_Id'] = hrlAId;
    data['hrlaoN_Id'] = hrlaoNId;
    data['hrlaoN_SanctionLevelNo'] = hrlaoNSanctionLevelNo;
    data['hrlaoN_FinalFlg'] = hrlaoNFinalFlg;
    data['hreltD_Id'] = hreltDId;
    data['hreltD_FromDate'] = hreltDFromDate;
    data['hreltD_ToDate'] = hreltDToDate;
    data['hreltD_LWPFlag'] = hreltDLWPFlag;
    data['hrelS_Id'] = hrelSId;
    data['hrelS_OBLeaves'] = hrelSOBLeaves;
    data['hrelS_CreditedLeaves'] = hrelSCreditedLeaves;
    data['hrelS_TotalLeaves'] = hrelSTotalLeaves;
    data['hrelS_TransLeaves'] = hrelSTransLeaves;
    data['hrelS_EncashedLeaves'] = hrelSEncashedLeaves;
    data['hrelS_CBLeaves'] = hrelSCBLeaves;
    data['hrelaP_Id'] = hrelaPId;
    data['hrelaP_ApplicationID'] = hrelaPApplicationID;
    data['hrelaP_TotalDays'] = hrelaPTotalDays;
    data['hrelaP_ContactNoOnLeave'] = hrelaPContactNoOnLeave;
    data['hrelaP_FinalFlag'] = hrelaPFinalFlag;
    data['hrelaP_ActiveFlag'] = hrelaPActiveFlag;
    data['hrmlY_FromDate'] = hrmlYFromDate;
    data['hrmlY_ToDate'] = hrmlYToDate;
    data['hrmlY_ActiveFlag'] = hrmlYActiveFlag;
    data['hrmldcM_Id'] = hrmldcMId;
    data['hrmldcF_MaxLeaveAplFlg'] = hrmldcFMaxLeaveAplFlg;
    data['hrmldcF_MaxLeaveCF'] = hrmldcFMaxLeaveCF;
    data['hrmldeC_Id'] = hrmldeCId;
    data['hrmldeC_ServiceAplFlg'] = hrmldeCServiceAplFlg;
    data['hrmldeC_MaxLeaveFlg'] = hrmldeCMaxLeaveFlg;
    data['hrmldeC_MaxLeaves'] = hrmldeCMaxLeaves;
    data['hrmldeC_MinLeaveFlg'] = hrmldeCMinLeaveFlg;
    data['hrmldeC_MinLeaves'] = hrmldeCMinLeaves;
    data['hrmldeC_VariableFixedFlg'] = hrmldeCVariableFixedFlg;
    data['hrmldeC_FixedAmount'] = hrmldeCFixedAmount;
    data['month'] = month;
    data['year'] = year;
    data['hrelapA_Id'] = hrelapAId;
    data['hrelapA_FinalFlag'] = hrelapAFinalFlag;
    data['igA_Id'] = igAId;
    data['igA_Date'] = igADate;
    data['igA_CommonGalleryFlg'] = igACommonGalleryFlg;
    data['igaP_Id'] = igaPId;
    data['igaP_CoverPhotoFlag'] = igaPCoverPhotoFlag;
    data['hrmL_Id'] = hrmLId;
    data['leavecode'] = leavecode;
    data['count'] = count;
    data['returnval'] = returnval;
    data['edit_flag'] = editFlag;
    data['miid'] = miid;
    data['hrmD_Id'] = hrmDId;
    data['hrmdeS_Id'] = hrmdeSId;
    data['emE_Id'] = emEId;
    data['present'] = present;
    data['classheld'] = classheld;
    data['type'] = type;
    data['perc'] = perc;
    data['monthid'] = monthid;
    data['emeR_ActiveFlag'] = emeRActiveFlag;
    data['ivrmuL_Id'] = ivrmuLId;
    data['ttmB_AfterPeriod'] = ttmBAfterPeriod;
    return data;
  }
}
