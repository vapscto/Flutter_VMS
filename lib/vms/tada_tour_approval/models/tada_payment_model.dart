class TadaPaymentDetailsModel {
  String? type;
  List<TadaPaymentDetailsModelValues>? values;

  TadaPaymentDetailsModel({this.type, this.values});

  TadaPaymentDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <TadaPaymentDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(  TadaPaymentDetailsModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
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
  double? paymentTime;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['TotalAppliedAmount'] = this.totalAppliedAmount;
    data['TotalAppliedAmountByPart'] = this.totalAppliedAmountByPart;
    data['TotalSactionedAmount'] = this.totalSactionedAmount;
    data['TotalSactionedAmountByPart'] = this.totalSactionedAmountByPart;
    data['TotalPaidAmount'] = this.totalPaidAmount;
    data['TotalPaidAmountByPart'] = this.totalPaidAmountByPart;
    data['PaymentTime'] = this.paymentTime;
    data['PaymentMode'] = this.paymentMode;
    data['VTADAAA_Id'] = this.vTADAAAId;
    data['HRME_Id'] = this.hRMEId;
    data['MI_Id'] = this.mIId;
    return data;
  }
}
