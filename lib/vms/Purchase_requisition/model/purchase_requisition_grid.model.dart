class PurchaseRequsitionGridModel {
  String? type;
  List<PurchaseRequsitionGridModelValues>? values;

  PurchaseRequsitionGridModel({this.type, this.values});

  PurchaseRequsitionGridModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PurchaseRequsitionGridModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(PurchaseRequsitionGridModelValues.fromJson(v));
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

class PurchaseRequsitionGridModelValues {
  bool? returnval;
  bool? alreadyCnt;
  int? mIId;
  int? mIIdNew;
  int? hrmDId;
  int? asmaYId;
  int? userId;
  int? invmIId;
  int? invmuoMId;
  int? invmpRId;
  String? invmpRPRNo;
  String? invmpRPRDate;
  String? invmpRRemarks;
  double? invmpRApproxTotAmount;
  bool? invmpRPICreatedFlg;
  bool? invmpRActiveFlg;
  bool? invmpRRejectFlg;
  bool? invtpRRejectFlg;
  int? invtpRId;
  double? invtpRPRQty;
  double? invtpRApproxAmount;
  double? invtpRApprovedQty;
  double? invtpRPRUnitRate;
  bool? invtpRActiveFlg;

  PurchaseRequsitionGridModelValues(
      {this.returnval,
      this.alreadyCnt,
      this.mIId,
      this.mIIdNew,
      this.hrmDId,
      this.asmaYId,
      this.userId,
      this.invmIId,
      this.invmuoMId,
      this.invmpRId,
      this.invmpRPRNo,
      this.invmpRPRDate,
      this.invmpRRemarks,
      this.invmpRApproxTotAmount,
      this.invmpRPICreatedFlg,
      this.invmpRActiveFlg,
      this.invmpRRejectFlg,
      this.invtpRRejectFlg,
      this.invtpRId,
      this.invtpRPRQty,
      this.invtpRApproxAmount,
      this.invtpRApprovedQty,
      this.invtpRPRUnitRate,
      this.invtpRActiveFlg});

  PurchaseRequsitionGridModelValues.fromJson(Map<String, dynamic> json) {
    returnval = json['returnval'];
    alreadyCnt = json['already_cnt'];
    mIId = json['mI_Id'];
    mIIdNew = json['mI_IdNew'];
    hrmDId = json['hrmD_Id'];
    asmaYId = json['asmaY_Id'];
    userId = json['userId'];
    invmIId = json['invmI_Id'];
    invmuoMId = json['invmuoM_Id'];
    invmpRId = json['invmpR_Id'];
    invmpRPRNo = json['invmpR_PRNo'];
    invmpRPRDate = json['invmpR_PRDate'];
    invmpRRemarks = json['invmpR_Remarks'];
    invmpRApproxTotAmount = json['invmpR_ApproxTotAmount'];
    invmpRPICreatedFlg = json['invmpR_PICreatedFlg'];
    invmpRActiveFlg = json['invmpR_ActiveFlg'];
    invmpRRejectFlg = json['invmpR_RejectFlg'];
    invtpRRejectFlg = json['invtpR_RejectFlg'];
    invtpRId = json['invtpR_Id'];
    invtpRPRQty = json['invtpR_PRQty'];
    invtpRApproxAmount = json['invtpR_ApproxAmount'];
    invtpRApprovedQty = json['invtpR_ApprovedQty'];
    invtpRPRUnitRate = json['invtpR_PRUnitRate'];
    invtpRActiveFlg = json['invtpR_ActiveFlg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['returnval'] = returnval;
    data['already_cnt'] = alreadyCnt;
    data['mI_Id'] = mIId;
    data['mI_IdNew'] = mIIdNew;
    data['hrmD_Id'] = hrmDId;
    data['asmaY_Id'] = asmaYId;
    data['userId'] = userId;
    data['invmI_Id'] = invmIId;
    data['invmuoM_Id'] = invmuoMId;
    data['invmpR_Id'] = invmpRId;
    data['invmpR_PRNo'] = invmpRPRNo;
    data['invmpR_PRDate'] = invmpRPRDate;
    data['invmpR_Remarks'] = invmpRRemarks;
    data['invmpR_ApproxTotAmount'] = invmpRApproxTotAmount;
    data['invmpR_PICreatedFlg'] = invmpRPICreatedFlg;
    data['invmpR_ActiveFlg'] = invmpRActiveFlg;
    data['invmpR_RejectFlg'] = invmpRRejectFlg;
    data['invtpR_RejectFlg'] = invtpRRejectFlg;
    data['invtpR_Id'] = invtpRId;
    data['invtpR_PRQty'] = invtpRPRQty;
    data['invtpR_ApproxAmount'] = invtpRApproxAmount;
    data['invtpR_ApprovedQty'] = invtpRApprovedQty;
    data['invtpR_PRUnitRate'] = invtpRPRUnitRate;
    data['invtpR_ActiveFlg'] = invtpRActiveFlg;
    return data;
  }
}
