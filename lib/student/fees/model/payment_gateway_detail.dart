class PaymentGateWayDetails {
  String? fyppsTSettlementDate;
  int? fsCId;
  int? fscIID;
  int? fscIConcessionAmount;
  String? fyppMDDChequeDate;
  double? fyppMTotalPaidAmount;
  int? fyppsDId;
  int? totalconcession;
  String? fyPPayModeType;
  String? splitpayinformation;
  int? fmCId;
  int? validationgroupid;
  int? validationgrougidcount;
  String? studentdob;
  double? ftPFineAmt;
  int? amsTConcessionType;
  int? fmTId;
  String? ftiidss;
  int? fyPId;
  int? fsSId;
  int? mIId;
  int? asmaYId;
  int? amstId;
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
  bool? fsSArrearFlag;
  bool? fsSRefundOverFlag;
  bool? fsSActiveFlag;
  Fillstudent? fillstudent;
  double? fmAAmount;
  int? amaYRollNo;
  int? lCode;
  String? fyPReceiptNo;
  String? fyPDate;
  String? fyPDDChequeDate;
  double? fyPTotAmount;
  double? fyPTotWaivedAmt;
  double? fyPTotFineAmt;
  double? fyPTotConcessionAmt;
  bool? transtype;
  double? ftPPaidAmt;
  double? ftPConcessionAmt;
  double? totalamount;
  double? internalftpTobepaidAmt;
  double? internalpaidamount;
  double? internalftpConcessionAmt;
  double? internalftpWaivedAmt;
  double? internalftpFineAmt;
  int? internalftsf;
  int? amstMobile;
  int? asmcLID;
  int? rollno;
  int? userid;
  int? fmtId;
  int? userId;
  int? topayamount;
  int? dueamount;
  int? fsSTotalToBePaidaddfine;
  int? autoReceiptFlag;
  int? grpCount;
  String? searchdate;
  double? totalcharges;
  Transnumbconfigurationsettingsss? transnumbconfigurationsettingsss;
  String? automanualreceiptno;
  int? amsCId;
  int? yearid;
  String? grpidss;
  int? pasRId;
  int? pasRMobileNo;
  int? transfersettings;
  int? roleid;
  int? fmgGId;
  List<SelectedList>? selectedList;
  //AmountList? amountList;
  int? pendingamount;
  int? fpgdid;
  double? ftPWaivedAmt;
  double? concession;
  int? fgaRId;
  String? transId;
  int? fmhoTId;
  int? headorder;
  bool? challanFlag;
  int? fineAmt;
  int? fineheadfmaidsaved;
  int? trmRId;
  int? fmHOrder;
  int? asmaYOrder;
  int? asysTId;
  int? asmcLOrder;
  int? fpgDId;
  String? onlinepaygteway;
  int? enduserid;
  String? dated;
  String? trsRDate;
  String? merchantkey;
  int? fswOFineFlg;
  int? fswOFullFineWaiveOffFlg;
  int? ispaCFullPaymentCompFlg;
  int? ivrmmoDId;
  int? preASMAYId;
  String? bankDate;
  double? bankAmount;
  int? fyppMId;
  int? fcspdCId;
  double? fcspdCAmount;
  int? fmbanKId;
  int? rebateamount;
  int? ftoTRebateAmount;
  int? easebuzzstatus;
  String? easebuzzdata;
  String? easebuzzenv;

  PaymentGateWayDetails(
      {this.fyppsTSettlementDate,
      this.fsCId,
      this.fscIID,
      this.fscIConcessionAmount,
      this.fyppMDDChequeDate,
      this.fyppMTotalPaidAmount,
      this.fyppsDId,
      this.totalconcession,
      this.fyPPayModeType,
      this.splitpayinformation,
      this.fmCId,
      this.validationgroupid,
      this.validationgrougidcount,
      this.studentdob,
      this.ftPFineAmt,
      this.amsTConcessionType,
      this.fmTId,
      this.ftiidss,
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
      this.fillstudent,
      this.fmAAmount,
      this.amaYRollNo,
      this.lCode,
      this.fyPReceiptNo,
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
      this.transnumbconfigurationsettingsss,
      this.automanualreceiptno,
      this.amsCId,
      this.yearid,
      this.grpidss,
      this.pasRId,
      this.pasRMobileNo,
      this.transfersettings,
      this.roleid,
      this.fmgGId,
      this.selectedList,
      // this.amountList,
      this.pendingamount,
      this.fpgdid,
      this.ftPWaivedAmt,
      this.concession,
      this.fgaRId,
      this.transId,
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
      this.fpgDId,
      this.onlinepaygteway,
      this.enduserid,
      this.dated,
      this.trsRDate,
      this.merchantkey,
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
      this.rebateamount,
      this.ftoTRebateAmount,
      this.easebuzzstatus,
      this.easebuzzdata,
      this.easebuzzenv});

  PaymentGateWayDetails.fromJson(Map<String, dynamic> json) {
    fyppsTSettlementDate = json['fyppsT_Settlement_Date'];
    fsCId = json['fsC_Id'];
    fscIID = json['fscI_ID'];
    fscIConcessionAmount = json['fscI_ConcessionAmount'];
    fyppMDDChequeDate = json['fyppM_DDChequeDate'];
    fyppMTotalPaidAmount = json['fyppM_TotalPaidAmount'];
    fyppsDId = json['fyppsD_Id'];
    totalconcession = json['totalconcession'];
    fyPPayModeType = json['fyP_PayModeType'];
    splitpayinformation = json['splitpayinformation'];
    fmCId = json['fmC_Id'];
    validationgroupid = json['validationgroupid'];
    validationgrougidcount = json['validationgrougidcount'];
    studentdob = json['studentdob'];
    ftPFineAmt = json['ftP_Fine_Amt'];
    amsTConcessionType = json['amsT_Concession_Type'];
    fmTId = json['fmT_Id'];
    ftiidss = json['ftiidss'];
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
    fillstudent = json['fillstudent'] != null
        ? Fillstudent.fromJson(json['fillstudent'])
        : null;
    fmAAmount = json['fmA_Amount'];
    amaYRollNo = json['amaY_RollNo'];
    lCode = json['l_Code'];
    fyPReceiptNo = json['fyP_Receipt_No'];
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
    transnumbconfigurationsettingsss =
        json['transnumbconfigurationsettingsss'] != null
            ? Transnumbconfigurationsettingsss.fromJson(
                json['transnumbconfigurationsettingsss'])
            : null;
    automanualreceiptno = json['automanualreceiptno'];
    amsCId = json['amsC_Id'];
    yearid = json['yearid'];
    grpidss = json['grpidss'];
    pasRId = json['pasR_Id'];
    pasRMobileNo = json['pasR_MobileNo'];
    transfersettings = json['transfersettings'];
    roleid = json['roleid'];
    fmgGId = json['fmgG_Id'];
    if (json['selected_list'] != null) {
      selectedList = <SelectedList>[];
      json['selected_list'].forEach((v) {
        selectedList!.add(SelectedList.fromJson(v));
      });
    }
    // amountList = json['amount_list'] != null
    //     ? AmountList.fromJson(json['amount_list'])
    //     : null;
    pendingamount = json['pendingamount'];
    fpgdid = json['fpgdid'];
    ftPWaivedAmt = json['ftP_Waived_Amt'];
    concession = json['concession'];
    fgaRId = json['fgaR_Id'];
    transId = json['trans_id'];
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
    fpgDId = json['fpgD_Id'];
    onlinepaygteway = json['onlinepaygteway'];
    enduserid = json['enduserid'];
    dated = json['dated'];
    trsRDate = json['trsR_Date'];
    merchantkey = json['merchantkey'];
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
    rebateamount = json['rebateamount'];
    ftoTRebateAmount = json['ftoT_RebateAmount'];
    easebuzzstatus = json['easebuzzstatus'];
    easebuzzdata = json['easebuzzdata'];
    easebuzzenv = json['easebuzzenv'];
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
    data['fyP_PayModeType'] = fyPPayModeType;
    data['splitpayinformation'] = splitpayinformation;
    data['fmC_Id'] = fmCId;
    data['validationgroupid'] = validationgroupid;
    data['validationgrougidcount'] = validationgrougidcount;
    data['studentdob'] = studentdob;
    data['ftP_Fine_Amt'] = ftPFineAmt;
    data['amsT_Concession_Type'] = amsTConcessionType;
    data['fmT_Id'] = fmTId;
    data['ftiidss'] = ftiidss;
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
    if (fillstudent != null) {
      data['fillstudent'] = fillstudent!.toJson();
    }
    data['fmA_Amount'] = fmAAmount;
    data['amaY_RollNo'] = amaYRollNo;
    data['l_Code'] = lCode;
    data['fyP_Receipt_No'] = fyPReceiptNo;
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
    if (transnumbconfigurationsettingsss != null) {
      data['transnumbconfigurationsettingsss'] =
          transnumbconfigurationsettingsss!.toJson();
    }
    data['automanualreceiptno'] = automanualreceiptno;
    data['amsC_Id'] = amsCId;
    data['yearid'] = yearid;
    data['grpidss'] = grpidss;
    data['pasR_Id'] = pasRId;
    data['pasR_MobileNo'] = pasRMobileNo;
    data['transfersettings'] = transfersettings;
    data['roleid'] = roleid;
    data['fmgG_Id'] = fmgGId;
    if (selectedList != null) {
      data['selected_list'] = selectedList!.map((v) => v.toJson()).toList();
    }
    // if (amountList != null) {
    //   data['amount_list'] = amountList!.toJson();
    // }
    data['pendingamount'] = pendingamount;
    data['fpgdid'] = fpgdid;
    data['ftP_Waived_Amt'] = ftPWaivedAmt;
    data['concession'] = concession;
    data['fgaR_Id'] = fgaRId;
    data['trans_id'] = transId;
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
    data['fpgD_Id'] = fpgDId;
    data['onlinepaygteway'] = onlinepaygteway;
    data['enduserid'] = enduserid;
    data['dated'] = dated;
    data['trsR_Date'] = trsRDate;
    data['merchantkey'] = merchantkey;
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
    data['rebateamount'] = rebateamount;
    data['ftoT_RebateAmount'] = ftoTRebateAmount;
    data['easebuzzstatus'] = easebuzzstatus;
    data['easebuzzdata'] = easebuzzdata;
    data['easebuzzenv'] = easebuzzenv;
    return data;
  }
}

