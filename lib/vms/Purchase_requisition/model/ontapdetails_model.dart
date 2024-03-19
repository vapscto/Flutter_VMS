class GetPrDetailModel {
  String? type;
  List<GetPrDetailModelValues>? values;

  GetPrDetailModel({this.type, this.values});

  GetPrDetailModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetPrDetailModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(GetPrDetailModelValues.fromJson(v));
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

class GetPrDetailModelValues {
  bool? returnval;
  bool? alreadyCnt;
  dynamic mIId;
  dynamic mIIdNew;
  dynamic hrmDId;
  dynamic asmaYId;
  dynamic userId;
  dynamic invmIId;
  String? invmIItemName;
  dynamic invmuoMId;
  String? invmuoMUOMName;
  dynamic invmpRId;
  String? invmpRPRNo;
  String? invmpRPRDate;
  String? invmpRRemarks;
  double? invmpRApproxTotAmount;
  bool? invmpRPICreatedFlg;
  bool? invmpRActiveFlg;
  bool? invmpRRejectFlg;
  bool? invtpRRejectFlg;
  dynamic invtpRId;
  dynamic invtpRPRQty;
  dynamic invtpRApproxAmount;
  dynamic invtpRApprovedQty;
  dynamic invtpRPRUnitRate;
  String? invtpRRemarks;
  bool? invtpRActiveFlg;

  GetPrDetailModelValues(
      {this.returnval,
      this.alreadyCnt,
      this.mIId,
      this.mIIdNew,
      this.hrmDId,
      this.asmaYId,
      this.userId,
      this.invmIId,
      this.invmIItemName,
      this.invmuoMId,
      this.invmuoMUOMName,
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
      this.invtpRRemarks,
      this.invtpRActiveFlg});

  GetPrDetailModelValues.fromJson(Map<String, dynamic> json) {
    returnval = json['returnval'];
    alreadyCnt = json['already_cnt'];
    mIId = json['mI_Id'];
    mIIdNew = json['mI_IdNew'];
    hrmDId = json['hrmD_Id'];
    asmaYId = json['asmaY_Id'];
    userId = json['userId'];
    invmIId = json['invmI_Id'];
    invmIItemName = json['invmI_ItemName'];
    invmuoMId = json['invmuoM_Id'];
    invmuoMUOMName = json['invmuoM_UOMName'];
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
    invtpRRemarks = json['invtpR_Remarks'];
    invtpRActiveFlg = json['invtpR_ActiveFlg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['returnval'] = this.returnval;
    data['already_cnt'] = this.alreadyCnt;
    data['mI_Id'] = this.mIId;
    data['mI_IdNew'] = this.mIIdNew;
    data['hrmD_Id'] = this.hrmDId;
    data['asmaY_Id'] = this.asmaYId;
    data['userId'] = this.userId;
    data['invmI_Id'] = this.invmIId;
    data['invmI_ItemName'] = this.invmIItemName;
    data['invmuoM_Id'] = this.invmuoMId;
    data['invmuoM_UOMName'] = this.invmuoMUOMName;
    data['invmpR_Id'] = this.invmpRId;
    data['invmpR_PRNo'] = this.invmpRPRNo;
    data['invmpR_PRDate'] = this.invmpRPRDate;
    data['invmpR_Remarks'] = this.invmpRRemarks;
    data['invmpR_ApproxTotAmount'] = this.invmpRApproxTotAmount;
    data['invmpR_PICreatedFlg'] = this.invmpRPICreatedFlg;
    data['invmpR_ActiveFlg'] = this.invmpRActiveFlg;
    data['invmpR_RejectFlg'] = this.invmpRRejectFlg;
    data['invtpR_RejectFlg'] = this.invtpRRejectFlg;
    data['invtpR_Id'] = this.invtpRId;
    data['invtpR_PRQty'] = this.invtpRPRQty;
    data['invtpR_ApproxAmount'] = this.invtpRApproxAmount;
    data['invtpR_ApprovedQty'] = this.invtpRApprovedQty;
    data['invtpR_PRUnitRate'] = this.invtpRPRUnitRate;
    data['invtpR_Remarks'] = this.invtpRRemarks;
    data['invtpR_ActiveFlg'] = this.invtpRActiveFlg;
    return data;
  }
}
