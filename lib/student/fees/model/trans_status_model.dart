class TransLogResult {
  String? type;
  List<TransLogResultValues>? values;

  TransLogResult({this.type, this.values});

  TransLogResult.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TransLogResultValues>[];
      json['\$values'].forEach((v) {
        values!.add(TransLogResultValues.fromJson(v));
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

class TransLogResultValues {
  String? paymentId;
  String? responsestatuslogs;
  String? orderId;
  String? fyPDate;
  int? fmAAmount;
  String? fyPPayModeType;
  String? fmoTPayGatewayType;

  TransLogResultValues(
      {this.paymentId,
      this.responsestatuslogs,
      this.orderId,
      this.fyPDate,
      this.fmAAmount,
      this.fyPPayModeType,
      this.fmoTPayGatewayType});

  TransLogResultValues.fromJson(Map<String, dynamic> json) {
    paymentId = json['payment_id'];
    responsestatuslogs = json['responsestatuslogs'];
    orderId = json['order_id'];
    fyPDate = json['fyP_Date'];
    fmAAmount = json['fmA_Amount'];
    fyPPayModeType = json['fyP_PayModeType'];
    fmoTPayGatewayType = json['fmoT_PayGatewayType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_id'] = paymentId;
    data['responsestatuslogs'] = responsestatuslogs;
    data['order_id'] = orderId;
    data['fyP_Date'] = fyPDate;
    data['fmA_Amount'] = fmAAmount;
    data['fyP_PayModeType'] = fyPPayModeType;
    data['fmoT_PayGatewayType'] = fmoTPayGatewayType;
    return data;
  }
}
