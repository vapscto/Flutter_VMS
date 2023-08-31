class GalleryViewModel {
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
  Imagegallery? imagegallery;
  int? month;
  int? amsTMobileNo;
  String? amsTDOB;
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
  String? flag;
  int? coeEId;
  int? order;
  int? emEId;
  int? subjorder;
  bool? estsUElecetiveFlag;
  int? amaYRollNo;
  String? onClickOrOnChange;
  int? bookcount;
  int? assetcount;
  int? purchasecount;

  GalleryViewModel(
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
      this.imagegallery,
      this.month,
      this.amsTMobileNo,
      this.amsTDOB,
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
      this.flag,
      this.coeEId,
      this.order,
      this.emEId,
      this.subjorder,
      this.estsUElecetiveFlag,
      this.amaYRollNo,
      this.onClickOrOnChange,
      this.bookcount,
      this.assetcount,
      this.purchasecount});

  GalleryViewModel.fromJson(Map<String, dynamic> json) {
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
    imagegallery = json['imagegallery'] != null
        ? new Imagegallery.fromJson(json['imagegallery'])
        : null;
    month = json['month'];
    amsTMobileNo = json['amsT_MobileNo'];
    amsTDOB = json['amsT_DOB'];
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
    flag = json['flag'];
    coeEId = json['coeE_Id'];
    order = json['order'];
    emEId = json['emE_Id'];
    subjorder = json['subjorder'];
    estsUElecetiveFlag = json['estsU_ElecetiveFlag'];
    amaYRollNo = json['amaY_RollNo'];
    onClickOrOnChange = json['onClickOrOnChange'];
    bookcount = json['bookcount'];
    assetcount = json['assetcount'];
    purchasecount = json['purchasecount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stdupdate'] = this.stdupdate;
    data['stuonlineexam'] = this.stuonlineexam;
    data['mobilenumber'] = this.mobilenumber;
    data['disabledint'] = this.disabledint;
    data['blockdashboard'] = this.blockdashboard;
    data['disabledorg'] = this.disabledorg;
    data['disablesubscription'] = this.disablesubscription;
    data['subscriptionover'] = this.subscriptionover;
    data['ipaT_Id'] = this.ipaTId;
    data['amstG_Id'] = this.amstGId;
    data['stP_PERSTATE'] = this.stPPERSTATE;
    data['stP_PERCOUNTRY'] = this.stPPERCOUNTRY;
    data['stP_PERPIN'] = this.stPPERPIN;
    data['stP_CURSTATE'] = this.stPCURSTATE;
    data['stP_CURCOUNTRY'] = this.stPCURCOUNTRY;
    data['stP_CURPIN'] = this.stPCURPIN;
    data['mI_Id'] = this.mIId;
    data['astureQ_Id'] = this.astureQId;
    data['fsS_Id'] = this.fsSId;
    data['asmaY_Id'] = this.asmaYId;
    data['tctaken'] = this.tctaken;
    data['amsT_Id'] = this.amsTId;
    data['fmG_Id'] = this.fmGId;
    data['fmH_Id'] = this.fmHId;
    data['ftI_Id'] = this.ftIId;
    data['fmA_Id'] = this.fmAId;
    data['fsS_OBArrearAmount'] = this.fsSOBArrearAmount;
    data['fsS_OBExcessAmount'] = this.fsSOBExcessAmount;
    data['fsS_CurrentYrCharges'] = this.fsSCurrentYrCharges;
    data['fsS_TotalToBePaid'] = this.fsSTotalToBePaid;
    data['fsS_ToBePaid'] = this.fsSToBePaid;
    data['fsS_PaidAmount'] = this.fsSPaidAmount;
    data['fsS_ExcessPaidAmount'] = this.fsSExcessPaidAmount;
    data['fsS_ExcessAdjustedAmount'] = this.fsSExcessAdjustedAmount;
    data['fsS_RunningExcessAmount'] = this.fsSRunningExcessAmount;
    data['fsS_ConcessionAmount'] = this.fsSConcessionAmount;
    data['fsS_AdjustedAmount'] = this.fsSAdjustedAmount;
    data['fsS_WaivedAmount'] = this.fsSWaivedAmount;
    data['fsS_RebateAmount'] = this.fsSRebateAmount;
    data['fsS_FineAmount'] = this.fsSFineAmount;
    data['fsS_RefundAmount'] = this.fsSRefundAmount;
    data['fsS_RefundAmountAdjusted'] = this.fsSRefundAmountAdjusted;
    data['fsS_NetAmount'] = this.fsSNetAmount;
    data['fsS_ChequeBounceFlag'] = this.fsSChequeBounceFlag;
    data['updateflag'] = this.updateflag;
    data['fsS_ArrearFlag'] = this.fsSArrearFlag;
    data['fsS_RefundOverFlag'] = this.fsSRefundOverFlag;
    data['fsS_ActiveFlag'] = this.fsSActiveFlag;
    data['user_Id'] = this.userId;
    data['roleid'] = this.roleid;
    data['feecheck'] = this.feecheck;
    data['asmaY_From_Date'] = this.asmaYFromDate;
    data['asmaY_To_Date'] = this.asmaYToDate;
    data['asmaY_PreAdm_F_Date'] = this.asmaYPreAdmFDate;
    data['asmaY_PreAdm_T_Date'] = this.asmaYPreAdmTDate;
    data['asmaY_Order'] = this.asmaYOrder;
    data['asmaY_ActiveFlag'] = this.asmaYActiveFlag;
    data['asmaY_Pre_ActiveFlag'] = this.asmaYPreActiveFlag;
    data['asmaY_Cut_Of_Date'] = this.asmaYCutOfDate;
    data['is_Active'] = this.isActive;
    data['coemE_Id'] = this.coemEId;
    data['coemE_ActiveFlag'] = this.coemEActiveFlag;
    data['asmcL_Id'] = this.asmcLId;
    data['asmS_Id'] = this.asmSId;
    data['totalBalance'] = this.totalBalance;
    data['receivable'] = this.receivable;
    data['balance'] = this.balance;
    data['paid'] = this.paid;
    data['fyP_Id'] = this.fyPId;
    if (this.imagegallery != null) {
      data['imagegallery'] = this.imagegallery!.toJson();
    }
    data['month'] = this.month;
    data['amsT_MobileNo'] = this.amsTMobileNo;
    data['amsT_DOB'] = this.amsTDOB;
    data['studentaccyear'] = this.studentaccyear;
    data['ftP_Concession_Amt'] = this.ftPConcessionAmt;
    data['ftP_Paid_Amt'] = this.ftPPaidAmt;
    data['ftP_Fine_Amt'] = this.ftPFineAmt;
    data['fyP_Date'] = this.fyPDate;
    data['fyP_DD_Cheque_Date'] = this.fyPDDChequeDate;
    data['fyP_Tot_Amount'] = this.fyPTotAmount;
    data['fyP_Tot_Fine_Amt'] = this.fyPTotFineAmt;
    data['fyP_Tot_Concession_Amt'] = this.fyPTotConcessionAmt;
    data['fmT_Id'] = this.fmTId;
    data['dueamount'] = this.dueamount;
    data['ttmC_Id'] = this.ttmCId;
    data['ttfgD_Id'] = this.ttfgDId;
    data['ttfG_Id'] = this.ttfGId;
    data['hrmE_Id'] = this.hrmEId;
    data['ttmD_Id'] = this.ttmDId;
    data['ttmP_Id'] = this.ttmPId;
    data['ismS_Id'] = this.ismSId;
    data['ttmB_AfterPeriod'] = this.ttmBAfterPeriod;
    data['idU_Id'] = this.idUId;
    data['idU_ActiveFlag'] = this.idUActiveFlag;
    data['intB_Id'] = this.intBId;
    data['icW_Id'] = this.icWId;
    data['intB_StartDate'] = this.intBStartDate;
    data['intB_EndDate'] = this.intBEndDate;
    data['intB_ActiveFlag'] = this.intBActiveFlag;
    data['ivrmuL_Id'] = this.ivrmuLId;
    data['ihW_Id'] = this.ihWId;
    data['ihW_AssignmentNo'] = this.ihWAssignmentNo;
    data['icW_ActiveFlag'] = this.icWActiveFlag;
    data['icW_FromDate'] = this.icWFromDate;
    data['icW_ToDate'] = this.icWToDate;
    data['ipN_Id'] = this.ipNId;
    data['ipN_Date'] = this.ipNDate;
    data['ipN_ActiveFlag'] = this.ipNActiveFlag;
    data['ipnS_Id'] = this.ipnSId;
    data['ivrmmaD_Id'] = this.ivrmmaDId;
    data['returnval'] = this.returnval;
    data['igA_Id'] = this.igAId;
    data['igA_Date'] = this.igADate;
    data['igA_CommonGalleryFlg'] = this.igACommonGalleryFlg;
    data['igaP_Id'] = this.igaPId;
    data['igaP_CoverPhotoFlag'] = this.igaPCoverPhotoFlag;
    data['flag'] = this.flag;
    data['coeE_Id'] = this.coeEId;
    data['order'] = this.order;
    data['emE_Id'] = this.emEId;
    data['subjorder'] = this.subjorder;
    data['estsU_ElecetiveFlag'] = this.estsUElecetiveFlag;
    data['amaY_RollNo'] = this.amaYRollNo;
    data['onClickOrOnChange'] = this.onClickOrOnChange;
    data['bookcount'] = this.bookcount;
    data['assetcount'] = this.assetcount;
    data['purchasecount'] = this.purchasecount;
    return data;
  }
}

