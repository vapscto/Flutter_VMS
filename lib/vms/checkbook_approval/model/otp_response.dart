class OtpResponse {
  int? ismcltprPId;
  int? hrpaoNSanctionLevelNo;
  int? ismmcltpRId;
  int? vmchebkslNId;
  int? ivrmuLId;
  int? vpayvoUId;
  int? mIId;
  int? vbabrSId;
  int? fmIId;
  double? ismcltprboMQty;
  double? isminCAdvPer;
  double? isminCAdvanceAmount;
  int? ismcltCId;
  int? mobilenumber;
  String? vpayvoUPaymentDate;
  double? vpayvoUAppliedAmount;
  double? vpayvoUApprovedAmount;
  double? vpayvoUBankBalalnce;
  bool? vpayvoUChequePrintedFlg;
  bool? vpayvoUSupplierFlg;
  int? imfYId;
  int? userId;
  int? ismcltprPYear;
  int? hrmbDId;
  double? isminCTotalTaxAmount;
  double? isminCTotalAmount;
  bool? ismcltprPActiveFlag;
  int? ismcltprPCreatedBy;
  int? ismcltprPUpdatedBy;
  int? ismmpRId;
  int? ismmclTId;
  int? asmaYId;
  bool? duplicate;
  bool? returnval;
  int? cltprid;
  int? ismcppDId;
  int? flag;
  int? ivrmmoDId;
  String? message;
  String? emailotp;
  String? emaiLId;
  int? vcbsrCId;
  bool? vpayvoUSelfPayFlg;

  OtpResponse(
      {this.ismcltprPId,
      this.hrpaoNSanctionLevelNo,
      this.ismmcltpRId,
      this.vmchebkslNId,
      this.ivrmuLId,
      this.vpayvoUId,
      this.mIId,
      this.vbabrSId,
      this.fmIId,
      this.ismcltprboMQty,
      this.isminCAdvPer,
      this.isminCAdvanceAmount,
      this.ismcltCId,
      this.mobilenumber,
      this.vpayvoUPaymentDate,
      this.vpayvoUAppliedAmount,
      this.vpayvoUApprovedAmount,
      this.vpayvoUBankBalalnce,
      this.vpayvoUChequePrintedFlg,
      this.vpayvoUSupplierFlg,
      this.imfYId,
      this.userId,
      this.ismcltprPYear,
      this.hrmbDId,
      this.isminCTotalTaxAmount,
      this.isminCTotalAmount,
      this.ismcltprPActiveFlag,
      this.ismcltprPCreatedBy,
      this.ismcltprPUpdatedBy,
      this.ismmpRId,
      this.ismmclTId,
      this.asmaYId,
      this.duplicate,
      this.returnval,
      this.cltprid,
      this.ismcppDId,
      this.flag,
      this.ivrmmoDId,
      this.message,
      this.emailotp,
      this.emaiLId,
      this.vcbsrCId,
      this.vpayvoUSelfPayFlg});

  OtpResponse.fromJson(Map<String, dynamic> json) {
    ismcltprPId = json['ismcltprP_Id'];
    hrpaoNSanctionLevelNo = json['hrpaoN_SanctionLevelNo'];
    ismmcltpRId = json['ismmcltpR_Id'];
    vmchebkslNId = json['vmchebkslN_Id'];
    ivrmuLId = json['ivrmuL_Id'];
    vpayvoUId = json['vpayvoU_Id'];
    mIId = json['mI_Id'];
    vbabrSId = json['vbabrS_Id'];
    fmIId = json['fmI_Id'];
    ismcltprboMQty = json['ismcltprboM_Qty'];
    isminCAdvPer = json['isminC_AdvPer'];
    isminCAdvanceAmount = json['isminC_AdvanceAmount'];
    ismcltCId = json['ismcltC_Id'];
    mobilenumber = json['mobilenumber'];
    vpayvoUPaymentDate = json['vpayvoU_PaymentDate'];
    vpayvoUAppliedAmount = json['vpayvoU_AppliedAmount'];
    vpayvoUApprovedAmount = json['vpayvoU_ApprovedAmount'];
    vpayvoUBankBalalnce = json['vpayvoU_BankBalalnce'];
    vpayvoUChequePrintedFlg = json['vpayvoU_ChequePrintedFlg'];
    vpayvoUSupplierFlg = json['vpayvoU_SupplierFlg'];
    imfYId = json['imfY_Id'];
    userId = json['userId'];
    ismcltprPYear = json['ismcltprP_Year'];
    hrmbDId = json['hrmbD_Id'];
    isminCTotalTaxAmount = json['isminC_TotalTaxAmount'];
    isminCTotalAmount = json['isminC_TotalAmount'];
    ismcltprPActiveFlag = json['ismcltprP_ActiveFlag'];
    ismcltprPCreatedBy = json['ismcltprP_CreatedBy'];
    ismcltprPUpdatedBy = json['ismcltprP_UpdatedBy'];
    ismmpRId = json['ismmpR_Id'];
    ismmclTId = json['ismmclT_Id'];
    asmaYId = json['asmaY_Id'];
    duplicate = json['duplicate'];
    returnval = json['returnval'];
    cltprid = json['cltprid'];
    ismcppDId = json['ismcppD_Id'];
    flag = json['flag'];
    ivrmmoDId = json['ivrmmoD_Id'];
    message = json['message'];
    emailotp = json['emailotp'];
    emaiLId = json['emaiL_Id'];
    vcbsrCId = json['vcbsrC_Id'];
    vpayvoUSelfPayFlg = json['vpayvoU_SelfPayFlg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ismcltprP_Id'] = this.ismcltprPId;
    data['hrpaoN_SanctionLevelNo'] = this.hrpaoNSanctionLevelNo;
    data['ismmcltpR_Id'] = this.ismmcltpRId;
    data['vmchebkslN_Id'] = this.vmchebkslNId;
    data['ivrmuL_Id'] = this.ivrmuLId;
    data['vpayvoU_Id'] = this.vpayvoUId;
    data['mI_Id'] = this.mIId;
    data['vbabrS_Id'] = this.vbabrSId;
    data['fmI_Id'] = this.fmIId;
    data['ismcltprboM_Qty'] = this.ismcltprboMQty;
    data['isminC_AdvPer'] = this.isminCAdvPer;
    data['isminC_AdvanceAmount'] = this.isminCAdvanceAmount;
    data['ismcltC_Id'] = this.ismcltCId;
    data['mobilenumber'] = this.mobilenumber;
    data['vpayvoU_PaymentDate'] = this.vpayvoUPaymentDate;
    data['vpayvoU_AppliedAmount'] = this.vpayvoUAppliedAmount;
    data['vpayvoU_ApprovedAmount'] = this.vpayvoUApprovedAmount;
    data['vpayvoU_BankBalalnce'] = this.vpayvoUBankBalalnce;
    data['vpayvoU_ChequePrintedFlg'] = this.vpayvoUChequePrintedFlg;
    data['vpayvoU_SupplierFlg'] = this.vpayvoUSupplierFlg;
    data['imfY_Id'] = this.imfYId;
    data['userId'] = this.userId;
    data['ismcltprP_Year'] = this.ismcltprPYear;
    data['hrmbD_Id'] = this.hrmbDId;
    data['isminC_TotalTaxAmount'] = this.isminCTotalTaxAmount;
    data['isminC_TotalAmount'] = this.isminCTotalAmount;
    data['ismcltprP_ActiveFlag'] = this.ismcltprPActiveFlag;
    data['ismcltprP_CreatedBy'] = this.ismcltprPCreatedBy;
    data['ismcltprP_UpdatedBy'] = this.ismcltprPUpdatedBy;
    data['ismmpR_Id'] = this.ismmpRId;
    data['ismmclT_Id'] = this.ismmclTId;
    data['asmaY_Id'] = this.asmaYId;
    data['duplicate'] = this.duplicate;
    data['returnval'] = this.returnval;
    data['cltprid'] = this.cltprid;
    data['ismcppD_Id'] = this.ismcppDId;
    data['flag'] = this.flag;
    data['ivrmmoD_Id'] = this.ivrmmoDId;
    data['message'] = this.message;
    data['emailotp'] = this.emailotp;
    data['emaiL_Id'] = this.emaiLId;
    data['vcbsrC_Id'] = this.vcbsrCId;
    data['vpayvoU_SelfPayFlg'] = this.vpayvoUSelfPayFlg;
    return data;
  }
}
