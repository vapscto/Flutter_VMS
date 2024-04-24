class TadaGetCategoryModel {
  String? type;
  List<TadaGetCategoryModelValues>? values;

  TadaGetCategoryModel({this.type, this.values});

  TadaGetCategoryModel.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <TadaGetCategoryModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TadaGetCategoryModelValues.fromJson(v));
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

class TadaGetCategoryModelValues {
  String? type;
  int? iMRCCategoryId;
  String? iMRCCategoryName;
  double? iMRCPercentage;
  String? hRMEEmployeeFirstName;
  String? hRMEEmailId;

  TadaGetCategoryModelValues(
      {this.type,
      this.iMRCCategoryId,
      this.iMRCCategoryName,
      this.iMRCPercentage,
      this.hRMEEmployeeFirstName,
      this.hRMEEmailId});

  TadaGetCategoryModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iMRCCategoryId = json['IMRC_CategoryId'];
    iMRCCategoryName = json['IMRC_CategoryName'];
    iMRCPercentage = json['IMRC_Percentage'];
    hRMEEmployeeFirstName = json['HRME_EmployeeFirstName'];
    hRMEEmailId = json['HRME_EmailId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['IMRC_CategoryId'] = iMRCCategoryId;
    data['IMRC_CategoryName'] = iMRCCategoryName;
    data['IMRC_Percentage'] = iMRCPercentage;
    data['HRME_EmployeeFirstName'] = hRMEEmployeeFirstName;
    data['HRME_EmailId'] = hRMEEmailId;
    return data;
  }
}
