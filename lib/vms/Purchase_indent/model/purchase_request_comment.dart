class PurchaseRequestModel {
  String? type;
  List<PurchaseRequestModelValues>? values;

  PurchaseRequestModel({this.type, this.values});

  PurchaseRequestModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PurchaseRequestModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(PurchaseRequestModelValues.fromJson(v));
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

class PurchaseRequestModelValues {
  bool? returnval;
  bool? alreadyCnt;
  int? userId;
  int? invtpiapPId;
  int? invmpiapPId;
  int? approvecnt;
  int? hrpaoNSanctionLevelNo;
  int? mIId;
  int? asmaYId;
  int? invmIId;
  int? invmuoMId;
  double? invstOPurchaseRate;
  int? invmpIId;
  String? invmpIPIDate;
  double? invmpIApproxTotAmount;
  bool? invmpIPOCreatedFlg;
  bool? invmpIActiveFlg;
  String? employeename;
  String? invmpRPRNo;
  String? invmpRPRDate;
  String? invmpRRemarks;
  bool? invmpRPICreatedFlg;
  double? invmpRApproxTotAmount;
  int? invtpIId;
  double? invtpIPRQty;
  double? invtpIPIUnitRate;
  double? invtpIApproxAmount;
  double? invtpIPIQty;
  bool? invtpIActiveFlg;
  String? invtpICreatedDate;
  int? invtpICreatedBy;
  bool? prflag;
  String? invmpiapPPIDate;

  PurchaseRequestModelValues(
      {this.returnval,
      this.alreadyCnt,
      this.userId,
      this.invtpiapPId,
      this.invmpiapPId,
      this.approvecnt,
      this.hrpaoNSanctionLevelNo,
      this.mIId,
      this.asmaYId,
      this.invmIId,
      this.invmuoMId,
      this.invstOPurchaseRate,
      this.invmpIId,
      this.invmpIPIDate,
      this.invmpIApproxTotAmount,
      this.invmpIPOCreatedFlg,
      this.invmpIActiveFlg,
      this.employeename,
      this.invmpRPRNo,
      this.invmpRPRDate,
      this.invmpRRemarks,
      this.invmpRPICreatedFlg,
      this.invmpRApproxTotAmount,
      this.invtpIId,
      this.invtpIPRQty,
      this.invtpIPIUnitRate,
      this.invtpIApproxAmount,
      this.invtpIPIQty,
      this.invtpIActiveFlg,
      this.invtpICreatedDate,
      this.invtpICreatedBy,
      this.prflag,
      this.invmpiapPPIDate});

  PurchaseRequestModelValues.fromJson(Map<String, dynamic> json) {
    returnval = json['returnval'];
    alreadyCnt = json['already_cnt'];
    userId = json['userId'];
    invtpiapPId = json['invtpiapP_Id'];
    invmpiapPId = json['invmpiapP_Id'];
    approvecnt = json['approvecnt'];
    hrpaoNSanctionLevelNo = json['hrpaoN_SanctionLevelNo'];
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    invmIId = json['invmI_Id'];
    invmuoMId = json['invmuoM_Id'];
    invstOPurchaseRate = json['invstO_PurchaseRate'];
    invmpIId = json['invmpI_Id'];
    invmpIPIDate = json['invmpI_PIDate'];
    invmpIApproxTotAmount = json['invmpI_ApproxTotAmount'];
    invmpIPOCreatedFlg = json['invmpI_POCreatedFlg'];
    invmpIActiveFlg = json['invmpI_ActiveFlg'];
    employeename = json['employeename'];
    invmpRPRNo = json['invmpR_PRNo'];
    invmpRPRDate = json['invmpR_PRDate'];
    invmpRRemarks = json['invmpR_Remarks'];
    invmpRPICreatedFlg = json['invmpR_PICreatedFlg'];
    invmpRApproxTotAmount = json['invmpR_ApproxTotAmount'];
    invtpIId = json['invtpI_Id'];
    invtpIPRQty = json['invtpI_PRQty'];
    invtpIPIUnitRate = json['invtpI_PIUnitRate'];
    invtpIApproxAmount = json['invtpI_ApproxAmount'];
    invtpIPIQty = json['invtpI_PIQty'];
    invtpIActiveFlg = json['invtpI_ActiveFlg'];
    invtpICreatedDate = json['invtpI_CreatedDate'];
    invtpICreatedBy = json['invtpI_CreatedBy'];
    prflag = json['prflag'];
    invmpiapPPIDate = json['invmpiapP_PIDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['returnval'] = this.returnval;
    data['already_cnt'] = this.alreadyCnt;
    data['userId'] = this.userId;
    data['invtpiapP_Id'] = this.invtpiapPId;
    data['invmpiapP_Id'] = this.invmpiapPId;
    data['approvecnt'] = this.approvecnt;
    data['hrpaoN_SanctionLevelNo'] = this.hrpaoNSanctionLevelNo;
    data['mI_Id'] = this.mIId;
    data['asmaY_Id'] = this.asmaYId;
    data['invmI_Id'] = this.invmIId;
    data['invmuoM_Id'] = this.invmuoMId;
    data['invstO_PurchaseRate'] = this.invstOPurchaseRate;
    data['invmpI_Id'] = this.invmpIId;
    data['invmpI_PIDate'] = this.invmpIPIDate;
    data['invmpI_ApproxTotAmount'] = this.invmpIApproxTotAmount;
    data['invmpI_POCreatedFlg'] = this.invmpIPOCreatedFlg;
    data['invmpI_ActiveFlg'] = this.invmpIActiveFlg;
    data['employeename'] = this.employeename;
    data['invmpR_PRNo'] = this.invmpRPRNo;
    data['invmpR_PRDate'] = this.invmpRPRDate;
    data['invmpR_Remarks'] = this.invmpRRemarks;
    data['invmpR_PICreatedFlg'] = this.invmpRPICreatedFlg;
    data['invmpR_ApproxTotAmount'] = this.invmpRApproxTotAmount;
    data['invtpI_Id'] = this.invtpIId;
    data['invtpI_PRQty'] = this.invtpIPRQty;
    data['invtpI_PIUnitRate'] = this.invtpIPIUnitRate;
    data['invtpI_ApproxAmount'] = this.invtpIApproxAmount;
    data['invtpI_PIQty'] = this.invtpIPIQty;
    data['invtpI_ActiveFlg'] = this.invtpIActiveFlg;
    data['invtpI_CreatedDate'] = this.invtpICreatedDate;
    data['invtpI_CreatedBy'] = this.invtpICreatedBy;
    data['prflag'] = this.prflag;
    data['invmpiapP_PIDate'] = this.invmpiapPPIDate;
    return data;
  }
}
