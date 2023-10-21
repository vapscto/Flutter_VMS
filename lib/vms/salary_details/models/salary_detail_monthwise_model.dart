class SalaryDetailsMonthwise {
  String? type;
  List<SalaryDetailsMonthwiseValues>? values;

  SalaryDetailsMonthwise({this.type, this.values});

  SalaryDetailsMonthwise.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <SalaryDetailsMonthwiseValues>[];
      json['\$values'].forEach((v) {
        values!.add(SalaryDetailsMonthwiseValues.fromJson(v));
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

class SalaryDetailsMonthwiseValues {
  String? type;
  double? salary;
  int? ivrMMonthId;
  String? monthName;
  int? hresId;
  String? hreSYear;

  SalaryDetailsMonthwiseValues(
      {this.type,
      this.salary,
      this.ivrMMonthId,
      this.monthName,
      this.hresId,
      this.hreSYear});

  SalaryDetailsMonthwiseValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    salary = json['salary'];
    ivrMMonthId = json['ivrM_Month_Id'];
    monthName = json['monthName'];
    hresId = json['hres_id'];
    hreSYear = json['hreS_Year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['salary'] = salary;
    data['ivrM_Month_Id'] = ivrMMonthId;
    data['monthName'] = monthName;
    data['hres_id'] = hresId;
    data['hreS_Year'] = hreSYear;
    return data;
  }
}
