class ManagerWeeklyGridWeeksModel {
  String? type;
  List<ManagerWeeklyGridWeeksModelValues>? values;

  ManagerWeeklyGridWeeksModel({this.type, this.values});

  ManagerWeeklyGridWeeksModel.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <ManagerWeeklyGridWeeksModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new ManagerWeeklyGridWeeksModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ManagerWeeklyGridWeeksModelValues {
  int? ttmDId;
  int? mIId;
  String? ttmDDayName;
  String? ttmDDayCode;
  int? orderId;
  bool? ttmDActiveFlag;
  String? createdDate;
  String? updatedDate;

  ManagerWeeklyGridWeeksModelValues(
      {this.ttmDId,
      this.mIId,
      this.ttmDDayName,
      this.ttmDDayCode,
      this.orderId,
      this.ttmDActiveFlag,
      this.createdDate,
      this.updatedDate});

  ManagerWeeklyGridWeeksModelValues.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ttmD_Id'] = this.ttmDId;
    data['mI_Id'] = this.mIId;
    data['ttmD_DayName'] = this.ttmDDayName;
    data['ttmD_DayCode'] = this.ttmDDayCode;
    data['order_Id'] = this.orderId;
    data['ttmD_ActiveFlag'] = this.ttmDActiveFlag;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}
