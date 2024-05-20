class TadaPaymentDetailsModel {
  String? type;
  List<TadaPaymentDetailsModelValues>? values;

  TadaPaymentDetailsModel({this.type, this.values});

  TadaPaymentDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <TadaPaymentDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TadaPaymentDetailsModelValues.fromJson(v));
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

class TadaPaymentDetailsModelValues {
  String? type;
  double? totalAppliedAmount;
  double? totalAppliedAmountByPart;
  double? totalSactionedAmount;
  double? totalSactionedAmountByPart;
  double? totalPaidAmount;
  double? totalPaidAmountByPart;
  int? paymentTime;
  String? paymentMode;
  int? vTADAAAId;
  int? hRMEId;
  int? mIId;

  TadaPaymentDetailsModelValues(
      {this.type,
      this.totalAppliedAmount,
      this.totalAppliedAmountByPart,
      this.totalSactionedAmount,
      this.totalSactionedAmountByPart,
      this.totalPaidAmount,
      this.totalPaidAmountByPart,
      this.paymentTime,
      this.paymentMode,
      this.vTADAAAId,
      this.hRMEId,
      this.mIId});

  TadaPaymentDetailsModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    totalAppliedAmount = json['TotalAppliedAmount'];
    totalAppliedAmountByPart = json['TotalAppliedAmountByPart'];
    totalSactionedAmount = json['TotalSactionedAmount'];
    totalSactionedAmountByPart = json['TotalSactionedAmountByPart'];
    totalPaidAmount = json['TotalPaidAmount'];
    totalPaidAmountByPart = json['TotalPaidAmountByPart'];
    paymentTime = json['PaymentTime'];
    paymentMode = json['PaymentMode'];
    vTADAAAId = json['VTADAAA_Id'];
    hRMEId = json['HRME_Id'];
    mIId = json['MI_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['TotalAppliedAmount'] = totalAppliedAmount;
    data['TotalAppliedAmountByPart'] = totalAppliedAmountByPart;
    data['TotalSactionedAmount'] = totalSactionedAmount;
    data['TotalSactionedAmountByPart'] = totalSactionedAmountByPart;
    data['TotalPaidAmount'] = totalPaidAmount;
    data['TotalPaidAmountByPart'] = totalPaidAmountByPart;
    data['PaymentTime'] = paymentTime;
    data['PaymentMode'] = paymentMode;
    data['VTADAAA_Id'] = vTADAAAId;
    data['HRME_Id'] = hRMEId;
    data['MI_Id'] = mIId;
    return data;
  }
}
