class ApprovalCommentModel {
  String? type;
  List<ApprovalCommentModelValues>? values;

  ApprovalCommentModel({this.type, this.values});

  ApprovalCommentModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ApprovalCommentModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ApprovalCommentModelValues.fromJson(v));
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

class ApprovalCommentModelValues {
  int? duplicateCount;
  bool? checkboxValue;
  int? hrmgTId;
  int? mIId;
  int? ivrmuLId;
  int? hrmgTOrder;
  bool? hrmgTActiveFlag;
  int? hrmlDId;
  int? hrmLId;
  int? hrlrDId;
  String? hrlrDFromDate;
  String? hrlrDToDate;
  bool? hrlrDActiveFlg;
  int? hrlrDCreatedBy;
  int? hrlrDUpdatedBy;
  String? hrlrDCreatedDate;
  String? hrlrDUpdatedDate;
  int? hrmDId;
  int? hrmdeSId;
  int? hrmGId;
  int? hrmldcMNoOfLeaves;
  int? hrmlDMaxLeaveApplicable;
  bool? hrmlDCarryForFlg;
  bool? hrmlDEncashFlg;
  dynamic hrmlDEncashAmount;
  int? hrmDOrder;
  bool? hrmDActiveFlag;
  int? hrmdeSBasicAmount;
  int? hrmdeSSanctionedSeats;
  bool? hrmdeSDisplaySanctionedSeatsFlag;
  int? hrmdeSOrder;
  bool? hrmdeSActiveFlag;
  bool? hrmLLeaveCreditFlg;
  int? ivrMMonthId;
  bool? isActive;
  int? ivrMMonthMaxDays;
  int? hrmeDId;
  int? hrmedTId;
  bool? hrmeDActiveFlag;
  dynamic hrmeDRoundOffFlag;
  String? hrmeDEntryDate;
  int? loginId;
  bool? hrmEActiveFlag;
  int? masterId;
  int? hrmEId;
  int? hrmEIdMy;
  String? hrmEEmployeeFirstName;
  String? hrmEDOL;
  int? hrmemnOMobileNo;
  int? hreobLId;
  int? hrmlYId;
  String? hreobLDate;
  dynamic hreobLOBLeaves;
  int? hrelTId;
  int? hrelTLeaveId;
  String? hrelTFromDate;
  String? hrelTToDate;
  dynamic hrelTTotDays;
  String? hrelTReportingdate;
  bool? hrelTActiveFlag;
  int? hrmldcfMId;
  int? hrmldcFId;
  int? hrmldcfMMonthId;
  int? hrelCId;
  String? hrelCDate;
  int? hrelCCrLeaves;
  dynamic hrmGPayScaleFrom;
  dynamic hrmGIncrementOf;
  dynamic hrmGPayScaleTo;
  dynamic hrmGOrder;
  bool? hrmGActiveFlag;
  int? hrlAId;
  int? hrlaoNId;
  int? hrlaoNSanctionLevelNo;
  bool? hrlaoNFinalFlg;
  int? hreltDId;
  String? hreltDFromDate;
  String? hreltDToDate;
  dynamic hreltDTotDays;
  bool? hreltDLWPFlag;
  dynamic hrmLNoOfDays;
  int? hrelSId;
  dynamic hrelSOBLeaves;
  dynamic hrelSCreditedLeaves;
  dynamic hrelSTotalLeaves;
  dynamic hrelSTransLeaves;
  int? hrelSEncashedLeaves;
  dynamic hrelSCBLeaves;
  int? userId;
  int? hrelaPId;
  String? hrelaPFromDateapprv;
  String? hrelaPToDateapprv;
  dynamic hrelaPTotalDaysapprv;
  dynamic hrelaPTotalDays;
  dynamic hrelaPContactNoOnLeave;
  bool? hrelaPFinalFlag;
  bool? hrelaPActiveFlag;
  String? hrmlYFromDate;
  String? hrmlYToDate;
  bool? hrmlYActiveFlag;
  int? hrmldcMId;
  int? hrmldcMLCMonthCode;
  bool? hrmldcFMaxLeaveAplFlg;
  dynamic hrmldcFMaxLeaveCF;
  int? hrmldeCId;
  bool? hrmldeCServiceAplFlg;
  bool? hrmldeCMaxLeaveFlg;
  dynamic hrmldeCMaxLeaves;
  bool? hrmldeCMinLeaveFlg;
  int? hrmldeCMinLeaves;
  bool? hrmldeCVariableFixedFlg;
  dynamic hrmldeCFixedAmount;
  dynamic month;
  dynamic year;
  int? hrelapAId;
  String? hrelapASanctioningLevel;
  String? hrelapARemarks;
  int? leavecode;
  int? count;
  bool? returnval;
  bool? editFlag;
  bool? monthwisecredit;
  int? asmayId;
  String? hrelapAFromDate;
  String? hrelapAToDate;
  dynamic hrelapATotalDays;
  String? hrelapALeaveStatus;
  String? createdDate;

