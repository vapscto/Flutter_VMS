class OnChangeInsIndentApprovalModel {
  String? type;
  List<OnChangeInsIndentApprovalModelValues>? values;

  OnChangeInsIndentApprovalModel({this.type, this.values});

  OnChangeInsIndentApprovalModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <OnChangeInsIndentApprovalModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new OnChangeInsIndentApprovalModelValues.fromJson(v));
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

class OnChangeInsIndentApprovalModelValues {
  int? pcindentaPId;
  int? mIId;
  int? hrmEId;
  int? pcindenTId;
  String? pcindentapTIndentNo;
  String? pcindentapTDate;
  double? pcindentapTRequestedAmount;
  double? pcindentapTSanctionedAmt;
  bool? pcindentapTActiveFlg;
  String? pcindentapTCreatedDate;
  String? pcindentapTUpdatedDate;
  int? pcindentapTCreatedBy;
  int? pcindentapTUpdatedBy;
  double? pcindentapTAmountSpent;
  double? pcindentapTBalanceAmount;

  OnChangeInsIndentApprovalModelValues(
      {this.pcindentaPId,
      this.mIId,
      this.hrmEId,
      this.pcindenTId,
      this.pcindentapTIndentNo,
      this.pcindentapTDate,
      this.pcindentapTRequestedAmount,
      this.pcindentapTSanctionedAmt,
      this.pcindentapTActiveFlg,
      this.pcindentapTCreatedDate,
      this.pcindentapTUpdatedDate,
      this.pcindentapTCreatedBy,
      this.pcindentapTUpdatedBy,
      this.pcindentapTAmountSpent,
      this.pcindentapTBalanceAmount});

  OnChangeInsIndentApprovalModelValues.fromJson(Map<String, dynamic> json) {
    pcindentaPId = json['pcindentaP_Id'];
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    pcindenTId = json['pcindenT_Id'];
    pcindentapTIndentNo = json['pcindentapT_IndentNo'];
    pcindentapTDate = json['pcindentapT_Date'];
    pcindentapTRequestedAmount = json['pcindentapT_RequestedAmount'];
    pcindentapTSanctionedAmt = json['pcindentapT_SanctionedAmt'];
    pcindentapTActiveFlg = json['pcindentapT_ActiveFlg'];
    pcindentapTCreatedDate = json['pcindentapT_CreatedDate'];
    pcindentapTUpdatedDate = json['pcindentapT_UpdatedDate'];
    pcindentapTCreatedBy = json['pcindentapT_CreatedBy'];
    pcindentapTUpdatedBy = json['pcindentapT_UpdatedBy'];
    pcindentapTAmountSpent = json['pcindentapT_AmountSpent'];
    pcindentapTBalanceAmount = json['pcindentapT_BalanceAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pcindentaP_Id'] = this.pcindentaPId;
    data['mI_Id'] = this.mIId;
    data['hrmE_Id'] = this.hrmEId;
    data['pcindenT_Id'] = this.pcindenTId;
    data['pcindentapT_IndentNo'] = this.pcindentapTIndentNo;
    data['pcindentapT_Date'] = this.pcindentapTDate;
    data['pcindentapT_RequestedAmount'] = this.pcindentapTRequestedAmount;
    data['pcindentapT_SanctionedAmt'] = this.pcindentapTSanctionedAmt;
    data['pcindentapT_ActiveFlg'] = this.pcindentapTActiveFlg;
    data['pcindentapT_CreatedDate'] = this.pcindentapTCreatedDate;
    data['pcindentapT_UpdatedDate'] = this.pcindentapTUpdatedDate;
    data['pcindentapT_CreatedBy'] = this.pcindentapTCreatedBy;
    data['pcindentapT_UpdatedBy'] = this.pcindentapTUpdatedBy;
    data['pcindentapT_AmountSpent'] = this.pcindentapTAmountSpent;
    data['pcindentapT_BalanceAmount'] = this.pcindentapTBalanceAmount;
    return data;
  }
}
