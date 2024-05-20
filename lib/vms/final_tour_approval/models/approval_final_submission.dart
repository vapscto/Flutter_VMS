class ApprovalSubmision {
  String? type;
  List<ApprovalSubmisionValues>? values;

  ApprovalSubmision({this.type, this.values});

  ApprovalSubmision.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <ApprovalSubmisionValues>[];
      json['\$values'].forEach((v) {
        values!.add(new ApprovalSubmisionValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['IER_ID'] = this.iERID;
    data['TotalAmt'] = this.totalAmt;
    data['SactionedAmt'] = this.sactionedAmt;
    data['EligibleAmt'] = this.eligibleAmt;
    data['EligibleAmtToApply'] = this.eligibleAmtToApply;
    data['SalaryCreditAmt'] = this.salaryCreditAmt;
    data['CreditWalletAmount'] = this.creditWalletAmount;
    return data;
  }
}
