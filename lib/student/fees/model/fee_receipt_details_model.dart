class FeeReceiptDetailsModel {
  num? amsTId;
  num? mIId;
  num? asmaYId;
  bool? status;
  String? htmldata;
  String? minstall;
  String? date;
  String? month;
  String? duration;
  String? year;
  num? fmGId;
  num? fmHId;
  num? ftIId;
  num? fmtId;
  num? ftPPaidAmt;
  num? ftPConcessionAmt;
  num? ftPFineAmt;
  num? ftPWaivedAmt;
  DateTime? fyPDate;
  String? fyPDDChequeDate;
  num? rollno;
  num? fyPId;
  num? fsSToBePaid;
  Currpaymentdetails? currpaymentdetails;
  FillStudentViewDetails? fillstudentviewdetails;

  FeeReceiptDetailsModel(
      {this.amsTId,
      this.mIId,
      this.asmaYId,
      this.status,
      this.htmldata,
      this.minstall,
      this.date,
      this.month,
      this.duration,
      this.year,
      this.fmGId,
      this.fmHId,
      this.ftIId,
      this.fmtId,
      this.ftPPaidAmt,
      this.ftPConcessionAmt,
      this.ftPFineAmt,
      this.ftPWaivedAmt,
      this.fyPDate,
      this.fyPDDChequeDate,
      this.rollno,
      this.fyPId,
      this.fsSToBePaid,
      this.currpaymentdetails,
      this.fillstudentviewdetails});

  FeeReceiptDetailsModel.fromJson(Map<String, dynamic> json) {
    amsTId = json['amsT_Id'];
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    status = json['status'];
    htmldata = json['htmldata'];
    minstall = json['minstall'];
    date = json['date'];
    month = json['month'];
    duration = json['duration'];
    year = json['year'];
    fmGId = json['fmG_Id'];
    fmHId = json['fmH_Id'];
    ftIId = json['ftI_Id'];
    fmtId = json['fmt_id'];
    ftPPaidAmt = json['ftP_Paid_Amt'];
    ftPConcessionAmt = json['ftP_Concession_Amt'];
    ftPFineAmt = json['ftP_Fine_Amt'];
    ftPWaivedAmt = json['ftP_Waived_Amt'];
    fyPDate = DateTime.parse(json['fyP_Date']);
    fyPDDChequeDate = json['fyP_DD_Cheque_Date'];
    rollno = json['rollno'];
    fyPId = json['fyP_Id'];
    fsSToBePaid = json['fsS_ToBePaid'];
    currpaymentdetails = json['currpaymentdetails'] != null
        ? Currpaymentdetails.fromJson(json['currpaymentdetails'])
        : null;
    fillstudentviewdetails = json['fillstudentviewdetails'] != null
        ? FillStudentViewDetails.fromJson(json['fillstudentviewdetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amsT_Id'] = amsTId;
    data['mI_Id'] = mIId;
    data['asmaY_Id'] = asmaYId;
    data['status'] = status;
    data['htmldata'] = htmldata;
    data['minstall'] = minstall;
    data['date'] = date;
    data['month'] = month;
    data['duration'] = duration;
    data['year'] = year;
    data['fmG_Id'] = fmGId;
    data['fmH_Id'] = fmHId;
    data['ftI_Id'] = ftIId;
    data['fmt_id'] = fmtId;
    data['ftP_Paid_Amt'] = ftPPaidAmt;
    data['ftP_Concession_Amt'] = ftPConcessionAmt;
    data['ftP_Fine_Amt'] = ftPFineAmt;
    data['ftP_Waived_Amt'] = ftPWaivedAmt;
    data['fyP_Date'] = fyPDate;
    data['fyP_DD_Cheque_Date'] = fyPDDChequeDate;
    data['rollno'] = rollno;
    data['fyP_Id'] = fyPId;
    data['fsS_ToBePaid'] = fsSToBePaid;
    if (currpaymentdetails != null) {
      data['currpaymentdetails'] = currpaymentdetails!.toJson();
    }
    if (fillstudentviewdetails != null) {
      data['fillstudentviewdetails'] = fillstudentviewdetails!.toJson();
    }
    return data;
  }
}

class Currpaymentdetails {
  String? type;
  List<CurrpaymentdetailsValues>? values;

  Currpaymentdetails({this.type, this.values});

  Currpaymentdetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CurrpaymentdetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(CurrpaymentdetailsValues.fromJson(v));
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

class FillStudentViewDetails {
  String? type;
  List<FillStudentViewDetailsValues>? values;

  FillStudentViewDetails({this.type, this.values});

  FillStudentViewDetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <FillStudentViewDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(FillStudentViewDetailsValues.fromJson(v));
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

class CurrpaymentdetailsValues {
  num? amsTId;
  num? mIId;
  num? asmaYId;
  bool? status;
  num? fmGId;
  num? fmHId;
  num? ftIId;
  num? fmtId;
  num? ftPPaidAmt;
  num? ftPConcessionAmt;
  num? ftPFineAmt;
  num? ftPWaivedAmt;
  String? fyPDate;
  String? fyPDDChequeDate;
  String? fyPBankOrCash;
  String? fyPDDChequeNo;
  String? fyPBankName;
  String? fyPRemarks;
  num? rollno;
  num? fyPId;
  num? fsSToBePaid;

  CurrpaymentdetailsValues(
      {this.amsTId,
      this.mIId,
      this.asmaYId,
      this.status,
      this.fmGId,
      this.fmHId,
      this.ftIId,
      this.fmtId,
      this.ftPPaidAmt,
      this.ftPConcessionAmt,
      this.ftPFineAmt,
      this.ftPWaivedAmt,
      this.fyPDate,
      this.fyPDDChequeDate,
      this.fyPBankOrCash,
      this.fyPDDChequeNo,
      this.fyPBankName,
      this.fyPRemarks,
      this.rollno,
      this.fyPId,
      this.fsSToBePaid});

  CurrpaymentdetailsValues.fromJson(Map<String, dynamic> json) {
    amsTId = json['amsT_Id'];
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    status = json['status'];
    fmGId = json['fmG_Id'];
    fmHId = json['fmH_Id'];
    ftIId = json['ftI_Id'];
    fmtId = json['fmt_id'];
    ftPPaidAmt = json['ftP_Paid_Amt'];
    ftPConcessionAmt = json['ftP_Concession_Amt'];
    ftPFineAmt = json['ftP_Fine_Amt'];
    ftPWaivedAmt = json['ftP_Waived_Amt'];
    fyPDate = json['fyP_Date'];
    fyPDDChequeDate = json['fyP_DD_Cheque_Date'];
    fyPBankOrCash = json['fyP_Bank_Or_Cash'];
    fyPDDChequeNo = json['fyP_DD_Cheque_No'];
    fyPBankName = json['fyP_Bank_Name'];
    fyPRemarks = json['fyP_Remarks'];
    rollno = json['rollno'];
    fyPId = json['fyP_Id'];
    fsSToBePaid = json['fsS_ToBePaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amsT_Id'] = amsTId;
    data['mI_Id'] = mIId;
    data['asmaY_Id'] = asmaYId;
    data['status'] = status;
    data['fmG_Id'] = fmGId;
    data['fmH_Id'] = fmHId;
    data['ftI_Id'] = ftIId;
    data['fmt_id'] = fmtId;
    data['ftP_Paid_Amt'] = ftPPaidAmt;
    data['ftP_Concession_Amt'] = ftPConcessionAmt;
    data['ftP_Fine_Amt'] = ftPFineAmt;
    data['ftP_Waived_Amt'] = ftPWaivedAmt;
    data['fyP_Date'] = fyPDate;
    data['fyP_DD_Cheque_Date'] = fyPDDChequeDate;
    data['fyP_Bank_Or_Cash'] = fyPBankOrCash;
    data['fyP_DD_Cheque_No'] = fyPDDChequeNo;
    data['fyP_Bank_Name'] = fyPBankName;
    data['fyP_Remarks'] = fyPRemarks;
    data['rollno'] = rollno;
    data['fyP_Id'] = fyPId;
    data['fsS_ToBePaid'] = fsSToBePaid;
    return data;
  }
}

class FillStudentViewDetailsValues {
  // String? type;
  num? amsTId;
  String? amsTFirstName;
  String? amsTMiddleName;
  String? amsTLastName;
  num? fmHId;
  String? fmHFeeName;
  String? ftIName;
  num? ftIId;
  String? fyPReceiptNo;
  num? ftPPaidAmt;
  num? ftPConcessionAmt;
  num? ftPFineAmt;
  num? fsSToBePaid;
  dynamic fyPDate;
  String? classname;
  String? sectionname;
  num? rollno;
  String? admno;
  String? fathername;
  String? mothername;
  String? fyPBankOrCash;
  String? fyPDDChequeNo;
  String? fyPDDChequeDate;
  String? fyPBankName;
  String? fYPRemarks;
  String? aMSTRegistrationNo;
  String? fMCCConcessionName;
  num? totalcharges;
  num? fSSAdjustedAmount;
  num? amstMobile;
  String? fYPChallanNo;
  num? fMHOrder;
  String? fypTransactionId;
  num? fSSRebateAmount;

  FillStudentViewDetailsValues(
      {
      // this.type,
      this.amsTId,
      this.amsTFirstName,
      this.amsTMiddleName,
      this.amsTLastName,
      this.fmHId,
      this.fmHFeeName,
      this.ftIName,
      this.ftIId,
      this.fyPReceiptNo,
      this.ftPPaidAmt,
      this.ftPConcessionAmt,
      this.ftPFineAmt,
      this.fsSToBePaid,
      this.fyPDate,
      this.classname,
      this.sectionname,
      this.rollno,
      this.admno,
      this.fathername,
      this.mothername,
      this.fyPBankOrCash,
      this.fyPDDChequeNo,
      this.fyPDDChequeDate,
      this.fyPBankName,
      this.fYPRemarks,
      this.aMSTRegistrationNo,
      this.fMCCConcessionName,
      this.totalcharges,
      this.fSSAdjustedAmount,
      this.amstMobile,
      this.fYPChallanNo,
      this.fMHOrder,
      this.fypTransactionId,
      this.fSSRebateAmount});

  FillStudentViewDetailsValues.fromJson(Map<String, dynamic> json) {
    amsTId = json['amsT_Id'] ?? 0;
    amsTFirstName = json['amsT_FirstName'] ?? 'N/A';
    amsTMiddleName = json['amsT_MiddleName'] ?? 'N/A';
    amsTLastName = json['amsT_LastName'] ?? 'N/A';
    fmHId = json['fmH_Id'] ?? 0;
    fmHFeeName = json['fmH_FeeName'] ?? 'N/A';
    ftIName = json['ftI_Name'] ?? 'N/A';
    ftIId = json['ftI_Id'] ?? 0;
    fyPReceiptNo = json['fyP_Receipt_No'] ?? 'N/A';
    ftPPaidAmt = json['ftP_Paid_Amt'] ?? 0;
    ftPConcessionAmt = json['ftP_Concession_Amt'] ?? 0;
    ftPFineAmt = json['ftP_Fine_Amt'] ?? 0;
    fsSToBePaid = json['fsS_ToBePaid'] ?? 0;
    fyPDate =
        json['fyP_Date'] == null ? 'N/A' : DateTime.parse(json['fyP_Date']);
    classname = json['classname'] ?? 'N/A';
    sectionname = json['sectionname'] ?? 'N/A';
    rollno = json['rollno'] ?? 0;
    admno = json['admno'] ?? 'N/A';
    fathername = json['fathername'] ?? 'N/A';
    mothername = json['mothername'] ?? 'N/A';
    fyPBankOrCash = json['fyP_Bank_Or_Cash'] ?? 'N/A';
    fyPDDChequeNo = json['fyP_DD_Cheque_No'] ?? 'N/A';
    fyPDDChequeDate = json['fyP_DD_Cheque_Date'] ?? 'N/A';
    fyPBankName = json['fyP_Bank_Name'] ?? 'N/A';
    fYPRemarks = json['FYP_Remarks'] ?? 'N/A';
    aMSTRegistrationNo = json['AMST_RegistrationNo'] ?? 'N/A';
    fMCCConcessionName = json['FMCC_ConcessionName'] ?? 'N/A';
    totalcharges = json['totalcharges'] ?? 0;
    fSSAdjustedAmount = json['FSS_AdjustedAmount'] ?? 0;
    amstMobile = json['amst_mobile'] ?? 0;
    fYPChallanNo = json['FYP_ChallanNo'] ?? 'N/A';
    fMHOrder = json['FMH_Order'] ?? 0;
    fypTransactionId = json['fyp_transaction_id'] ?? 'N/A';
    fSSRebateAmount = json['FSS_RebateAmount'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['\$type'] = type;
    data['amsT_Id'] = amsTId;
    data['amsT_FirstName'] = amsTFirstName;
    data['amsT_MiddleName'] = amsTMiddleName;
    data['amsT_LastName'] = amsTLastName;
    data['fmH_Id'] = fmHId;
    data['fmH_FeeName'] = fmHFeeName;
    data['ftI_Name'] = ftIName;
    data['ftI_Id'] = ftIId;
    data['fyP_Receipt_No'] = fyPReceiptNo;
    data['ftP_Paid_Amt'] = ftPPaidAmt;
    data['ftP_Concession_Amt'] = ftPConcessionAmt;
    data['ftP_Fine_Amt'] = ftPFineAmt;
    data['fsS_ToBePaid'] = fsSToBePaid;
    data['fyP_Date'] = fyPDate;
    data['classname'] = classname;
    data['sectionname'] = sectionname;
    data['rollno'] = rollno;
    data['admno'] = admno;
    data['fathername'] = fathername;
    data['mothername'] = mothername;
    data['fyP_Bank_Or_Cash'] = fyPBankOrCash;
    data['fyP_DD_Cheque_No'] = fyPDDChequeNo;
    data['fyP_DD_Cheque_Date'] = fyPDDChequeDate;
    data['fyP_Bank_Name'] = fyPBankName;
    data['FYP_Remarks'] = fYPRemarks;
    data['AMST_RegistrationNo'] = aMSTRegistrationNo;
    data['FMCC_ConcessionName'] = fMCCConcessionName;
    data['totalcharges'] = totalcharges;
    data['FSS_AdjustedAmount'] = fSSAdjustedAmount;
    data['amst_mobile'] = amstMobile;
    data['FYP_ChallanNo'] = fYPChallanNo;
    data['FMH_Order'] = fMHOrder;
    data['fyp_transaction_id'] = fypTransactionId;
    data['FSS_RebateAmount'] = fSSRebateAmount;
    return data;
  }
}
