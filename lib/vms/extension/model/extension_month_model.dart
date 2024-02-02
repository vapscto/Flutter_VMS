class ExtensionMonthModel {
  String? type;
  List<ExtensionMonthModelValues>? values;

  ExtensionMonthModel({this.type, this.values});

  ExtensionMonthModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ExtensionMonthModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ExtensionMonthModelValues.fromJson(v));
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

class ExtensionMonthModelValues {
  int? ivrMMonthId;
  String? ivrMMonthName;
  bool? isActive;
  int? ivrMMonthMaxDays;
  String? createdDate;
  String? updatedDate;

  ExtensionMonthModelValues(
      {this.ivrMMonthId,
      this.ivrMMonthName,
      this.isActive,
      this.ivrMMonthMaxDays,
      this.createdDate,
      this.updatedDate});

  ExtensionMonthModelValues.fromJson(Map<String, dynamic> json) {
    ivrMMonthId = json['ivrM_Month_Id'];
    ivrMMonthName = json['ivrM_Month_Name'];
    isActive = json['is_Active'];
    ivrMMonthMaxDays = json['ivrM_Month_Max_Days'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ivrM_Month_Id'] = ivrMMonthId;
    data['ivrM_Month_Name'] = ivrMMonthName;
    data['is_Active'] = isActive;
    data['ivrM_Month_Max_Days'] = ivrMMonthMaxDays;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
