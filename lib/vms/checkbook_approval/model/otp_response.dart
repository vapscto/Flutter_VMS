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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ismcltprP_Id'] = ismcltprPId;
    data['hrpaoN_SanctionLevelNo'] = hrpaoNSanctionLevelNo;
    data['ismmcltpR_Id'] = ismmcltpRId;
    data['vmchebkslN_Id'] = vmchebkslNId;
    data['ivrmuL_Id'] = ivrmuLId;
    data['vpayvoU_Id'] = vpayvoUId;
    data['mI_Id'] = mIId;
    data['vbabrS_Id'] = vbabrSId;
    data['fmI_Id'] = fmIId;
    data['ismcltprboM_Qty'] = ismcltprboMQty;
    data['isminC_AdvPer'] = isminCAdvPer;
    data['isminC_AdvanceAmount'] = isminCAdvanceAmount;
    data['ismcltC_Id'] = ismcltCId;
    data['mobilenumber'] = mobilenumber;
    data['vpayvoU_PaymentDate'] = vpayvoUPaymentDate;
    data['vpayvoU_AppliedAmount'] = vpayvoUAppliedAmount;
    data['vpayvoU_ApprovedAmount'] = vpayvoUApprovedAmount;
    data['vpayvoU_BankBalalnce'] = vpayvoUBankBalalnce;
    data['vpayvoU_ChequePrintedFlg'] = vpayvoUChequePrintedFlg;
    data['vpayvoU_SupplierFlg'] = vpayvoUSupplierFlg;
    data['imfY_Id'] = imfYId;
    data['userId'] = userId;
    data['ismcltprP_Year'] = ismcltprPYear;
    data['hrmbD_Id'] = hrmbDId;
    data['isminC_TotalTaxAmount'] = isminCTotalTaxAmount;
    data['isminC_TotalAmount'] = isminCTotalAmount;
    data['ismcltprP_ActiveFlag'] = ismcltprPActiveFlag;
    data['ismcltprP_CreatedBy'] = ismcltprPCreatedBy;
    data['ismcltprP_UpdatedBy'] = ismcltprPUpdatedBy;
    data['ismmpR_Id'] = ismmpRId;
    data['ismmclT_Id'] = ismmclTId;
    data['asmaY_Id'] = asmaYId;
    data['duplicate'] = duplicate;
    data['returnval'] = returnval;
    data['cltprid'] = cltprid;
    data['ismcppD_Id'] = ismcppDId;
    data['flag'] = flag;
    data['ivrmmoD_Id'] = ivrmmoDId;
    data['message'] = message;
    data['emailotp'] = emailotp;
    data['emaiL_Id'] = emaiLId;
    data['vcbsrC_Id'] = vcbsrCId;
    data['vpayvoU_SelfPayFlg'] = vpayvoUSelfPayFlg;
    return data;
  }
}
