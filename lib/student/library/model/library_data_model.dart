import 'package:m_skool_flutter/student/library/model/library_graph.dart';

class LibraryDataModel {
  int? stdupdate;
  int? stuonlineexam;
  int? mobilenumber;
  bool? disabledint;
  bool? blockdashboard;
  bool? disabledorg;
  bool? disablesubscription;
  bool? subscriptionover;
  int? ipaTId;
  int? amstGId;
  int? stPPERSTATE;
  int? stPPERCOUNTRY;
  int? stPPERPIN;
  int? stPCURSTATE;
  int? stPCURCOUNTRY;
  int? stPCURPIN;
  int? mIId;
  int? astureQId;
  int? fsSId;
  int? asmaYId;
  bool? tctaken;
  int? amsTId;
  int? fmGId;
  int? fmHId;
  int? ftIId;
  int? fmAId;
  int? fsSOBArrearAmount;
  int? fsSOBExcessAmount;
  int? fsSCurrentYrCharges;
  int? fsSTotalToBePaid;
  int? fsSToBePaid;
  int? fsSPaidAmount;
  int? fsSExcessPaidAmount;
  int? fsSExcessAdjustedAmount;
  int? fsSRunningExcessAmount;
  int? fsSConcessionAmount;
  int? fsSAdjustedAmount;
  int? fsSWaivedAmount;
  int? fsSRebateAmount;
  double? fsSFineAmount;
  int? fsSRefundAmount;
  int? fsSRefundAmountAdjusted;
  double? fsSNetAmount;
  bool? fsSChequeBounceFlag;
  bool? updateflag;
  bool? fsSArrearFlag;
  bool? fsSRefundOverFlag;
  bool? fsSActiveFlag;
  int? userId;
  int? roleid;
  int? feecheck;
  String? asmaYFromDate;
  String? asmaYToDate;
  String? asmaYPreAdmFDate;
  String? asmaYPreAdmTDate;
  int? asmaYOrder;
  int? asmaYActiveFlag;
  int? asmaYPreActiveFlag;
  String? asmaYCutOfDate;
  bool? isActive;
  int? coemEId;
  bool? coemEActiveFlag;
  int? asmcLId;
  int? asmSId;
  int? totalBalance;
  int? receivable;
  int? balance;
  int? paid;
  int? fyPId;
  Librarydetails? librarydetails;
  LibraryGraph? libraryGraphs;
  int? month;
  int? amsTMobileNo;
  String? amsTDOB;
  int? hrmEID;
  int? studentaccyear;
  double? ftPConcessionAmt;
  double? ftPPaidAmt;
  double? ftPFineAmt;
  String? fyPDate;
  String? fyPDDChequeDate;
  double? fyPTotAmount;
  double? fyPTotFineAmt;
  double? fyPTotConcessionAmt;
  int? fmTId;
  int? dueamount;
  int? ttmCId;
  int? ttfgDId;
  int? ttfGId;
  int? hrmEId;
  int? ttmDId;
  int? ttmPId;
  int? ismSId;
  double? ttmBAfterPeriod;
  int? idUId;
  bool? idUActiveFlag;
  int? intBId;
  int? icWId;
  String? intBStartDate;
  String? intBEndDate;
  bool? intBActiveFlag;
  int? ivrmuLId;
  int? ihWId;
  int? ihWAssignmentNo;
  bool? icWActiveFlag;
  String? icWFromDate;
  String? icWToDate;
  int? ipNId;
  String? ipNDate;
  bool? ipNActiveFlag;
  int? ipnSId;
  int? ivrmmaDId;
  bool? returnval;
  int? igAId;
  String? igADate;
  bool? igACommonGalleryFlg;
  int? igaPId;
  bool? igaPCoverPhotoFlag;
  int? coeEId;
  int? order;
  int? emEId;
  int? subjorder;
  bool? estsUElecetiveFlag;
  int? amaYRollNo;

