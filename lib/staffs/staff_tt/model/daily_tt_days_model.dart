class DailyTTDaysModel {
  String? type;
  List<DailyTTDaysModelValues>? values;

  DailyTTDaysModel({this.type, this.values});

  DailyTTDaysModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DailyTTDaysModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DailyTTDaysModelValues.fromJson(v));
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

class DailyTTDaysModelValues {
  int? ttmDId;
  int? mIId;
  String? ttmDDayName;
  String? ttmDDayCode;
  int? orderId;
  bool? ttmDActiveFlag;
  String? createdDate;
  String? updatedDate;

  DailyTTDaysModelValues(
      {this.ttmDId,
      this.mIId,
      this.ttmDDayName,
      this.ttmDDayCode,
      this.orderId,
      this.ttmDActiveFlag,
      this.createdDate,
      this.updatedDate});

  DailyTTDaysModelValues.fromJson(Map<String, dynamic> json) {
    ttmDId = json['ttmD_Id'];
    mIId = json['mI_Id'];
    ttmDDayName = json['ttmD_DayName'];
    ttmDDayCode = json['ttmD_DayCode'];
    orderId = json['order_Id'];
    ttmDActiveFlag = json['ttmD_ActiveFlag'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ttmD_Id'] = ttmDId;
    data['mI_Id'] = mIId;
    data['ttmD_DayName'] = ttmDDayName;
    data['ttmD_DayCode'] = ttmDDayCode;
    data['order_Id'] = orderId;
    data['ttmD_ActiveFlag'] = ttmDActiveFlag;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