class Fillstudent {
  String? type;
  List<Values>? values;

  Fillstudent({this.type, this.values});

  Fillstudent.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['$values'] != null) {
      values = <Values>[];
      json['$values'].forEach((v) {
        values!.add(Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    if (values != null) {
      data['$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  String? fyppsTSettlementDate;
  int? fsCId;
  int? fscIID;
  int? fscIConcessionAmount;
  String? fyppMDDChequeDate;
  double? fyppMTotalPaidAmount;
  int? fyppsDId;
  int? totalconcession;
  String? amsTPerCity;
  int? fmCId;
  int? validationgroupid;
  int? validationgrougidcount;
  String? studentdob;
  double? ftPFineAmt;
  int? amsTConcessionType;
  int? fmTId;
  int? fyPId;
  int? fsSId;
  int? mIId;
  int? asmaYId;
  int? amstId;
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
  bool? fsSArrearFlag;
  bool? fsSRefundOverFlag;
  bool? fsSActiveFlag;
  double? fmAAmount;
  String? amsTFirstName;
  String? amsTMiddleName;
  String? amsTLastName;
  String? amsTRegistrationNo;
  String? amsTAdmNo;
  int? amaYRollNo;
  int? lCode;
  String? fyPDate;
  String? fyPDDChequeDate;
  double? fyPTotAmount;
  double? fyPTotWaivedAmt;
  double? fyPTotFineAmt;
  double? fyPTotConcessionAmt;
  bool? transtype;
  double? ftPPaidAmt;
  double? ftPConcessionAmt;
  double? totalamount;
  double? internalftpTobepaidAmt;
  double? internalpaidamount;
  double? internalftpConcessionAmt;
  double? internalftpWaivedAmt;
  double? internalftpFineAmt;
  int? internalftsf;
  int? amstMobile;
  String? amstEmailId;
  int? asmcLID;
  String? classname;
  String? sectionname;
  int? rollno;
  int? userid;
  int? fmtId;
  int? userId;
  int? topayamount;
  int? dueamount;
  int? fsSTotalToBePaidaddfine;
  int? autoReceiptFlag;
  int? grpCount;
  String? searchdate;
  double? totalcharges;
  int? amsCId;
  int? yearid;
  int? pasRId;
  int? pasRMobileNo;
  int? transfersettings;
  int? roleid;
  int? fmgGId;
  int? pendingamount;
  int? fpgdid;
  double? ftPWaivedAmt;
  double? concession;
  int? fgaRId;
  int? fmhoTId;
  int? headorder;
  bool? challanFlag;
  int? fineAmt;
  int? fineheadfmaidsaved;
  int? trmRId;
  int? fmHOrder;
  int? asmaYOrder;
  int? asysTId;
  int? asmcLOrder;
  int? fpgDId;
  int? enduserid;
  String? dated;
  String? trsRDate;
  int? fswOFineFlg;
  int? fswOFullFineWaiveOffFlg;
  int? ispaCFullPaymentCompFlg;
  int? ivrmmoDId;
  int? preASMAYId;
  String? bankDate;
  double? bankAmount;
  int? fyppMId;
  int? fcspdCId;
  double? fcspdCAmount;
  int? fmbanKId;
  int? rebateamount;
  int? ftoTRebateAmount;

  Values(
      {this.fyppsTSettlementDate,
      this.fsCId,
      this.fscIID,
      this.fscIConcessionAmount,
      this.fyppMDDChequeDate,
      this.fyppMTotalPaidAmount,
      this.fyppsDId,
      this.totalconcession,
      this.amsTPerCity,
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
      this.amsTFirstName,
      this.amsTMiddleName,
      this.amsTLastName,
      this.amsTRegistrationNo,
      this.amsTAdmNo,
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
      this.amstEmailId,
      this.asmcLID,
      this.classname,
      this.sectionname,
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
      this.fpgDId,
      this.enduserid,
      this.dated,
      this.trsRDate,
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
      this.rebateamount,
      this.ftoTRebateAmount});

  Values.fromJson(Map<String, dynamic> json) {
    fyppsTSettlementDate = json['fyppsT_Settlement_Date'];
    fsCId = json['fsC_Id'];
    fscIID = json['fscI_ID'];
    fscIConcessionAmount = json['fscI_ConcessionAmount'];
    fyppMDDChequeDate = json['fyppM_DDChequeDate'];
    fyppMTotalPaidAmount = json['fyppM_TotalPaidAmount'];
    fyppsDId = json['fyppsD_Id'];
    totalconcession = json['totalconcession'];
    amsTPerCity = json['amsT_PerCity'];
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
    amsTFirstName = json['amsT_FirstName'];
    amsTMiddleName = json['amsT_MiddleName'];
    amsTLastName = json['amsT_LastName'];
    amsTRegistrationNo = json['amsT_RegistrationNo'];
    amsTAdmNo = json['amsT_AdmNo'];
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
    amstEmailId = json['amst_email_id'];
    asmcLID = json['asmcL_ID'];
    classname = json['classname'];
    sectionname = json['sectionname'];
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
    fpgDId = json['fpgD_Id'];
    enduserid = json['enduserid'];
    dated = json['dated'];
    trsRDate = json['trsR_Date'];
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
    rebateamount = json['rebateamount'];
    ftoTRebateAmount = json['ftoT_RebateAmount'];
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
    data['amsT_PerCity'] = amsTPerCity;
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
    data['amsT_FirstName'] = amsTFirstName;
    data['amsT_MiddleName'] = amsTMiddleName;
    data['amsT_LastName'] = amsTLastName;
    data['amsT_RegistrationNo'] = amsTRegistrationNo;
    data['amsT_AdmNo'] = amsTAdmNo;
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
    data['amst_email_id'] = amstEmailId;
    data['asmcL_ID'] = asmcLID;
    data['classname'] = classname;
    data['sectionname'] = sectionname;
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
    data['fpgD_Id'] = fpgDId;
    data['enduserid'] = enduserid;
    data['dated'] = dated;
    data['trsR_Date'] = trsRDate;
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
    data['rebateamount'] = rebateamount;
    data['ftoT_RebateAmount'] = ftoTRebateAmount;
    return data;
  }
}

class Transnumbconfigurationsettingsss {
  int? imNId;
  int? mIId;
  bool? imNPrefixAcadYearCode;
  bool? imNSuffixAcadYearCode;
  int? asmaYId;

  Transnumbconfigurationsettingsss(
      {this.imNId,
      this.mIId,
      this.imNPrefixAcadYearCode,
      this.imNSuffixAcadYearCode,
      this.asmaYId});

  Transnumbconfigurationsettingsss.fromJson(Map<String, dynamic> json) {
    imNId = json['imN_Id'];
    mIId = json['mI_Id'];
    imNPrefixAcadYearCode = json['imN_PrefixAcadYearCode'];
    imNSuffixAcadYearCode = json['imN_SuffixAcadYearCode'];
    asmaYId = json['asmaY_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imN_Id'] = imNId;
    data['mI_Id'] = mIId;
    data['imN_PrefixAcadYearCode'] = imNPrefixAcadYearCode;
    data['imN_SuffixAcadYearCode'] = imNSuffixAcadYearCode;
    data['asmaY_Id'] = asmaYId;
    return data;
  }
}

class SelectedList {
  Grp? grp;
  List<TrmList>? trmList;

  SelectedList({this.grp, this.trmList});

  SelectedList.fromJson(Map<String, dynamic> json) {
    grp = json['grp'] != null ? Grp.fromJson(json['grp']) : null;
    if (json['trm_list'] != null) {
      trmList = <TrmList>[];
      json['trm_list'].forEach((v) {
        trmList!.add(TrmList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (grp != null) {
      data['grp'] = grp!.toJson();
    }
    if (trmList != null) {
      data['trm_list'] = trmList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Grp {
  String? fmgGGroupName;
  int? fmgGId;

  Grp({this.fmgGGroupName, this.fmgGId});

  Grp.fromJson(Map<String, dynamic> json) {
    fmgGGroupName = json['fmgG_GroupName'];
    fmgGId = json['fmgG_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fmgG_GroupName'] = fmgGGroupName;
    data['fmgG_Id'] = fmgGId;
    return data;
  }
}

class TrmList {
  String? fmgGGroupName;
  int? fmgGId;
  String? fmTName;
  int? fmTId;
  int? fmTOrder;
  bool? preAdmFlag;

  TrmList(
      {this.fmgGGroupName,
      this.fmgGId,
      this.fmTName,
      this.fmTId,
      this.fmTOrder,
      this.preAdmFlag});

  TrmList.fromJson(Map<String, dynamic> json) {
    fmgGGroupName = json['fmgG_GroupName'];
    fmgGId = json['fmgG_Id'];
    fmTName = json['fmT_Name'];
    fmTId = json['fmT_Id'];
    fmTOrder = json['fmT_Order'];
    preAdmFlag = json['preAdmFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fmgG_GroupName'] = fmgGGroupName;
    data['fmgG_Id'] = fmgGId;
    data['fmT_Name'] = fmTName;
    data['fmT_Id'] = fmTId;
    data['fmT_Order'] = fmTOrder;
    data['preAdmFlag'] = preAdmFlag;
    return data;
  }
}

// class AmountList {
//   String? type;
//   List<Null>? values;

//   AmountList({this.type, this.values});

//   AmountList.fromJson(Map<String, dynamic> json) {
//     type = json['$type'];
//     if (json['$values'] != null) {
//       values = <Null>[];
//       json['$values'].forEach((v) {
//         values!.add(new Null.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['$type'] = this.type;
//     if (this.values != null) {
//       data['$values'] = this.values!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