  LibraryDataModel(
      {this.stdupdate,
      this.stuonlineexam,
      this.mobilenumber,
      this.disabledint,
      this.blockdashboard,
      this.disabledorg,
      this.disablesubscription,
      this.subscriptionover,
      this.ipaTId,
      this.amstGId,
      this.stPPERSTATE,
      this.stPPERCOUNTRY,
      this.stPPERPIN,
      this.stPCURSTATE,
      this.stPCURCOUNTRY,
      this.stPCURPIN,
      this.mIId,
      this.astureQId,
      this.fsSId,
      this.asmaYId,
      this.tctaken,
      this.amsTId,
      this.fmGId,
      this.fmHId,
      this.ftIId,
      this.fmAId,
      this.fsSOBArrearAmount,
      this.fsSOBExcessAmount,
      this.fsSCurrentYrCharges,
      this.fsSTotalToBePaid,
      this.fsSToBePaid,
      this.fsSPaidAmount,
      this.fsSExcessPaidAmount,
      this.fsSExcessAdjustedAmount,
      this.fsSRunningExcessAmount,
      this.fsSConcessionAmount,
      this.fsSAdjustedAmount,
      this.fsSWaivedAmount,
      this.fsSRebateAmount,
      this.fsSFineAmount,
      this.fsSRefundAmount,
      this.fsSRefundAmountAdjusted,
      this.fsSNetAmount,
      this.fsSChequeBounceFlag,
      this.updateflag,
      this.fsSArrearFlag,
      this.fsSRefundOverFlag,
      this.fsSActiveFlag,
      this.userId,
      this.roleid,
      this.feecheck,
      this.asmaYFromDate,
      this.asmaYToDate,
      this.asmaYPreAdmFDate,
      this.asmaYPreAdmTDate,
      this.asmaYOrder,
      this.asmaYActiveFlag,
      this.asmaYPreActiveFlag,
      this.asmaYCutOfDate,
      this.isActive,
      this.coemEId,
      this.coemEActiveFlag,
      this.asmcLId,
      this.asmSId,
      this.totalBalance,
      this.receivable,
      this.balance,
      this.paid,
      this.fyPId,
      this.librarydetails,
      this.libraryGraphs,
      this.month,
      this.amsTMobileNo,
      this.amsTDOB,
      this.hrmEID,
      this.studentaccyear,
      this.ftPConcessionAmt,
      this.ftPPaidAmt,
      this.ftPFineAmt,
      this.fyPDate,
      this.fyPDDChequeDate,
      this.fyPTotAmount,
      this.fyPTotFineAmt,
      this.fyPTotConcessionAmt,
      this.fmTId,
      this.dueamount,
      this.ttmCId,
      this.ttfgDId,
      this.ttfGId,
      this.hrmEId,
      this.ttmDId,
      this.ttmPId,
      this.ismSId,
      this.ttmBAfterPeriod,
      this.idUId,
      this.idUActiveFlag,
      this.intBId,
      this.icWId,
      this.intBStartDate,
      this.intBEndDate,
      this.intBActiveFlag,
      this.ivrmuLId,
      this.ihWId,
      this.ihWAssignmentNo,
      this.icWActiveFlag,
      this.icWFromDate,
      this.icWToDate,
      this.ipNId,
      this.ipNDate,
      this.ipNActiveFlag,
      this.ipnSId,
      this.ivrmmaDId,
      this.returnval,
      this.igAId,
      this.igADate,
      this.igACommonGalleryFlg,
      this.igaPId,
      this.igaPCoverPhotoFlag,
      this.coeEId,
      this.order,
      this.emEId,
      this.subjorder,
      this.estsUElecetiveFlag,
      this.amaYRollNo});

