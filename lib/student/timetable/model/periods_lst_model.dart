class PeriodsListModel {
  String? type;
  List<PeriodsListModelValues>? values;

  PeriodsListModel({this.type, this.values});

  PeriodsListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PeriodsListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(PeriodsListModelValues.fromJson(v));
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

class PeriodsListModelValues {
  int? ttmPId;
  int? mIId;
  String? ttmPPeriodName;
  bool? ttmPActiveFlag;
  String? createdDate;
  String? updatedDate;

  PeriodsListModelValues(
      {this.ttmPId,
      this.mIId,
      this.ttmPPeriodName,
      this.ttmPActiveFlag,
      this.createdDate,
      this.updatedDate});

  PeriodsListModelValues.fromJson(Map<String, dynamic> json) {
    ttmPId = json['ttmP_Id'];
    mIId = json['mI_Id'];
    ttmPPeriodName = json['ttmP_PeriodName'];
    ttmPActiveFlag = json['ttmP_ActiveFlag'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ttmP_Id'] = ttmPId;
    data['mI_Id'] = mIId;
    data['ttmP_PeriodName'] = ttmPPeriodName;
    data['ttmP_ActiveFlag'] = ttmPActiveFlag;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
