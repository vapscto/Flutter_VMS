class AppliedLeaveModel {
  String? type;
  List<AppliedLeaveModelValues>? values;

  AppliedLeaveModel({this.type, this.values});

  AppliedLeaveModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <AppliedLeaveModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(AppliedLeaveModelValues.fromJson(v));
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

class AppliedLeaveModelValues {
  int? hrmgTId;
  int? mIId;
  int? hrmgTOrder;
  bool? hrmgTActiveFlag;
  int? hrmlDId;
  int? hrmLId;
  int? hrmDId;
  int? hrmdeSId;
  int? hrmGId;
  int? hrmlDMaxLeaveApplicable;
  bool? hrmlDCarryForFlg;
  bool? hrmlDEncashFlg;
  double? hrmlDEncashAmount;
  int? hrmDOrder;
  bool? hrmDActiveFlag;
  int? hrmdeSBasicAmount;
  int? hrmdeSSanctionedSeats;
  bool? hrmdeSDisplaySanctionedSeatsFlag;
  int? hrmdeSOrder;
  bool? hrmdeSActiveFlag;
  String? hrmLLeaveName;
  bool? hrmLLeaveCreditFlg;
  int? ivrMMonthId;
  bool? isActive;
  int? ivrMMonthMaxDays;
  int? hrmeDId;
  int? hrmedTId;
  bool? hrmeDActiveFlag;
  double? hrmeDRoundOffFlag;
  String? hrmeDEntryDate;
  int? loginId;
  bool? hrmEActiveFlag;
  int? hrmEId;
  String? hrmEDOL;
  int? hrmemnOMobileNo;
  int? hreobLId;
  int? hrmlYId;
  String? hreobLDate;
  double? hreobLOBLeaves;
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
  double? hreltDTotDays;
  bool? hreltDLWPFlag;
  int? hrelSId;
  double? hrelSOBLeaves;
  double? hrelSCreditedLeaves;
  double? hrelSTotalLeaves;
  double? hrelSTransLeaves;
  num? hrelSEncashedLeaves;
  double? hrelSCBLeaves;
  int? userId;
  int? hrelaPId;
  String? hrelaPFromDate;
  String? hrelaPToDate;
  double? hrelaPTotalDays;
  String? hrelaPLeaveReason;
  int? hrelaPContactNoOnLeave;
  String? hrelaPApplicationStatus;
  bool? hrelaPFinalFlag;
  bool? hrelaPActiveFlag;
  String? hrelaPSupportingDocument;
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
  int? leavecode;
  int? count;
  bool? returnval;
  bool? editFlag;
  int? asmayId;
  int? ivrmuLId;
  String? hrelapARemarks;

  AppliedLeaveModelValues(
      {this.hrmgTId,
      this.mIId,
      this.hrmgTOrder,
      this.hrmgTActiveFlag,
      this.hrmlDId,
      this.hrmLId,
      this.hrmDId,
      this.hrmdeSId,
      this.hrmGId,
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
      this.hrmLLeaveName,
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
      this.hrmEId,
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
      this.hrelSId,
      this.hrelSOBLeaves,
      this.hrelSCreditedLeaves,
      this.hrelSTotalLeaves,
      this.hrelSTransLeaves,
      this.hrelSEncashedLeaves,
      this.hrelSCBLeaves,
      this.userId,
      this.hrelaPId,
      this.hrelaPFromDate,
      this.hrelaPToDate,
      this.hrelaPTotalDays,
      this.hrelaPLeaveReason,
      this.hrelaPContactNoOnLeave,
      this.hrelaPApplicationStatus,
      this.hrelaPFinalFlag,
      this.hrelaPActiveFlag,
      this.hrelaPSupportingDocument,
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
      this.leavecode,
      this.count,
      this.returnval,
      this.editFlag,
      this.asmayId,
      this.ivrmuLId,
      this.hrelapARemarks});

  AppliedLeaveModelValues.fromJson(Map<String, dynamic> json) {
    hrmgTId = json['hrmgT_Id'];
    mIId = json['mI_Id'];
    hrmgTOrder = json['hrmgT_Order'];
    hrmgTActiveFlag = json['hrmgT_ActiveFlag'];
    hrmlDId = json['hrmlD_Id'];
    hrmLId = json['hrmL_Id'];
    hrmDId = json['hrmD_Id'];
    hrmdeSId = json['hrmdeS_Id'];
    hrmGId = json['hrmG_Id'];
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
    hrmLLeaveName = json['hrmL_LeaveName'];
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
    hrmEId = json['hrmE_Id'];
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
    hrelSId = json['hrelS_Id'];
    hrelSOBLeaves = json['hrelS_OBLeaves'];
    hrelSCreditedLeaves = json['hrelS_CreditedLeaves'];
    hrelSTotalLeaves = json['hrelS_TotalLeaves'];
    hrelSTransLeaves = json['hrelS_TransLeaves'];
    hrelSEncashedLeaves = json['hrelS_EncashedLeaves'];
    hrelSCBLeaves = json['hrelS_CBLeaves'];
    userId = json['userId'];
    hrelaPId = json['hrelaP_Id'];
    hrelaPFromDate = json['hrelaP_FromDate'];
    hrelaPToDate = json['hrelaP_ToDate'];
    hrelaPTotalDays = json['hrelaP_TotalDays'];
    hrelaPLeaveReason = json['hrelaP_LeaveReason'];
    hrelaPContactNoOnLeave = json['hrelaP_ContactNoOnLeave'];
    hrelaPApplicationStatus = json['hrelaP_ApplicationStatus'];
    hrelaPFinalFlag = json['hrelaP_FinalFlag'];
    hrelaPActiveFlag = json['hrelaP_ActiveFlag'];
    hrelaPSupportingDocument = json['hrelaP_SupportingDocument'];
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
    leavecode = json['leavecode'];
    count = json['count'];
    returnval = json['returnval'];
    editFlag = json['edit_flag'];
    asmayId = json['asmay_id'];
    ivrmuLId = json['ivrmuL_Id'];
    hrelapARemarks = json['hrelapA_Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hrmgT_Id'] = hrmgTId;
    data['mI_Id'] = mIId;
    data['hrmgT_Order'] = hrmgTOrder;
    data['hrmgT_ActiveFlag'] = hrmgTActiveFlag;
    data['hrmlD_Id'] = hrmlDId;
    data['hrmL_Id'] = hrmLId;
    data['hrmD_Id'] = hrmDId;
    data['hrmdeS_Id'] = hrmdeSId;
    data['hrmG_Id'] = hrmGId;
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
    data['hrmL_LeaveName'] = hrmLLeaveName;
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
    data['hrmE_Id'] = hrmEId;
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
    data['hrelS_Id'] = hrelSId;
    data['hrelS_OBLeaves'] = hrelSOBLeaves;
    data['hrelS_CreditedLeaves'] = hrelSCreditedLeaves;
    data['hrelS_TotalLeaves'] = hrelSTotalLeaves;
    data['hrelS_TransLeaves'] = hrelSTransLeaves;
    data['hrelS_EncashedLeaves'] = hrelSEncashedLeaves;
    data['hrelS_CBLeaves'] = hrelSCBLeaves;
    data['userId'] = userId;
    data['hrelaP_Id'] = hrelaPId;
    data['hrelaP_FromDate'] = hrelaPFromDate;
    data['hrelaP_ToDate'] = hrelaPToDate;
    data['hrelaP_TotalDays'] = hrelaPTotalDays;
    data['hrelaP_LeaveReason'] = hrelaPLeaveReason;
    data['hrelaP_ContactNoOnLeave'] = hrelaPContactNoOnLeave;
    data['hrelaP_ApplicationStatus'] = hrelaPApplicationStatus;
    data['hrelaP_FinalFlag'] = hrelaPFinalFlag;
    data['hrelaP_ActiveFlag'] = hrelaPActiveFlag;
    data['hrelaP_SupportingDocument'] = hrelaPSupportingDocument;
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
    data['leavecode'] = leavecode;
    data['count'] = count;
    data['returnval'] = returnval;
    data['edit_flag'] = editFlag;
    data['asmay_id'] = asmayId;
    data['ivrmuL_Id'] = ivrmuLId;
    data['hrelapA_Remarks'] = hrelapARemarks;
    return data;
  }
}