  LibraryDataModel.fromJson(Map<String, dynamic> json) {
    stdupdate = json['stdupdate'];
    stuonlineexam = json['stuonlineexam'];
    mobilenumber = json['mobilenumber'];
    disabledint = json['disabledint'];
    blockdashboard = json['blockdashboard'];
    disabledorg = json['disabledorg'];
    disablesubscription = json['disablesubscription'];
    subscriptionover = json['subscriptionover'];
    ipaTId = json['ipaT_Id'];
    amstGId = json['amstG_Id'];
    stPPERSTATE = json['stP_PERSTATE'];
    stPPERCOUNTRY = json['stP_PERCOUNTRY'];
    stPPERPIN = json['stP_PERPIN'];
    stPCURSTATE = json['stP_CURSTATE'];
    stPCURCOUNTRY = json['stP_CURCOUNTRY'];
    stPCURPIN = json['stP_CURPIN'];
    mIId = json['mI_Id'];
    astureQId = json['astureQ_Id'];
    fsSId = json['fsS_Id'];
    asmaYId = json['asmaY_Id'];
    tctaken = json['tctaken'];
    amsTId = json['amsT_Id'];
    fmGId = json['fmG_Id'];
    fmHId = json['fmH_Id'];
    ftIId = json['ftI_Id'];
    fmAId = json['fmA_Id'];
    fsSOBArrearAmount = json['fsS_OBArrearAmount'];
    fsSOBExcessAmount = json['fsS_OBExcessAmount'];
    fsSCurrentYrCharges = json['fsS_CurrentYrCharges'];
    fsSTotalToBePaid = json['fsS_TotalToBePaid'];
    fsSToBePaid = json['fsS_ToBePaid'];
    fsSPaidAmount = json['fsS_PaidAmount'];
    fsSExcessPaidAmount = json['fsS_ExcessPaidAmount'];
    fsSExcessAdjustedAmount = json['fsS_ExcessAdjustedAmount'];
    fsSRunningExcessAmount = json['fsS_RunningExcessAmount'];
    fsSConcessionAmount = json['fsS_ConcessionAmount'];
    fsSAdjustedAmount = json['fsS_AdjustedAmount'];
    fsSWaivedAmount = json['fsS_WaivedAmount'];
    fsSRebateAmount = json['fsS_RebateAmount'];
    fsSFineAmount = json['fsS_FineAmount'];
    fsSRefundAmount = json['fsS_RefundAmount'];
    fsSRefundAmountAdjusted = json['fsS_RefundAmountAdjusted'];
    fsSNetAmount = json['fsS_NetAmount'];
    fsSChequeBounceFlag = json['fsS_ChequeBounceFlag'];
    updateflag = json['updateflag'];
    fsSArrearFlag = json['fsS_ArrearFlag'];
    fsSRefundOverFlag = json['fsS_RefundOverFlag'];
    fsSActiveFlag = json['fsS_ActiveFlag'];
    userId = json['user_Id'];
    roleid = json['roleid'];
    feecheck = json['feecheck'];
    asmaYFromDate = json['asmaY_From_Date'];
    asmaYToDate = json['asmaY_To_Date'];
    asmaYPreAdmFDate = json['asmaY_PreAdm_F_Date'];
    asmaYPreAdmTDate = json['asmaY_PreAdm_T_Date'];
    asmaYOrder = json['asmaY_Order'];
    asmaYActiveFlag = json['asmaY_ActiveFlag'];
    asmaYPreActiveFlag = json['asmaY_Pre_ActiveFlag'];
    asmaYCutOfDate = json['asmaY_Cut_Of_Date'];
    isActive = json['is_Active'];
    coemEId = json['coemE_Id'];
    coemEActiveFlag = json['coemE_ActiveFlag'];
    asmcLId = json['asmcL_Id'];
    asmSId = json['asmS_Id'];
    totalBalance = json['totalBalance'];
    receivable = json['receivable'];
    balance = json['balance'];
    paid = json['paid'];
    fyPId = json['fyP_Id'];
    librarydetails = json['librarydetails'] != null
        ? Librarydetails.fromJson(json['librarydetails'])
        : null;
    libraryGraphs = json['librarygraphs'] != null
        ? LibraryGraph.fromJson(json['librarygraphs'])
        : null;
    month = json['month'];
    amsTMobileNo = json['amsT_MobileNo'];
    amsTDOB = json['amsT_DOB'];
    hrmEID = json['hrmE_ID'];
    studentaccyear = json['studentaccyear'];
    ftPConcessionAmt = json['ftP_Concession_Amt'];
    ftPPaidAmt = json['ftP_Paid_Amt'];
    ftPFineAmt = json['ftP_Fine_Amt'];
    fyPDate = json['fyP_Date'];
    fyPDDChequeDate = json['fyP_DD_Cheque_Date'];
    fyPTotAmount = json['fyP_Tot_Amount'];
    fyPTotFineAmt = json['fyP_Tot_Fine_Amt'];
    fyPTotConcessionAmt = json['fyP_Tot_Concession_Amt'];
    fmTId = json['fmT_Id'];
    dueamount = json['dueamount'];
    ttmCId = json['ttmC_Id'];
    ttfgDId = json['ttfgD_Id'];
    ttfGId = json['ttfG_Id'];
    hrmEId = json['hrmE_Id'];
    ttmDId = json['ttmD_Id'];
    ttmPId = json['ttmP_Id'];
    ismSId = json['ismS_Id'];
    ttmBAfterPeriod = json['ttmB_AfterPeriod'];
    idUId = json['idU_Id'];
    idUActiveFlag = json['idU_ActiveFlag'];
    intBId = json['intB_Id'];
    icWId = json['icW_Id'];
    intBStartDate = json['intB_StartDate'];
    intBEndDate = json['intB_EndDate'];
    intBActiveFlag = json['intB_ActiveFlag'];
    ivrmuLId = json['ivrmuL_Id'];
    ihWId = json['ihW_Id'];
    ihWAssignmentNo = json['ihW_AssignmentNo'];
    icWActiveFlag = json['icW_ActiveFlag'];
    icWFromDate = json['icW_FromDate'];
    icWToDate = json['icW_ToDate'];
    ipNId = json['ipN_Id'];
    ipNDate = json['ipN_Date'];
    ipNActiveFlag = json['ipN_ActiveFlag'];
    ipnSId = json['ipnS_Id'];
    ivrmmaDId = json['ivrmmaD_Id'];
    returnval = json['returnval'];
    igAId = json['igA_Id'];
    igADate = json['igA_Date'];
    igACommonGalleryFlg = json['igA_CommonGalleryFlg'];
    igaPId = json['igaP_Id'];
    igaPCoverPhotoFlag = json['igaP_CoverPhotoFlag'];
    coeEId = json['coeE_Id'];
    order = json['order'];
    emEId = json['emE_Id'];
    subjorder = json['subjorder'];
    estsUElecetiveFlag = json['estsU_ElecetiveFlag'];
    amaYRollNo = json['amaY_RollNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stdupdate'] = stdupdate;
    data['stuonlineexam'] = stuonlineexam;
    data['mobilenumber'] = mobilenumber;
    data['disabledint'] = disabledint;
    data['blockdashboard'] = blockdashboard;
    data['disabledorg'] = disabledorg;
    data['disablesubscription'] = disablesubscription;
    data['subscriptionover'] = subscriptionover;
    data['ipaT_Id'] = ipaTId;
    data['amstG_Id'] = amstGId;
    data['stP_PERSTATE'] = stPPERSTATE;
    data['stP_PERCOUNTRY'] = stPPERCOUNTRY;
    data['stP_PERPIN'] = stPPERPIN;
    data['stP_CURSTATE'] = stPCURSTATE;
    data['stP_CURCOUNTRY'] = stPCURCOUNTRY;
    data['stP_CURPIN'] = stPCURPIN;
    data['mI_Id'] = mIId;
    data['astureQ_Id'] = astureQId;
    data['fsS_Id'] = fsSId;
    data['asmaY_Id'] = asmaYId;
    data['tctaken'] = tctaken;
    data['amsT_Id'] = amsTId;
    data['fmG_Id'] = fmGId;
    data['fmH_Id'] = fmHId;
    data['ftI_Id'] = ftIId;
    data['fmA_Id'] = fmAId;
    data['fsS_OBArrearAmount'] = fsSOBArrearAmount;
    data['fsS_OBExcessAmount'] = fsSOBExcessAmount;
    data['fsS_CurrentYrCharges'] = fsSCurrentYrCharges;
    data['fsS_TotalToBePaid'] = fsSTotalToBePaid;
    data['fsS_ToBePaid'] = fsSToBePaid;
    data['fsS_PaidAmount'] = fsSPaidAmount;
    data['fsS_ExcessPaidAmount'] = fsSExcessPaidAmount;
    data['fsS_ExcessAdjustedAmount'] = fsSExcessAdjustedAmount;
    data['fsS_RunningExcessAmount'] = fsSRunningExcessAmount;
    data['fsS_ConcessionAmount'] = fsSConcessionAmount;
    data['fsS_AdjustedAmount'] = fsSAdjustedAmount;
    data['fsS_WaivedAmount'] = fsSWaivedAmount;
    data['fsS_RebateAmount'] = fsSRebateAmount;
    data['fsS_FineAmount'] = fsSFineAmount;
    data['fsS_RefundAmount'] = fsSRefundAmount;
    data['fsS_RefundAmountAdjusted'] = fsSRefundAmountAdjusted;
    data['fsS_NetAmount'] = fsSNetAmount;
    data['fsS_ChequeBounceFlag'] = fsSChequeBounceFlag;
    data['updateflag'] = updateflag;
    data['fsS_ArrearFlag'] = fsSArrearFlag;
    data['fsS_RefundOverFlag'] = fsSRefundOverFlag;
    data['fsS_ActiveFlag'] = fsSActiveFlag;
    data['user_Id'] = userId;
    data['roleid'] = roleid;
    data['feecheck'] = feecheck;
    data['asmaY_From_Date'] = asmaYFromDate;
    data['asmaY_To_Date'] = asmaYToDate;
    data['asmaY_PreAdm_F_Date'] = asmaYPreAdmFDate;
    data['asmaY_PreAdm_T_Date'] = asmaYPreAdmTDate;
    data['asmaY_Order'] = asmaYOrder;
    data['asmaY_ActiveFlag'] = asmaYActiveFlag;
    data['asmaY_Pre_ActiveFlag'] = asmaYPreActiveFlag;
    data['asmaY_Cut_Of_Date'] = asmaYCutOfDate;
    data['is_Active'] = isActive;
    data['coemE_Id'] = coemEId;
    data['coemE_ActiveFlag'] = coemEActiveFlag;
    data['asmcL_Id'] = asmcLId;
    data['asmS_Id'] = asmSId;
    data['totalBalance'] = totalBalance;
    data['receivable'] = receivable;
    data['balance'] = balance;
    data['paid'] = paid;
    data['fyP_Id'] = fyPId;
    if (librarydetails != null) {
      data['librarydetails'] = librarydetails!.toJson();
    }
    if (libraryGraphs != null) {
      data['librarygraphs'] = libraryGraphs!.toJson();
    }
    data['month'] = month;
    data['amsT_MobileNo'] = amsTMobileNo;
    data['amsT_DOB'] = amsTDOB;
    data['hrmE_ID'] = hrmEID;
    data['studentaccyear'] = studentaccyear;
    data['ftP_Concession_Amt'] = ftPConcessionAmt;
    data['ftP_Paid_Amt'] = ftPPaidAmt;
    data['ftP_Fine_Amt'] = ftPFineAmt;
    data['fyP_Date'] = fyPDate;
    data['fyP_DD_Cheque_Date'] = fyPDDChequeDate;
    data['fyP_Tot_Amount'] = fyPTotAmount;
    data['fyP_Tot_Fine_Amt'] = fyPTotFineAmt;
    data['fyP_Tot_Concession_Amt'] = fyPTotConcessionAmt;
    data['fmT_Id'] = fmTId;
    data['dueamount'] = dueamount;
    data['ttmC_Id'] = ttmCId;
    data['ttfgD_Id'] = ttfgDId;
    data['ttfG_Id'] = ttfGId;
    data['hrmE_Id'] = hrmEId;
    data['ttmD_Id'] = ttmDId;
    data['ttmP_Id'] = ttmPId;
    data['ismS_Id'] = ismSId;
    data['ttmB_AfterPeriod'] = ttmBAfterPeriod;
    data['idU_Id'] = idUId;
    data['idU_ActiveFlag'] = idUActiveFlag;
    data['intB_Id'] = intBId;
    data['icW_Id'] = icWId;
    data['intB_StartDate'] = intBStartDate;
    data['intB_EndDate'] = intBEndDate;
    data['intB_ActiveFlag'] = intBActiveFlag;
    data['ivrmuL_Id'] = ivrmuLId;
    data['ihW_Id'] = ihWId;
    data['ihW_AssignmentNo'] = ihWAssignmentNo;
    data['icW_ActiveFlag'] = icWActiveFlag;
    data['icW_FromDate'] = icWFromDate;
    data['icW_ToDate'] = icWToDate;
    data['ipN_Id'] = ipNId;
    data['ipN_Date'] = ipNDate;
    data['ipN_ActiveFlag'] = ipNActiveFlag;
    data['ipnS_Id'] = ipnSId;
    data['ivrmmaD_Id'] = ivrmmaDId;
    data['returnval'] = returnval;
    data['igA_Id'] = igAId;
    data['igA_Date'] = igADate;
    data['igA_CommonGalleryFlg'] = igACommonGalleryFlg;
    data['igaP_Id'] = igaPId;
    data['igaP_CoverPhotoFlag'] = igaPCoverPhotoFlag;
    data['coeE_Id'] = coeEId;
    data['order'] = order;
    data['emE_Id'] = emEId;
    data['subjorder'] = subjorder;
    data['estsU_ElecetiveFlag'] = estsUElecetiveFlag;
    data['amaY_RollNo'] = amaYRollNo;
    return data;
  }
}