  ApprovalCommentModelValues(
      {this.duplicateCount,
      this.checkboxValue,
      this.hrmgTId,
      this.mIId,
      this.ivrmuLId,
      this.hrmgTOrder,
      this.hrmgTActiveFlag,
      this.hrmlDId,
      this.hrmLId,
      this.hrlrDId,
      this.hrlrDFromDate,
      this.hrlrDToDate,
      this.hrlrDActiveFlg,
      this.hrlrDCreatedBy,
      this.hrlrDUpdatedBy,
      this.hrlrDCreatedDate,
      this.hrlrDUpdatedDate,
      this.hrmDId,
      this.hrmdeSId,
      this.hrmGId,
      this.hrmldcMNoOfLeaves,
      this.hrmlDMaxLeaveApplicable,
      this.hrmlDCarryForFlg,
      this.hrmlDEncashFlg,
      this.hrmlDEncashAmount,
      this.hrmDOrder,
      this.hrmDActiveFlag,
      this.hrmdeSBasicAmount,
      this.hrmdeSSanctionedSeats,
      this.hrmdeSDisplaySanctionedSeatsFlag,
      this.hrmdeSOrder,
      this.hrmdeSActiveFlag,
      this.hrmLLeaveCreditFlg,
      this.ivrMMonthId,
      this.isActive,
      this.ivrMMonthMaxDays,
      this.hrmeDId,
      this.hrmedTId,
      this.hrmeDActiveFlag,
      this.hrmeDRoundOffFlag,
      this.hrmeDEntryDate,
      this.loginId,
      this.hrmEActiveFlag,
      this.masterId,
      this.hrmEId,
      this.hrmEIdMy,
      this.hrmEEmployeeFirstName,
      this.hrmEDOL,
      this.hrmemnOMobileNo,
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
      this.hreltDTotDays,
      this.hreltDLWPFlag,
      this.hrmLNoOfDays,
      this.hrelSId,
      this.hrelSOBLeaves,
      this.hrelSCreditedLeaves,
      this.hrelSTotalLeaves,
      this.hrelSTransLeaves,
      this.hrelSEncashedLeaves,
      this.hrelSCBLeaves,
      this.userId,
      this.hrelaPId,
      this.hrelaPFromDateapprv,
      this.hrelaPToDateapprv,
      this.hrelaPTotalDaysapprv,
      this.hrelaPTotalDays,
      this.hrelaPContactNoOnLeave,
      this.hrelaPFinalFlag,
      this.hrelaPActiveFlag,
      this.hrmlYFromDate,
      this.hrmlYToDate,
      this.hrmlYActiveFlag,
      this.hrmldcMId,
      this.hrmldcMLCMonthCode,
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
      this.hrelapASanctioningLevel,
      this.hrelapARemarks,
      this.leavecode,
      this.count,
      this.returnval,
      this.editFlag,
      this.monthwisecredit,
      this.asmayId,
      this.hrelapAFromDate,
      this.hrelapAToDate,
      this.hrelapATotalDays,
      this.hrelapALeaveStatus,
      this.createdDate});

