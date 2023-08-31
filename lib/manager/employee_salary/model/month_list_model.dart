class MonthDorpdownModel {
  String? type;
  List<MonthDorpdownValues>? values;

  MonthDorpdownModel({this.type, this.values});

  MonthDorpdownModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <MonthDorpdownValues>[];
      json['\$values'].forEach((v) {
        values!.add(MonthDorpdownValues.fromJson(v));
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

class MonthDorpdownValues {
  int? ivrMMonthId;
  String? ivrMMonthName;
  bool? isActive;
  int? ivrMMonthMaxDays;

  MonthDorpdownValues(
      {this.ivrMMonthId,
      this.ivrMMonthName,
      this.isActive,
      this.ivrMMonthMaxDays});

  MonthDorpdownValues.fromJson(Map<String, dynamic> json) {
    ivrMMonthId = json['ivrM_Month_Id'];
    ivrMMonthName = json['ivrM_Month_Name'];
    isActive = json['is_Active'];
    ivrMMonthMaxDays = json['ivrM_Month_Max_Days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ivrM_Month_Id'] = ivrMMonthId;
    data['ivrM_Month_Name'] = ivrMMonthName;
    data['is_Active'] = isActive;
    data['ivrM_Month_Max_Days'] = ivrMMonthMaxDays;
    return data;
  }
}
