class PaymentGatewayDetails {
  String? type;
  List<PaymentGatewayDetailsValues>? values;

  PaymentGatewayDetails({this.type, this.values});

  PaymentGatewayDetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PaymentGatewayDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(PaymentGatewayDetailsValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    if (values != null) {
      data['$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentGatewayDetailsValues {
  String? fyppsTSettlementDate;
  num? fsCId;
  num? fscIID;
  num? fscIConcessionAmount;
  String? fyppMDDChequeDate;
  num? fyppMTotalPaidAmount;
  num? fyppsDId;
  num? totalconcession;
  num? fmCId;
  num? validationgroupid;
  num? validationgrougidcount;
  String? studentdob;
  num? ftPFineAmt;
  num? amsTConcessionType;
  num? fmTId;
  num? fyPId;
  num? fsSId;
  num? mIId;
  num? asmaYId;
  num? amstId;
  num? fmGId;
  num? fmHId;
  num? ftIId;
  num? fmAId;
  num? fsSOBArrearAmount;
  num? fsSOBExcessAmount;
  num? fsSCurrentYrCharges;
  num? fsSTotalToBePaid;
  num? fsSToBePaid;
  num? fsSPaidAmount;
  num? fsSExcessPaidAmount;
  num? fsSExcessAdjustedAmount;
  num? fsSRunningExcessAmount;
  num? fsSConcessionAmount;
  num? fsSAdjustedAmount;
  num? fsSWaivedAmount;
  num? fsSRebateAmount;
  num? fsSFineAmount;
  num? fsSRefundAmount;
  num? fsSRefundAmountAdjusted;
  num? fsSNetAmount;
  bool? fsSChequeBounceFlag;
  bool? fsSArrearFlag;
  bool? fsSRefundOverFlag;
  bool? fsSActiveFlag;
  num? fmAAmount;
  num? amaYRollNo;
  num? lCode;
  String? fyPDate;
  String? fyPDDChequeDate;
  num? fyPTotAmount;
  num? fyPTotWaivedAmt;
  num? fyPTotFineAmt;
  num? fyPTotConcessionAmt;
  bool? transtype;
  num? ftPPaidAmt;
  num? ftPConcessionAmt;
  num? totalamount;
  num? internalftpTobepaidAmt;
  num? internalpaidamount;
  num? internalftpConcessionAmt;
  num? internalftpWaivedAmt;
  num? internalftpFineAmt;
  num? internalftsf;
  num? amstMobile;
  num? asmcLID;
  num? rollno;
  num? userid;
  num? fmtId;
  num? userId;
  num? topayamount;
  num? dueamount;
  num? fsSTotalToBePaidaddfine;
  num? autoReceiptFlag;
  num? grpCount;
  String? searchdate;
  num? totalcharges;
  num? amsCId;
  num? yearid;
  num? pasRId;
  num? pasRMobileNo;
  num? transfersettings;
  num? roleid;
  num? fmgGId;
  num? pendingamount;
  num? fpgdid;
  num? ftPWaivedAmt;
  num? concession;
  num? fgaRId;
  num? fmhoTId;
  num? headorder;
  bool? challanFlag;
  num? fineAmt;
  num? fineheadfmaidsaved;
  num? trmRId;
  num? fmHOrder;
  num? asmaYOrder;
  num? asysTId;
  num? asmcLOrder;
  String? fpgDPGName;
  num? fpgDId;
  num? enduserid;
  String? dated;
  String? trsRDate;
  String? fpgDImage;
  num? fswOFineFlg;
  num? fswOFullFineWaiveOffFlg;
  num? ispaCFullPaymentCompFlg;
  num? ivrmmoDId;
  num? preASMAYId;
  String? bankDate;
  num? bankAmount;
  num? fyppMId;
  num? fcspdCId;
  num? fcspdCAmount;
  num? fmbanKId;
  num? asmSId;
  num? easebuzzstatus;

  PaymentGatewayDetailsValues(
      {this.fyppsTSettlementDate,
      this.fsCId,
      this.fscIID,
      this.fscIConcessionAmount,
      this.fyppMDDChequeDate,
      this.fyppMTotalPaidAmount,
      this.fyppsDId,
      this.totalconcession,
      this.fmCId,
      this.validationgroupid,
      this.validationgrougidcount,
      this.studentdob,
      this.ftPFineAmt,
      this.amsTConcessionType,
      this.fmTId,
      this.fyPId,
      this.fsSId,
      this.mIId,
      this.asmaYId,
      this.amstId,
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
      this.fsSArrearFlag,
      this.fsSRefundOverFlag,
      this.fsSActiveFlag,
      this.fmAAmount,
      this.amaYRollNo,
      this.lCode,
      this.fyPDate,
      this.fyPDDChequeDate,
      this.fyPTotAmount,
      this.fyPTotWaivedAmt,
      this.fyPTotFineAmt,
      this.fyPTotConcessionAmt,
      this.transtype,
      this.ftPPaidAmt,
      this.ftPConcessionAmt,
      this.totalamount,
      this.internalftpTobepaidAmt,
      this.internalpaidamount,
      this.internalftpConcessionAmt,
      this.internalftpWaivedAmt,
      this.internalftpFineAmt,
      this.internalftsf,
      this.amstMobile,
      this.asmcLID,
      this.rollno,
      this.userid,
      this.fmtId,
      this.userId,
      this.topayamount,
      this.dueamount,
      this.fsSTotalToBePaidaddfine,
      this.autoReceiptFlag,
      this.grpCount,
      this.searchdate,
      this.totalcharges,
      this.amsCId,
      this.yearid,
      this.pasRId,
      this.pasRMobileNo,
      this.transfersettings,
      this.roleid,
      this.fmgGId,
      this.pendingamount,
      this.fpgdid,
      this.ftPWaivedAmt,
      this.concession,
      this.fgaRId,
      this.fmhoTId,
      this.headorder,
      this.challanFlag,
      this.fineAmt,
      this.fineheadfmaidsaved,
      this.trmRId,
      this.fmHOrder,
      this.asmaYOrder,
      this.asysTId,
      this.asmcLOrder,
      this.fpgDPGName,
      this.fpgDId,
      this.enduserid,
      this.dated,
      this.trsRDate,
      this.fpgDImage,
      this.fswOFineFlg,
      this.fswOFullFineWaiveOffFlg,
      this.ispaCFullPaymentCompFlg,
      this.ivrmmoDId,
      this.preASMAYId,
      this.bankDate,
      this.bankAmount,
      this.fyppMId,
      this.fcspdCId,
      this.fcspdCAmount,
      this.fmbanKId,
      this.asmSId,
      this.easebuzzstatus});

  PaymentGatewayDetailsValues.fromJson(Map<String, dynamic> json) {
    fyppsTSettlementDate = json['fyppsT_Settlement_Date'];
    fsCId = json['fsC_Id'];
    fscIID = json['fscI_ID'];
    fscIConcessionAmount = json['fscI_ConcessionAmount'];
    fyppMDDChequeDate = json['fyppM_DDChequeDate'];
    fyppMTotalPaidAmount = json['fyppM_TotalPaidAmount'];
    fyppsDId = json['fyppsD_Id'];
    totalconcession = json['totalconcession'];
    fmCId = json['fmC_Id'];
    validationgroupid = json['validationgroupid'];
    validationgrougidcount = json['validationgrougidcount'];
    studentdob = json['studentdob'];
    ftPFineAmt = json['ftP_Fine_Amt'];
    amsTConcessionType = json['amsT_Concession_Type'];
    fmTId = json['fmT_Id'];
    fyPId = json['fyP_Id'];
    fsSId = json['fsS_Id'];
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    amstId = json['amst_Id'];
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
    fsSArrearFlag = json['fsS_ArrearFlag'];
    fsSRefundOverFlag = json['fsS_RefundOverFlag'];
    fsSActiveFlag = json['fsS_ActiveFlag'];
    fmAAmount = json['fmA_Amount'];
    amaYRollNo = json['amaY_RollNo'];
    lCode = json['l_Code'];
    fyPDate = json['fyP_Date'];
    fyPDDChequeDate = json['fyP_DD_Cheque_Date'];
    fyPTotAmount = json['fyP_Tot_Amount'];
    fyPTotWaivedAmt = json['fyP_Tot_Waived_Amt'];
    fyPTotFineAmt = json['fyP_Tot_Fine_Amt'];
    fyPTotConcessionAmt = json['fyP_Tot_Concession_Amt'];
    transtype = json['transtype'];
    ftPPaidAmt = json['ftP_Paid_Amt'];
    ftPConcessionAmt = json['ftP_Concession_Amt'];
    totalamount = json['totalamount'];
    internalftpTobepaidAmt = json['internalftp_tobepaid_amt'];
    internalpaidamount = json['internalpaidamount'];
    internalftpConcessionAmt = json['internalftp_concession_amt'];
    internalftpWaivedAmt = json['internalftp_waived_Amt'];
    internalftpFineAmt = json['internalftp_fine_Amt'];
    internalftsf = json['internalftsf'];
    amstMobile = json['amst_mobile'];
    asmcLID = json['asmcL_ID'];
    rollno = json['rollno'];
    userid = json['userid'];
    fmtId = json['fmt_id'];
    userId = json['user_Id'];
    topayamount = json['topayamount'];
    dueamount = json['dueamount'];
    fsSTotalToBePaidaddfine = json['fsS_TotalToBePaidaddfine'];
    autoReceiptFlag = json['auto_receipt_flag'];
    grpCount = json['grp_count'];
    searchdate = json['searchdate'];
    totalcharges = json['totalcharges'];
    amsCId = json['amsC_Id'];
    yearid = json['yearid'];
    pasRId = json['pasR_Id'];
    pasRMobileNo = json['pasR_MobileNo'];
    transfersettings = json['transfersettings'];
    roleid = json['roleid'];
    fmgGId = json['fmgG_Id'];
    pendingamount = json['pendingamount'];
    fpgdid = json['fpgdid'];
    ftPWaivedAmt = json['ftP_Waived_Amt'];
    concession = json['concession'];
    fgaRId = json['fgaR_Id'];
    fmhoTId = json['fmhoT_Id'];
    headorder = json['headorder'];
    challanFlag = json['challan_Flag'];
    fineAmt = json['fine_Amt'];
    fineheadfmaidsaved = json['fineheadfmaidsaved'];
    trmRId = json['trmR_Id'];
    fmHOrder = json['fmH_Order'];
    asmaYOrder = json['asmaY_Order'];
    asysTId = json['asysT_Id'];
    asmcLOrder = json['asmcL_Order'];
    fpgDPGName = json['fpgD_PGName'];
    fpgDId = json['fpgD_Id'];
    enduserid = json['enduserid'];
    dated = json['dated'];
    trsRDate = json['trsR_Date'];
    fpgDImage = json['fpgD_Image'];
    fswOFineFlg = json['fswO_FineFlg'];
    fswOFullFineWaiveOffFlg = json['fswO_FullFineWaiveOffFlg'];
    ispaCFullPaymentCompFlg = json['ispaC_FullPaymentCompFlg'];
    ivrmmoDId = json['ivrmmoD_Id'];
    preASMAYId = json['preASMAY_Id'];
    bankDate = json['bank_Date'];
    bankAmount = json['bank_Amount'];
    fyppMId = json['fyppM_Id'];
    fcspdCId = json['fcspdC_Id'];
    fcspdCAmount = json['fcspdC_Amount'];
    fmbanKId = json['fmbanK_Id'];
    asmSId = json['asmS_Id'];
    easebuzzstatus = json['easebuzzstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fyppsT_Settlement_Date'] = fyppsTSettlementDate;
    data['fsC_Id'] = fsCId;
    data['fscI_ID'] = fscIID;
    data['fscI_ConcessionAmount'] = fscIConcessionAmount;
    data['fyppM_DDChequeDate'] = fyppMDDChequeDate;
    data['fyppM_TotalPaidAmount'] = fyppMTotalPaidAmount;
    data['fyppsD_Id'] = fyppsDId;
    data['totalconcession'] = totalconcession;
    data['fmC_Id'] = fmCId;
    data['validationgroupid'] = validationgroupid;
    data['validationgrougidcount'] = validationgrougidcount;
    data['studentdob'] = studentdob;
    data['ftP_Fine_Amt'] = ftPFineAmt;
    data['amsT_Concession_Type'] = amsTConcessionType;
    data['fmT_Id'] = fmTId;
    data['fyP_Id'] = fyPId;
    data['fsS_Id'] = fsSId;
    data['mI_Id'] = mIId;
    data['asmaY_Id'] = asmaYId;
    data['amst_Id'] = amstId;
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
    data['fsS_ArrearFlag'] = fsSArrearFlag;
    data['fsS_RefundOverFlag'] = fsSRefundOverFlag;
    data['fsS_ActiveFlag'] = fsSActiveFlag;
    data['fmA_Amount'] = fmAAmount;
    data['amaY_RollNo'] = amaYRollNo;
    data['l_Code'] = lCode;
    data['fyP_Date'] = fyPDate;
    data['fyP_DD_Cheque_Date'] = fyPDDChequeDate;
    data['fyP_Tot_Amount'] = fyPTotAmount;
    data['fyP_Tot_Waived_Amt'] = fyPTotWaivedAmt;
    data['fyP_Tot_Fine_Amt'] = fyPTotFineAmt;
    data['fyP_Tot_Concession_Amt'] = fyPTotConcessionAmt;
    data['transtype'] = transtype;
    data['ftP_Paid_Amt'] = ftPPaidAmt;
    data['ftP_Concession_Amt'] = ftPConcessionAmt;
    data['totalamount'] = totalamount;
    data['internalftp_tobepaid_amt'] = internalftpTobepaidAmt;
    data['internalpaidamount'] = internalpaidamount;
    data['internalftp_concession_amt'] = internalftpConcessionAmt;
    data['internalftp_waived_Amt'] = internalftpWaivedAmt;
    data['internalftp_fine_Amt'] = internalftpFineAmt;
    data['internalftsf'] = internalftsf;
    data['amst_mobile'] = amstMobile;
    data['asmcL_ID'] = asmcLID;
    data['rollno'] = rollno;
    data['userid'] = userid;
    data['fmt_id'] = fmtId;
    data['user_Id'] = userId;
    data['topayamount'] = topayamount;
    data['dueamount'] = dueamount;
    data['fsS_TotalToBePaidaddfine'] = fsSTotalToBePaidaddfine;
    data['auto_receipt_flag'] = autoReceiptFlag;
    data['grp_count'] = grpCount;
    data['searchdate'] = searchdate;
    data['totalcharges'] = totalcharges;
    data['amsC_Id'] = amsCId;
    data['yearid'] = yearid;
    data['pasR_Id'] = pasRId;
    data['pasR_MobileNo'] = pasRMobileNo;
    data['transfersettings'] = transfersettings;
    data['roleid'] = roleid;
    data['fmgG_Id'] = fmgGId;
    data['pendingamount'] = pendingamount;
    data['fpgdid'] = fpgdid;
    data['ftP_Waived_Amt'] = ftPWaivedAmt;
    data['concession'] = concession;
    data['fgaR_Id'] = fgaRId;
    data['fmhoT_Id'] = fmhoTId;
    data['headorder'] = headorder;
    data['challan_Flag'] = challanFlag;
    data['fine_Amt'] = fineAmt;
    data['fineheadfmaidsaved'] = fineheadfmaidsaved;
    data['trmR_Id'] = trmRId;
    data['fmH_Order'] = fmHOrder;
    data['asmaY_Order'] = asmaYOrder;
    data['asysT_Id'] = asysTId;
    data['asmcL_Order'] = asmcLOrder;
    data['fpgD_PGName'] = fpgDPGName;
    data['fpgD_Id'] = fpgDId;
    data['enduserid'] = enduserid;
    data['dated'] = dated;
    data['trsR_Date'] = trsRDate;
    data['fpgD_Image'] = fpgDImage;
    data['fswO_FineFlg'] = fswOFineFlg;
    data['fswO_FullFineWaiveOffFlg'] = fswOFullFineWaiveOffFlg;
    data['ispaC_FullPaymentCompFlg'] = ispaCFullPaymentCompFlg;
    data['ivrmmoD_Id'] = ivrmmoDId;
    data['preASMAY_Id'] = preASMAYId;
    data['bank_Date'] = bankDate;
    data['bank_Amount'] = bankAmount;
    data['fyppM_Id'] = fyppMId;
    data['fcspdC_Id'] = fcspdCId;
    data['fcspdC_Amount'] = fcspdCAmount;
    data['fmbanK_Id'] = fmbanKId;
    data['asmS_Id'] = asmSId;
    data['easebuzzstatus'] = easebuzzstatus;
    return data;
  }
}