class Librarydetails {
  String? type;
  List<LibraryDetailsValues>? values;

  Librarydetails({this.type, this.values});

  Librarydetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <LibraryDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(LibraryDetailsValues.fromJson(v));
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

class LibraryDetailsValues {
  String? type;
  int? aMSTId;
  String? lMBANOAccessionNo;
  String? lMBBookTitle;
  String? lMBBookSubTitle;
  String? lBTRIssuedDate;
  int? lMBANOId;
  String? lBTRStatus;
  String? lBTRDueDate;
  String? lBTRReturnedDate;
  String? lBTRRenewedDate;
  double? lBTRTotalFine;
  double? lBTRFineCollected;
  double? lBTRFineWaived;
  int? lBTRRenewalcounter;

  LibraryDetailsValues(
      {this.type,
      this.aMSTId,
      this.lMBANOAccessionNo,
      this.lMBBookTitle,
      this.lMBBookSubTitle,
      this.lBTRIssuedDate,
      this.lMBANOId,
      this.lBTRStatus,
      this.lBTRDueDate,
      this.lBTRReturnedDate,
      this.lBTRRenewedDate,
      this.lBTRTotalFine,
      this.lBTRFineCollected,
      this.lBTRFineWaived,
      this.lBTRRenewalcounter});

  LibraryDetailsValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    aMSTId = json['AMST_Id'];
    lMBANOAccessionNo = json['LMBANO_AccessionNo'];
    lMBBookTitle = json['LMB_BookTitle'];
    lMBBookSubTitle = json['LMB_BookSubTitle'];
    lBTRIssuedDate = json['LBTR_IssuedDate'];
    lMBANOId = json['LMBANO_Id'];
    lBTRStatus = json['LBTR_Status'];
    lBTRDueDate = json['LBTR_DueDate'];
    lBTRReturnedDate = json['LBTR_ReturnedDate'];
    lBTRRenewedDate = json['LBTR_RenewedDate'];
    lBTRTotalFine = json['LBTR_TotalFine'];
    lBTRFineCollected = json['LBTR_FineCollected'];
    lBTRFineWaived = json['LBTR_FineWaived'];
    lBTRRenewalcounter = json['LBTR_Renewalcounter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['AMST_Id'] = aMSTId;
    data['LMBANO_AccessionNo'] = lMBANOAccessionNo;
    data['LMB_BookTitle'] = lMBBookTitle;
    data['LMB_BookSubTitle'] = lMBBookSubTitle;
    data['LBTR_IssuedDate'] = lBTRIssuedDate;
    data['LMBANO_Id'] = lMBANOId;
    data['LBTR_Status'] = lBTRStatus;
    data['LBTR_DueDate'] = lBTRDueDate;
    data['LBTR_ReturnedDate'] = lBTRReturnedDate;
    data['LBTR_RenewedDate'] = lBTRRenewedDate;
    data['LBTR_TotalFine'] = lBTRTotalFine;
    data['LBTR_FineCollected'] = lBTRFineCollected;
    data['LBTR_FineWaived'] = lBTRFineWaived;
    data['LBTR_Renewalcounter'] = lBTRRenewalcounter;
    return data;
  }
}
