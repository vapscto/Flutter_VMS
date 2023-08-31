class TransDetailHisModel {
  String? type;
  List<TransDetailHisModelValues>? values;

  TransDetailHisModel({this.type, this.values});

  TransDetailHisModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TransDetailHisModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TransDetailHisModelValues.fromJson(v));
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

class TransDetailHisModelValues {
  int? amsTId;
  int? mIId;
  int? asmaYId;
  double? amount;
  bool? status;
  String? transId;
  String? fyPPayModeType;
  String? fyPDate;
  String? fmoTPayGatewayType;

  TransDetailHisModelValues(
      {this.amsTId,
      this.mIId,
      this.asmaYId,
      this.amount,
      this.status,
      this.transId,
      this.fyPPayModeType,
      this.fyPDate,
      this.fmoTPayGatewayType});

  TransDetailHisModelValues.fromJson(Map<String, dynamic> json) {
    amsTId = json['amsT_Id'];
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    amount = json['amount'];
    status = json['status'];
    transId = json['trans_id'];
    fyPPayModeType = json['fyP_PayModeType'];
    fyPDate = json['fyP_Date'];
    fmoTPayGatewayType = json['fmoT_PayGatewayType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amsT_Id'] = amsTId;
    data['mI_Id'] = mIId;
    data['asmaY_Id'] = asmaYId;
    data['amount'] = amount;
    data['status'] = status;
    data['trans_id'] = transId;
    data['fyP_PayModeType'] = fyPPayModeType;
    data['fyP_Date'] = fyPDate;
    data['fmoT_PayGatewayType'] = fmoTPayGatewayType;
    return data;
  }
}
