class ApprovalSubmision {
  String? type;
  List<ApprovalSubmisionValues>? values;

  ApprovalSubmision({this.type, this.values});

  ApprovalSubmision.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <ApprovalSubmisionValues>[];
      json['\$values'].forEach((v) {
        values!.add(ApprovalSubmisionValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApprovalSubmisionValues {
  String? type;
  int? iERID;
  double? totalAmt;
  double? sactionedAmt;
  double? eligibleAmt;
  double? eligibleAmtToApply;
  double? salaryCreditAmt;
  double? creditWalletAmount;

  ApprovalSubmisionValues(
      {this.type,
      this.iERID,
      this.totalAmt,
      this.sactionedAmt,
      this.eligibleAmt,
      this.eligibleAmtToApply,
      this.salaryCreditAmt,
      this.creditWalletAmount});

  ApprovalSubmisionValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iERID = json['IER_ID'];
    totalAmt = json['TotalAmt'];
    sactionedAmt = json['SactionedAmt'];
    eligibleAmt = json['EligibleAmt'];
    eligibleAmtToApply = json['EligibleAmtToApply'];
    salaryCreditAmt = json['SalaryCreditAmt'];
    creditWalletAmount = json['CreditWalletAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['IER_ID'] = iERID;
    data['TotalAmt'] = totalAmt;
    data['SactionedAmt'] = sactionedAmt;
    data['EligibleAmt'] = eligibleAmt;
    data['EligibleAmtToApply'] = eligibleAmtToApply;
    data['SalaryCreditAmt'] = salaryCreditAmt;
    data['CreditWalletAmount'] = creditWalletAmount;
    return data;
  }
}
