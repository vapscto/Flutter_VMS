class ViewCommentModel {
  String? type;
  List<ViewCommentModelValues>? values;

  ViewCommentModel({this.type, this.values});

  ViewCommentModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ViewCommentModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ViewCommentModelValues.fromJson(v));
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

class ViewCommentModelValues {
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
  String? invmpRPRDate;
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
  String? userName;
  String? invmpiapPRemarks;
  String? invmpiapPPIDate;

  ViewCommentModelValues(
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
      this.invmpRPRDate,
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
      this.userName,
      this.invmpiapPRemarks,
      this.invmpiapPPIDate});

  ViewCommentModelValues.fromJson(Map<String, dynamic> json) {
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
    invmpRPRDate = json['invmpR_PRDate'];
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
    userName = json['userName'];
    invmpiapPRemarks = json['invmpiapP_Remarks'];
    invmpiapPPIDate = json['invmpiapP_PIDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['returnval'] = returnval;
    data['already_cnt'] = alreadyCnt;
    data['userId'] = userId;
    data['invtpiapP_Id'] = invtpiapPId;
    data['invmpiapP_Id'] = invmpiapPId;
    data['approvecnt'] = approvecnt;
    data['hrpaoN_SanctionLevelNo'] = hrpaoNSanctionLevelNo;
    data['mI_Id'] = mIId;
    data['asmaY_Id'] = asmaYId;
    data['invmI_Id'] = invmIId;
    data['invmuoM_Id'] = invmuoMId;
    data['invstO_PurchaseRate'] = invstOPurchaseRate;
    data['invmpI_Id'] = invmpIId;
    data['invmpI_PIDate'] = invmpIPIDate;
    data['invmpI_ApproxTotAmount'] = invmpIApproxTotAmount;
    data['invmpI_POCreatedFlg'] = invmpIPOCreatedFlg;
    data['invmpI_ActiveFlg'] = invmpIActiveFlg;
    data['invmpR_PRDate'] = invmpRPRDate;
    data['invmpR_PICreatedFlg'] = invmpRPICreatedFlg;
    data['invmpR_ApproxTotAmount'] = invmpRApproxTotAmount;
    data['invtpI_Id'] = invtpIId;
    data['invtpI_PRQty'] = invtpIPRQty;
    data['invtpI_PIUnitRate'] = invtpIPIUnitRate;
    data['invtpI_ApproxAmount'] = invtpIApproxAmount;
    data['invtpI_PIQty'] = invtpIPIQty;
    data['invtpI_ActiveFlg'] = invtpIActiveFlg;
    data['invtpI_CreatedDate'] = invtpICreatedDate;
    data['invtpI_CreatedBy'] = invtpICreatedBy;
    data['prflag'] = prflag;
    data['userName'] = userName;
    data['invmpiapP_Remarks'] = invmpiapPRemarks;
    data['invmpiapP_PIDate'] = invmpiapPPIDate;
    return data;
  }
}
