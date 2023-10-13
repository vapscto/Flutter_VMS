class SalaryDetailsGraph {
  String? type;
  List<SalaryDetailsGraphValues>? values;

  SalaryDetailsGraph({this.type, this.values});

  SalaryDetailsGraph.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <SalaryDetailsGraphValues>[];
      json['\$values'].forEach((v) {
        values!.add(SalaryDetailsGraphValues.fromJson(v));
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

class SalaryDetailsGraphValues {
  String? type;
  String? hRESYear;
  int? iVRMMonthId;
  String? hRESMonth;
  double? earning;
  double? deduction;
  double? lOP;

  SalaryDetailsGraphValues(
      {this.type,
      this.hRESYear,
      this.iVRMMonthId,
      this.hRESMonth,
      this.earning,
      this.deduction,
      this.lOP});

  SalaryDetailsGraphValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRESYear = json['HRES_Year'];
    iVRMMonthId = json['IVRM_Month_Id'];
    hRESMonth = json['HRES_Month'];
    earning = json['Earning'];
    deduction = json['Deduction'];
    lOP = json['LOP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRES_Year'] = hRESYear;
    data['IVRM_Month_Id'] = iVRMMonthId;
    data['HRES_Month'] = hRESMonth;
    data['Earning'] = earning;
    data['Deduction'] = deduction;
    data['LOP'] = lOP;
    return data;
  }
}
