class GetTaDaModel {
  String? type;
  List<GetTaDaModelValues>? values;

  GetTaDaModel({this.type, this.values});

  GetTaDaModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != String) {
      values = <GetTaDaModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(  GetTaDaModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    if (this.values != String) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    data['MI_Id'] = this.mIId;
    data['MI_Name'] = this.mIName;
    data['VPAYVOU_Id'] = this.vPAYVOUId;
    data['INVMS_Id'] = this.iNVMSId;
    data['VPAYVOU_PaymentDate'] = this.vPAYVOUPaymentDate;
    data['VPAYVOU_Remarks'] = this.vPAYVOURemarks;
    data['VPAYVOU_AppliedAmount'] = this.vPAYVOUAppliedAmount;
    data['VPAYVOU_ApprovedAmount'] = this.vPAYVOUApprovedAmount;
    data['INVMPI_ApproxTotAmount'] = this.iNVMPIApproxTotAmount;
    data['VPAYVOU_BankBalalnce'] = this.vPAYVOUBankBalalnce;
    data['VPAYVOU_StatusFlg'] = this.vPAYVOUStatusFlg;
    data['User_Id'] = this.userId;
    data['SanctionLevelNo'] = this.sanctionLevelNo;
    data['INVMS_SupplierName'] = this.iNVMSSupplierName;
    data['INVMS_SupplierCode'] = this.iNVMSSupplierCode;
    data['INVMS_SupplierConatctPerson'] = this.iNVMSSupplierConatctPerson;
    data['INVMS_SupplierConatctNo'] = this.iNVMSSupplierConatctNo;
    data['INVMS_EmailId'] = this.iNVMSEmailId;
    data['INVMS_SupplierAddress'] = this.iNVMSSupplierAddress;
    data['HRMBD_BankName'] = this.hRMBDBankName;
    data['HRMBD_BankAccountNo'] = this.hRMBDBankAccountNo;
    data['HRMBD_BankAddress'] = this.hRMBDBankAddress;
    data['HRMBD_BranchName'] = this.hRMBDBranchName;
    data['HRMBD_IFSCCode'] = this.hRMBDIFSCCode;
    data['VPAYVOU_VoucherNo'] = this.vPAYVOUVoucherNo;
    data['HRMBD_Id'] = this.hRMBDId;
    data['VPAYVOU_ChequeNo'] = this.vPAYVOUChequeNo;
    data['createdby'] = this.createdby;
    data['MI_Logo'] = this.mILogo;
    data['VPAYVOU_TDS'] = this.vPAYVOUTDS;
    data['VPAYVOU_Penalty'] = this.vPAYVOUPenalty;
    data['VPAYVOU_ToSupplierFlg'] = this.vPAYVOUToSupplierFlg;
    data['VPAYVOU_PaymentTo'] = this.vPAYVOUPaymentTo;
    data['VPAYVOU_ESICAmount'] = this.vPAYVOUESICAmount;
    data['VPAYVOU_OtherAmount'] = this.vPAYVOUOtherAmount;
    data['VPAYVOU_PaymentMode'] = this.vPAYVOUPaymentMode;
    data['VPAYVOU_PaymentReference'] = this.vPAYVOUPaymentReference;
    data['HRMBD_InterbankTransFlg'] = this.hRMBDInterbankTransFlg;
    data['VPAYVOU_HRMBD_Id'] = this.vPAYVOUHRMBDId;
    return data;
  }
}
