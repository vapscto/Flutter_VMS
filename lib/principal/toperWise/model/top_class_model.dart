class TopClassListModel {
  String? type;
  List<TopClassListModelValues>? values;

  TopClassListModel({this.type, this.values});

  TopClassListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TopClassListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TopClassListModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    if (this.values != null) {
      data['$values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopClassListModelValues {
  int? asmcLId;
  String? asmcLClassName;
  int? asmcLOrder;
  int? mIId;
  int? asmcLMinAgeYear;
  int? asmcLMinAgeMonth;
  int? asmcLMinAgeDays;
  int? asmcLMaxAgeYear;
  int? asmcLMaxAgeMonth;
  int? asmcLMaxAgeDays;
  int? asmcLMaxCapacity;
  bool? asmcLActiveFlag;
  int? asmcLPreadmFlag;
  String? createdDate;
  String? updatedDate;

  TopClassListModelValues(
      {this.asmcLId,
      this.asmcLClassName,
      this.asmcLOrder,
      this.mIId,
      this.asmcLMinAgeYear,
      this.asmcLMinAgeMonth,
      this.asmcLMinAgeDays,
      this.asmcLMaxAgeYear,
      this.asmcLMaxAgeMonth,
      this.asmcLMaxAgeDays,
      this.asmcLMaxCapacity,
      this.asmcLActiveFlag,
      this.asmcLPreadmFlag,
      this.createdDate,
      this.updatedDate});

  TopClassListModelValues.fromJson(Map<String, dynamic> json) {
    asmcLId = json['asmcL_Id'];
    asmcLClassName = json['asmcL_ClassName'];
    asmcLOrder = json['asmcL_Order'];
    mIId = json['mI_Id'];
    asmcLMinAgeYear = json['asmcL_MinAgeYear'];
    asmcLMinAgeMonth = json['asmcL_MinAgeMonth'];
    asmcLMinAgeDays = json['asmcL_MinAgeDays'];
    asmcLMaxAgeYear = json['asmcL_MaxAgeYear'];
    asmcLMaxAgeMonth = json['asmcL_MaxAgeMonth'];
    asmcLMaxAgeDays = json['asmcL_MaxAgeDays'];
    asmcLMaxCapacity = json['asmcL_MaxCapacity'];
    asmcLActiveFlag = json['asmcL_ActiveFlag'];
    asmcLPreadmFlag = json['asmcL_PreadmFlag'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asmcL_Id'] = this.asmcLId;
    data['asmcL_ClassName'] = this.asmcLClassName;
    data['asmcL_Order'] = this.asmcLOrder;
    data['mI_Id'] = this.mIId;
    data['asmcL_MinAgeYear'] = this.asmcLMinAgeYear;
    data['asmcL_MinAgeMonth'] = this.asmcLMinAgeMonth;
    data['asmcL_MinAgeDays'] = this.asmcLMinAgeDays;
    data['asmcL_MaxAgeYear'] = this.asmcLMaxAgeYear;
    data['asmcL_MaxAgeMonth'] = this.asmcLMaxAgeMonth;
    data['asmcL_MaxAgeDays'] = this.asmcLMaxAgeDays;
    data['asmcL_MaxCapacity'] = this.asmcLMaxCapacity;
    data['asmcL_ActiveFlag'] = this.asmcLActiveFlag;
    data['asmcL_PreadmFlag'] = this.asmcLPreadmFlag;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}
