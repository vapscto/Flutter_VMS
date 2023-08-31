class DashboardFeeModel {
  String? type;
  List<DashboardFeeModelValues>? values;

  DashboardFeeModel({this.type, this.values});

  DashboardFeeModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DashboardFeeModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DashboardFeeModelValues.fromJson(v));
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

class DashboardFeeModelValues {
  String? type;
  String? aSMAYYear;
  int? aSMAYId;
  num? fSSPaidAmount;
  num? balance;
  num? concession;
  num? fSSCurrentYrCharges;

  DashboardFeeModelValues(
      {this.type,
      this.aSMAYYear,
      this.aSMAYId,
      this.fSSPaidAmount,
      this.balance,
      this.concession,
      this.fSSCurrentYrCharges});

  DashboardFeeModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    aSMAYYear = json['ASMAY_Year'];
    aSMAYId = json['ASMAY_Id'];
    fSSPaidAmount = json['FSS_PaidAmount'];
    balance = json['balance'];
    concession = json['concession'];
    fSSCurrentYrCharges = json['FSS_CurrentYrCharges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ASMAY_Year'] = aSMAYYear;
    data['ASMAY_Id'] = aSMAYId;
    data['FSS_PaidAmount'] = fSSPaidAmount;
    data['balance'] = balance;
    data['concession'] = concession;
    data['FSS_CurrentYrCharges'] = fSSCurrentYrCharges;
    return data;
  }
}
