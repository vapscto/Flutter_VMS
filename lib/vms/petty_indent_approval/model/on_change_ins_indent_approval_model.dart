
class OnChangeInsIndentApprovalModel {
  String? type;
  List<OnChangeInsIndentApprovalModelValues>? values;

  OnChangeInsIndentApprovalModel({this.type, this.values});

  OnChangeInsIndentApprovalModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <OnChangeInsIndentApprovalModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(OnChangeInsIndentApprovalModelValues.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pcindentaP_Id'] = pcindentaPId;
    data['mI_Id'] = mIId;
    data['hrmE_Id'] = hrmEId;
    data['pcindenT_Id'] = pcindenTId;
    data['pcindentapT_IndentNo'] = pcindentapTIndentNo;
    data['pcindentapT_Date'] = pcindentapTDate;
    data['pcindentapT_RequestedAmount'] = pcindentapTRequestedAmount;
    data['pcindentapT_SanctionedAmt'] = pcindentapTSanctionedAmt;
    data['pcindentapT_ActiveFlg'] = pcindentapTActiveFlg;
    data['pcindentapT_CreatedDate'] = pcindentapTCreatedDate;
    data['pcindentapT_UpdatedDate'] = pcindentapTUpdatedDate;
    data['pcindentapT_CreatedBy'] = pcindentapTCreatedBy;
    data['pcindentapT_UpdatedBy'] = pcindentapTUpdatedBy;
    data['pcindentapT_AmountSpent'] = pcindentapTAmountSpent;
    data['pcindentapT_BalanceAmount'] = pcindentapTBalanceAmount;
    return data;
  }
}