class Imagegallery {
  String? type;
  List<Values>? values;

  Imagegallery({this.type, this.values});

  Imagegallery.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <Values>[];
      json['\$values'].forEach((v) {
        values!.add(new Values.fromJson(v));
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

class Values {
  String? type;
  int? iGAId;
  String? iGAGalleryName;
  String? iGAPPhotos;
  int? iGAPId;
  bool? iGAPCoverPhotoFlag;
  int? iGAVId;
  String? iGAVVideos;

  Values(
      {this.type,
      this.iGAId,
      this.iGAGalleryName,
      this.iGAPPhotos,
      this.iGAPId,
      this.iGAPCoverPhotoFlag,
      this.iGAVId,
      this.iGAVVideos});

  Values.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    iGAId = json['IGA_Id'];
    iGAGalleryName = json['IGA_GalleryName'];
    iGAPPhotos = json['IGAP_Photos'];
    iGAPId = json['IGAP_Id'];
    iGAPCoverPhotoFlag = json['IGAP_CoverPhotoFlag'];
    iGAVId = json['IGAV_Id'];
    iGAVVideos = json['IGAV_Videos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    data['IGA_Id'] = this.iGAId;
    data['IGA_GalleryName'] = this.iGAGalleryName;
    data['IGAP_Photos'] = this.iGAPPhotos;
    data['IGAP_Id'] = this.iGAPId;
    data['IGAP_CoverPhotoFlag'] = this.iGAPCoverPhotoFlag;
    data['IGAV_Id'] = this.iGAVId;
    data['IGAV_Videos'] = this.iGAVVideos;
    return data;
  }
}
