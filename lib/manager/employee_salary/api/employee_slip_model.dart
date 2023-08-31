class EmployeeSalarySlipModel {
  String? type;
  List<EmployeeSalarySlipValues>? values;

  EmployeeSalarySlipModel({this.type, this.values});

  EmployeeSalarySlipModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <EmployeeSalarySlipValues>[];
      json['\$values'].forEach((v) {
        values!.add(EmployeeSalarySlipValues.fromJson(v));
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

class EmployeeSalarySlipValues {
  String? type;
  num? mIId;
  num? hRMEId;
  String? hRESYear;
  String? hRESMonth;
  num? hRMEDId;
  String? hRMEDEarnDedFlag;
  String? hRMEDAmountPercentFlag;
  String? hRMEDEDTypeFlag;
  String? hRMEDName;
  num? amount;
  num? hRMEDOrder;

  EmployeeSalarySlipValues(
      {this.type,
      this.mIId,
      this.hRMEId,
      this.hRESYear,
      this.hRESMonth,
      this.hRMEDId,
      this.hRMEDEarnDedFlag,
      this.hRMEDAmountPercentFlag,
      this.hRMEDEDTypeFlag,
      this.hRMEDName,
      this.amount,
      this.hRMEDOrder});

  EmployeeSalarySlipValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    mIId = json['MI_Id'];
    hRMEId = json['HRME_Id'];
    hRESYear = json['HRES_Year'];
    hRESMonth = json['HRES_Month'];
    hRMEDId = json['HRMED_Id'];
    hRMEDEarnDedFlag = json['HRMED_EarnDedFlag'];
    hRMEDAmountPercentFlag = json['HRMED_AmountPercentFlag'];
    hRMEDEDTypeFlag = json['HRMED_EDTypeFlag'];
    hRMEDName = json['HRMED_Name'];
    amount = json['Amount'];
    hRMEDOrder = json['HRMED_Order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['MI_Id'] = mIId;
    data['HRME_Id'] = hRMEId;
    data['HRES_Year'] = hRESYear;
    data['HRES_Month'] = hRESMonth;
    data['HRMED_Id'] = hRMEDId;
    data['HRMED_EarnDedFlag'] = hRMEDEarnDedFlag;
    data['HRMED_AmountPercentFlag'] = hRMEDAmountPercentFlag;
    data['HRMED_EDTypeFlag'] = hRMEDEDTypeFlag;
    data['HRMED_Name'] = hRMEDName;
    data['Amount'] = amount;
    data['HRMED_Order'] = hRMEDOrder;
    return data;
  }
}
