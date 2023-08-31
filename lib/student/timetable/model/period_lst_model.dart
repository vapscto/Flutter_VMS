class PeriodList {
  String? type;
  List<PeriodListValues>? values;

  PeriodList({this.type, this.values});

  PeriodList.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PeriodListValues>[];
      json['\$values'].forEach((v) {
        values!.add(PeriodListValues.fromJson(v));
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

class PeriodListValues {
  int? ttmPId;
  int? mIId;
  String? ttmPPeriodName;
  bool? ttmPActiveFlag;
  String? createdDate;
  String? updatedDate;

  PeriodListValues(
      {this.ttmPId,
      this.mIId,
      this.ttmPPeriodName,
      this.ttmPActiveFlag,
      this.createdDate,
      this.updatedDate});

  PeriodListValues.fromJson(Map<String, dynamic> json) {
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
