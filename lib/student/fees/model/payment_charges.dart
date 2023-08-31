class PaymentCharges {
  String? type;
  List<PaymentChargesValues>? values;

  PaymentCharges({this.type, this.values});

  PaymentCharges.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PaymentChargesValues>[];
      json['\$values'].forEach((v) {
        values!.add(PaymentChargesValues.fromJson(v));
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

class PaymentChargesValues {
  String? type;
  int? fPGRId;
  int? mIId;
  int? iMPGId;
  double? fPGRRate;
  String? fPGRCreatedDate;
  String? fPGRUpdatedDate;
  String? fPGRCreatedBy;
  String? fPGRUpdatedBy;
  String? fPGRCardType;
  String? fPGRCardNetworkType;
  double? fPGRUpToAmount;
  double? fPGRLessthanOrGreatherThan;
  double? fPGRInstitutionRate;
  double? fPGRVAPSRate;

  PaymentChargesValues(
      {this.type,
      this.fPGRId,
      this.mIId,
      this.iMPGId,
      this.fPGRRate,
      this.fPGRCreatedDate,
      this.fPGRUpdatedDate,
      this.fPGRCreatedBy,
      this.fPGRUpdatedBy,
      this.fPGRCardType,
      this.fPGRCardNetworkType,
      this.fPGRUpToAmount,
      this.fPGRLessthanOrGreatherThan,
      this.fPGRInstitutionRate,
      this.fPGRVAPSRate});

  PaymentChargesValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    fPGRId = json['FPGR_Id'];
    mIId = json['MI_Id'];
    iMPGId = json['IMPG_Id'];
    fPGRRate = json['FPGR_Rate'];
    fPGRCreatedDate = json['FPGR_CreatedDate'];
    fPGRUpdatedDate = json['FPGR_UpdatedDate'];
    fPGRCreatedBy = json['FPGR_CreatedBy'];
    fPGRUpdatedBy = json['FPGR_UpdatedBy'];
    fPGRCardType = json['FPGR_CardType'];
    fPGRCardNetworkType = json['FPGR_CardNetworkType'];
    fPGRUpToAmount = json['FPGR_UpToAmount'];
    fPGRLessthanOrGreatherThan = json['FPGR_LessthanOrGreatherThan'];
    fPGRInstitutionRate = json['FPGR_InstitutionRate'];
    fPGRVAPSRate = json['FPGR_VAPSRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['FPGR_Id'] = fPGRId;
    data['MI_Id'] = mIId;
    data['IMPG_Id'] = iMPGId;
    data['FPGR_Rate'] = fPGRRate;
    data['FPGR_CreatedDate'] = fPGRCreatedDate;
    data['FPGR_UpdatedDate'] = fPGRUpdatedDate;
    data['FPGR_CreatedBy'] = fPGRCreatedBy;
    data['FPGR_UpdatedBy'] = fPGRUpdatedBy;
    data['FPGR_CardType'] = fPGRCardType;
    data['FPGR_CardNetworkType'] = fPGRCardNetworkType;
    data['FPGR_UpToAmount'] = fPGRUpToAmount;
    data['FPGR_LessthanOrGreatherThan'] = fPGRLessthanOrGreatherThan;
    data['FPGR_InstitutionRate'] = fPGRInstitutionRate;
    data['FPGR_VAPSRate'] = fPGRVAPSRate;
    return data;
  }
}
