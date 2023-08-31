class ManagerClassModel {
  String? type;
  List<ManagerClassModelValues>? values;

  ManagerClassModel({this.type, this.values});

  ManagerClassModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ManagerClassModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ManagerClassModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    if (values != null) {
      data['$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ManagerClassModelValues {
  int? asmcLId;
  int? mIId;
  String? asmcLClassName;
  int? asmcLMinAgeYear;
  int? asmcLMinAgeMonth;
  int? asmcLMinAgeDays;
  int? asmcLMaxAgeYear;
  int? asmcLMaxAgeMonth;
  int? asmcLMaxAgeDays;
  int? asmcLOrder;
  String? asmcLClassCode;
  bool? asmcLActiveFlag;
  int? asmcLMaxCapacity;
  int? asmcLPreadmFlag;
  String? createdDate;
  String? updatedDate;

  ManagerClassModelValues(
      {this.asmcLId,
      this.mIId,
      this.asmcLClassName,
      this.asmcLMinAgeYear,
      this.asmcLMinAgeMonth,
      this.asmcLMinAgeDays,
      this.asmcLMaxAgeYear,
      this.asmcLMaxAgeMonth,
      this.asmcLMaxAgeDays,
      this.asmcLOrder,
      this.asmcLClassCode,
      this.asmcLActiveFlag,
      this.asmcLMaxCapacity,
      this.asmcLPreadmFlag,
      this.createdDate,
      this.updatedDate});

  ManagerClassModelValues.fromJson(Map<String, dynamic> json) {
    asmcLId = json['asmcL_Id'];
    mIId = json['mI_Id'];
    asmcLClassName = json['asmcL_ClassName'];
    asmcLMinAgeYear = json['asmcL_MinAgeYear'];
    asmcLMinAgeMonth = json['asmcL_MinAgeMonth'];
    asmcLMinAgeDays = json['asmcL_MinAgeDays'];
    asmcLMaxAgeYear = json['asmcL_MaxAgeYear'];
    asmcLMaxAgeMonth = json['asmcL_MaxAgeMonth'];
    asmcLMaxAgeDays = json['asmcL_MaxAgeDays'];
    asmcLOrder = json['asmcL_Order'];
    asmcLClassCode = json['asmcL_ClassCode'];
    asmcLActiveFlag = json['asmcL_ActiveFlag'];
    asmcLMaxCapacity = json['asmcL_MaxCapacity'];
    asmcLPreadmFlag = json['asmcL_PreadmFlag'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['asmcL_Id'] = asmcLId;
    data['mI_Id'] = mIId;
    data['asmcL_ClassName'] = asmcLClassName;
    data['asmcL_MinAgeYear'] = asmcLMinAgeYear;
    data['asmcL_MinAgeMonth'] = asmcLMinAgeMonth;
    data['asmcL_MinAgeDays'] = asmcLMinAgeDays;
    data['asmcL_MaxAgeYear'] = asmcLMaxAgeYear;
    data['asmcL_MaxAgeMonth'] = asmcLMaxAgeMonth;
    data['asmcL_MaxAgeDays'] = asmcLMaxAgeDays;
    data['asmcL_Order'] = asmcLOrder;
    data['asmcL_ClassCode'] = asmcLClassCode;
    data['asmcL_ActiveFlag'] = asmcLActiveFlag;
    data['asmcL_MaxCapacity'] = asmcLMaxCapacity;
    data['asmcL_PreadmFlag'] = asmcLPreadmFlag;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
