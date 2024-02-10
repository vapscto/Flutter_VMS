class GetTaDaModel {
  String? type;
  List<GetTaDaModelValues>? values;

  GetTaDaModel({this.type, this.values});

  GetTaDaModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != String) {
      values = <GetTaDaModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(GetTaDaModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    // ignore: unrelated_type_equality_checks
    if (values != String) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetTaDaModelValues {
  String? type;
  int? mIId;
  String? mIName;
  int? vPAYVOUId;
  int? iNVMSId;
  String? vPAYVOUPaymentDate;
  String? vPAYVOURemarks;
  double? vPAYVOUAppliedAmount;
  double? vPAYVOUApprovedAmount;
  String? iNVMPIApproxTotAmount;
  double? vPAYVOUBankBalalnce;
  String? vPAYVOUStatusFlg;
  int? userId;
  int? sanctionLevelNo;
  String? iNVMSSupplierName;
  String? iNVMSSupplierCode;
  String? iNVMSSupplierConatctPerson;
  int? iNVMSSupplierConatctNo;
  String? iNVMSEmailId;
  String? iNVMSSupplierAddress;
  String? hRMBDBankName;
  String? hRMBDBankAccountNo;
  String? hRMBDBankAddress;
  String? hRMBDBranchName;
  String? hRMBDIFSCCode;
  String? vPAYVOUVoucherNo;
  int? hRMBDId;
  String? vPAYVOUChequeNo;
  String? createdby;
  String? mILogo;
  String? vPAYVOUTDS;
  String? vPAYVOUPenalty;
  String? vPAYVOUToSupplierFlg;
  String? vPAYVOUPaymentTo;
  String? vPAYVOUESICAmount;
  String? vPAYVOUOtherAmount;
  String? vPAYVOUPaymentMode;
  String? vPAYVOUPaymentReference;
  bool? hRMBDInterbankTransFlg;
  int? vPAYVOUHRMBDId;

  GetTaDaModelValues(
      {this.type,
      this.mIId,
      this.mIName,
      this.vPAYVOUId,
      this.iNVMSId,
      this.vPAYVOUPaymentDate,
      this.vPAYVOURemarks,
      this.vPAYVOUAppliedAmount,
      this.vPAYVOUApprovedAmount,
      this.iNVMPIApproxTotAmount,
      this.vPAYVOUBankBalalnce,
      this.vPAYVOUStatusFlg,
      this.userId,
      this.sanctionLevelNo,
      this.iNVMSSupplierName,
      this.iNVMSSupplierCode,
      this.iNVMSSupplierConatctPerson,
      this.iNVMSSupplierConatctNo,
      this.iNVMSEmailId,
      this.iNVMSSupplierAddress,
      this.hRMBDBankName,
      this.hRMBDBankAccountNo,
      this.hRMBDBankAddress,
      this.hRMBDBranchName,
      this.hRMBDIFSCCode,
      this.vPAYVOUVoucherNo,
      this.hRMBDId,
      this.vPAYVOUChequeNo,
      this.createdby,
      this.mILogo,
      this.vPAYVOUTDS,
      this.vPAYVOUPenalty,
      this.vPAYVOUToSupplierFlg,
      this.vPAYVOUPaymentTo,
      this.vPAYVOUESICAmount,
      this.vPAYVOUOtherAmount,
      this.vPAYVOUPaymentMode,
      this.vPAYVOUPaymentReference,
      this.hRMBDInterbankTransFlg,
      this.vPAYVOUHRMBDId});

  GetTaDaModelValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    mIId = json['MI_Id'];
    mIName = json['MI_Name'];
    vPAYVOUId = json['VPAYVOU_Id'];
    iNVMSId = json['INVMS_Id'];
    vPAYVOUPaymentDate = json['VPAYVOU_PaymentDate'];
    vPAYVOURemarks = json['VPAYVOU_Remarks'];
    vPAYVOUAppliedAmount = json['VPAYVOU_AppliedAmount'];
    vPAYVOUApprovedAmount = json['VPAYVOU_ApprovedAmount'];
    iNVMPIApproxTotAmount = json['INVMPI_ApproxTotAmount'];
    vPAYVOUBankBalalnce = json['VPAYVOU_BankBalalnce'];
    vPAYVOUStatusFlg = json['VPAYVOU_StatusFlg'];
    userId = json['User_Id'];
    sanctionLevelNo = json['SanctionLevelNo'];
    iNVMSSupplierName = json['INVMS_SupplierName'];
    iNVMSSupplierCode = json['INVMS_SupplierCode'];
    iNVMSSupplierConatctPerson = json['INVMS_SupplierConatctPerson'];
    iNVMSSupplierConatctNo = json['INVMS_SupplierConatctNo'];
    iNVMSEmailId = json['INVMS_EmailId'];
    iNVMSSupplierAddress = json['INVMS_SupplierAddress'];
    hRMBDBankName = json['HRMBD_BankName'];
    hRMBDBankAccountNo = json['HRMBD_BankAccountNo'];
    hRMBDBankAddress = json['HRMBD_BankAddress'];
    hRMBDBranchName = json['HRMBD_BranchName'];
    hRMBDIFSCCode = json['HRMBD_IFSCCode'];
    vPAYVOUVoucherNo = json['VPAYVOU_VoucherNo'];
    hRMBDId = json['HRMBD_Id'];
    vPAYVOUChequeNo = json['VPAYVOU_ChequeNo'];
    createdby = json['createdby'];
    mILogo = json['MI_Logo'];
    vPAYVOUTDS = json['VPAYVOU_TDS'];
    vPAYVOUPenalty = json['VPAYVOU_Penalty'];
    vPAYVOUToSupplierFlg = json['VPAYVOU_ToSupplierFlg'];
    vPAYVOUPaymentTo = json['VPAYVOU_PaymentTo'];
    vPAYVOUESICAmount = json['VPAYVOU_ESICAmount'];
    vPAYVOUOtherAmount = json['VPAYVOU_OtherAmount'];
    vPAYVOUPaymentMode = json['VPAYVOU_PaymentMode'];
    vPAYVOUPaymentReference = json['VPAYVOU_PaymentReference'];
    hRMBDInterbankTransFlg = json['HRMBD_InterbankTransFlg'];
    vPAYVOUHRMBDId = json['VPAYVOU_HRMBD_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    data['MI_Id'] = mIId;
    data['MI_Name'] = mIName;
    data['VPAYVOU_Id'] = vPAYVOUId;
    data['INVMS_Id'] = iNVMSId;
    data['VPAYVOU_PaymentDate'] = vPAYVOUPaymentDate;
    data['VPAYVOU_Remarks'] = vPAYVOURemarks;
    data['VPAYVOU_AppliedAmount'] = vPAYVOUAppliedAmount;
    data['VPAYVOU_ApprovedAmount'] = vPAYVOUApprovedAmount;
    data['INVMPI_ApproxTotAmount'] = iNVMPIApproxTotAmount;
    data['VPAYVOU_BankBalalnce'] = vPAYVOUBankBalalnce;
    data['VPAYVOU_StatusFlg'] = vPAYVOUStatusFlg;
    data['User_Id'] = userId;
    data['SanctionLevelNo'] = sanctionLevelNo;
    data['INVMS_SupplierName'] = iNVMSSupplierName;
    data['INVMS_SupplierCode'] = iNVMSSupplierCode;
    data['INVMS_SupplierConatctPerson'] = iNVMSSupplierConatctPerson;
    data['INVMS_SupplierConatctNo'] = iNVMSSupplierConatctNo;
    data['INVMS_EmailId'] = iNVMSEmailId;
    data['INVMS_SupplierAddress'] = iNVMSSupplierAddress;
    data['HRMBD_BankName'] = hRMBDBankName;
    data['HRMBD_BankAccountNo'] = hRMBDBankAccountNo;
    data['HRMBD_BankAddress'] = hRMBDBankAddress;
    data['HRMBD_BranchName'] = hRMBDBranchName;
    data['HRMBD_IFSCCode'] = hRMBDIFSCCode;
    data['VPAYVOU_VoucherNo'] = vPAYVOUVoucherNo;
    data['HRMBD_Id'] = hRMBDId;
    data['VPAYVOU_ChequeNo'] = vPAYVOUChequeNo;
    data['createdby'] = createdby;
    data['MI_Logo'] = mILogo;
    data['VPAYVOU_TDS'] = vPAYVOUTDS;
    data['VPAYVOU_Penalty'] = vPAYVOUPenalty;
    data['VPAYVOU_ToSupplierFlg'] = vPAYVOUToSupplierFlg;
    data['VPAYVOU_PaymentTo'] = vPAYVOUPaymentTo;
    data['VPAYVOU_ESICAmount'] = vPAYVOUESICAmount;
    data['VPAYVOU_OtherAmount'] = vPAYVOUOtherAmount;
    data['VPAYVOU_PaymentMode'] = vPAYVOUPaymentMode;
    data['VPAYVOU_PaymentReference'] = vPAYVOUPaymentReference;
    data['HRMBD_InterbankTransFlg'] = hRMBDInterbankTransFlg;
    data['VPAYVOU_HRMBD_Id'] = vPAYVOUHRMBDId;
    return data;
  }
}