  ApprovalCommentModelValues.fromJson(Map<String, dynamic> json) {
    duplicateCount = json['duplicateCount'];
    checkboxValue = json['checkbox_value'];
    hrmgTId = json['hrmgT_Id'];
    mIId = json['mI_Id'];
    ivrmuLId = json['ivrmuL_Id'];
    hrmgTOrder = json['hrmgT_Order'];
    hrmgTActiveFlag = json['hrmgT_ActiveFlag'];
    hrmlDId = json['hrmlD_Id'];
    hrmLId = json['hrmL_Id'];
    hrlrDId = json['hrlrD_Id'];
    hrlrDFromDate = json['hrlrD_FromDate'];
    hrlrDToDate = json['hrlrD_ToDate'];
    hrlrDActiveFlg = json['hrlrD_ActiveFlg'];
    hrlrDCreatedBy = json['hrlrD_CreatedBy'];
    hrlrDUpdatedBy = json['hrlrD_UpdatedBy'];
    hrlrDCreatedDate = json['hrlrD_CreatedDate'];
    hrlrDUpdatedDate = json['hrlrD_UpdatedDate'];
    hrmDId = json['hrmD_Id'];
    hrmdeSId = json['hrmdeS_Id'];
    hrmGId = json['hrmG_Id'];
    hrmldcMNoOfLeaves = json['hrmldcM_NoOfLeaves'];
    hrmlDMaxLeaveApplicable = json['hrmlD_MaxLeaveApplicable'];
    hrmlDCarryForFlg = json['hrmlD_CarryForFlg'];
    hrmlDEncashFlg = json['hrmlD_EncashFlg'];
    hrmlDEncashAmount = json['hrmlD_EncashAmount'];
    hrmDOrder = json['hrmD_Order'];
    hrmDActiveFlag = json['hrmD_ActiveFlag'];
    hrmdeSBasicAmount = json['hrmdeS_BasicAmount'];
    hrmdeSSanctionedSeats = json['hrmdeS_SanctionedSeats'];
    hrmdeSDisplaySanctionedSeatsFlag =
        json['hrmdeS_DisplaySanctionedSeatsFlag'];
    hrmdeSOrder = json['hrmdeS_Order'];
    hrmdeSActiveFlag = json['hrmdeS_ActiveFlag'];
    hrmLLeaveCreditFlg = json['hrmL_LeaveCreditFlg'];
    ivrMMonthId = json['ivrM_Month_Id'];
    isActive = json['is_Active'];
    ivrMMonthMaxDays = json['ivrM_Month_Max_Days'];
    hrmeDId = json['hrmeD_Id'];
    hrmedTId = json['hrmedT_Id'];
    hrmeDActiveFlag = json['hrmeD_ActiveFlag'];
    hrmeDRoundOffFlag = json['hrmeD_RoundOffFlag'];
    hrmeDEntryDate = json['hrmeD_EntryDate'];
    loginId = json['loginId'];
    hrmEActiveFlag = json['hrmE_ActiveFlag'];
    masterId = json['master_Id'];
    hrmEId = json['hrmE_Id'];
    hrmEIdMy = json['hrmE_IdMy'];
    hrmEEmployeeFirstName = json['hrmE_EmployeeFirstName'];
    hrmEDOL = json['hrmE_DOL'];
    hrmemnOMobileNo = json['hrmemnO_MobileNo'];
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
    hreltDTotDays = json['hreltD_TotDays'];
    hreltDLWPFlag = json['hreltD_LWPFlag'];
    hrmLNoOfDays = json['hrmL_NoOfDays'];
    hrelSId = json['hrelS_Id'];
    hrelSOBLeaves = json['hrelS_OBLeaves'];
    hrelSCreditedLeaves = json['hrelS_CreditedLeaves'];
    hrelSTotalLeaves = json['hrelS_TotalLeaves'];
    hrelSTransLeaves = json['hrelS_TransLeaves'];
    hrelSEncashedLeaves = json['hrelS_EncashedLeaves'];
    hrelSCBLeaves = json['hrelS_CBLeaves'];
    userId = json['userId'];
    hrelaPId = json['hrelaP_Id'];
    hrelaPFromDateapprv = json['hrelaP_FromDateapprv'];
    hrelaPToDateapprv = json['hrelaP_ToDateapprv'];
    hrelaPTotalDaysapprv = json['hrelaP_TotalDaysapprv'];
    hrelaPTotalDays = json['hrelaP_TotalDays'];
    hrelaPContactNoOnLeave = json['hrelaP_ContactNoOnLeave'];
    hrelaPFinalFlag = json['hrelaP_FinalFlag'];
    hrelaPActiveFlag = json['hrelaP_ActiveFlag'];
    hrmlYFromDate = json['hrmlY_FromDate'];
    hrmlYToDate = json['hrmlY_ToDate'];
    hrmlYActiveFlag = json['hrmlY_ActiveFlag'];
    hrmldcMId = json['hrmldcM_Id'];
    hrmldcMLCMonthCode = json['hrmldcM_LCMonthCode'];
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
    hrelapASanctioningLevel = json['hrelapA_SanctioningLevel'];
    hrelapARemarks = json['hrelapA_Remarks'];
    leavecode = json['leavecode'];
    count = json['count'];
    returnval = json['returnval'];
    editFlag = json['edit_flag'];
    monthwisecredit = json['monthwisecredit'];
    asmayId = json['asmay_id'];
    hrelapAFromDate = json['hrelapA_FromDate'];
    hrelapAToDate = json['hrelapA_ToDate'];
    hrelapATotalDays = json['hrelapA_TotalDays'];
    hrelapALeaveStatus = json['hrelapA_LeaveStatus'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['duplicateCount'] = duplicateCount;
    data['checkbox_value'] = checkboxValue;
    data['hrmgT_Id'] = hrmgTId;
    data['mI_Id'] = mIId;
    data['ivrmuL_Id'] = ivrmuLId;
    data['hrmgT_Order'] = hrmgTOrder;
    data['hrmgT_ActiveFlag'] = hrmgTActiveFlag;
    data['hrmlD_Id'] = hrmlDId;
    data['hrmL_Id'] = hrmLId;
    data['hrlrD_Id'] = hrlrDId;
    data['hrlrD_FromDate'] = hrlrDFromDate;
    data['hrlrD_ToDate'] = hrlrDToDate;
    data['hrlrD_ActiveFlg'] = hrlrDActiveFlg;
    data['hrlrD_CreatedBy'] = hrlrDCreatedBy;
    data['hrlrD_UpdatedBy'] = hrlrDUpdatedBy;
    data['hrlrD_CreatedDate'] = hrlrDCreatedDate;
    data['hrlrD_UpdatedDate'] = hrlrDUpdatedDate;
    data['hrmD_Id'] = hrmDId;
    data['hrmdeS_Id'] = hrmdeSId;
    data['hrmG_Id'] = hrmGId;
    data['hrmldcM_NoOfLeaves'] = hrmldcMNoOfLeaves;
    data['hrmlD_MaxLeaveApplicable'] = hrmlDMaxLeaveApplicable;
    data['hrmlD_CarryForFlg'] = hrmlDCarryForFlg;
    data['hrmlD_EncashFlg'] = hrmlDEncashFlg;
    data['hrmlD_EncashAmount'] = hrmlDEncashAmount;
    data['hrmD_Order'] = hrmDOrder;
    data['hrmD_ActiveFlag'] = hrmDActiveFlag;
    data['hrmdeS_BasicAmount'] = hrmdeSBasicAmount;
    data['hrmdeS_SanctionedSeats'] = hrmdeSSanctionedSeats;
    data['hrmdeS_DisplaySanctionedSeatsFlag'] =
        hrmdeSDisplaySanctionedSeatsFlag;
    data['hrmdeS_Order'] = hrmdeSOrder;
    data['hrmdeS_ActiveFlag'] = hrmdeSActiveFlag;
    data['hrmL_LeaveCreditFlg'] = hrmLLeaveCreditFlg;
    data['ivrM_Month_Id'] = ivrMMonthId;
    data['is_Active'] = isActive;
    data['ivrM_Month_Max_Days'] = ivrMMonthMaxDays;
    data['hrmeD_Id'] = hrmeDId;
    data['hrmedT_Id'] = hrmedTId;
    data['hrmeD_ActiveFlag'] = hrmeDActiveFlag;
    data['hrmeD_RoundOffFlag'] = hrmeDRoundOffFlag;
    data['hrmeD_EntryDate'] = hrmeDEntryDate;
    data['loginId'] = loginId;
    data['hrmE_ActiveFlag'] = hrmEActiveFlag;
    data['master_Id'] = masterId;
    data['hrmE_Id'] = hrmEId;
    data['hrmE_IdMy'] = hrmEIdMy;
    data['hrmE_EmployeeFirstName'] = hrmEEmployeeFirstName;
    data['hrmE_DOL'] = hrmEDOL;
    data['hrmemnO_MobileNo'] = hrmemnOMobileNo;
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
    data['hreltD_TotDays'] = hreltDTotDays;
    data['hreltD_LWPFlag'] = hreltDLWPFlag;
    data['hrmL_NoOfDays'] = hrmLNoOfDays;
    data['hrelS_Id'] = hrelSId;
    data['hrelS_OBLeaves'] = hrelSOBLeaves;
    data['hrelS_CreditedLeaves'] = hrelSCreditedLeaves;
    data['hrelS_TotalLeaves'] = hrelSTotalLeaves;
    data['hrelS_TransLeaves'] = hrelSTransLeaves;
    data['hrelS_EncashedLeaves'] = hrelSEncashedLeaves;
    data['hrelS_CBLeaves'] = hrelSCBLeaves;
    data['userId'] = userId;
    data['hrelaP_Id'] = hrelaPId;
    data['hrelaP_FromDateapprv'] = hrelaPFromDateapprv;
    data['hrelaP_ToDateapprv'] = hrelaPToDateapprv;
    data['hrelaP_TotalDaysapprv'] = hrelaPTotalDaysapprv;
    data['hrelaP_TotalDays'] = hrelaPTotalDays;
    data['hrelaP_ContactNoOnLeave'] = hrelaPContactNoOnLeave;
    data['hrelaP_FinalFlag'] = hrelaPFinalFlag;
    data['hrelaP_ActiveFlag'] = hrelaPActiveFlag;
    data['hrmlY_FromDate'] = hrmlYFromDate;
    data['hrmlY_ToDate'] = hrmlYToDate;
    data['hrmlY_ActiveFlag'] = hrmlYActiveFlag;
    data['hrmldcM_Id'] = hrmldcMId;
    data['hrmldcM_LCMonthCode'] = hrmldcMLCMonthCode;
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
    data['hrelapA_SanctioningLevel'] = hrelapASanctioningLevel;
    data['hrelapA_Remarks'] = hrelapARemarks;
    data['leavecode'] = leavecode;
    data['count'] = count;
    data['returnval'] = returnval;
    data['edit_flag'] = editFlag;
    data['monthwisecredit'] = monthwisecredit;
    data['asmay_id'] = asmayId;
    data['hrelapA_FromDate'] = hrelapAFromDate;
    data['hrelapA_ToDate'] = hrelapAToDate;
    data['hrelapA_TotalDays'] = hrelapATotalDays;
    data['hrelapA_LeaveStatus'] = hrelapALeaveStatus;
    data['createdDate'] = createdDate;
    return data;
  }
}
