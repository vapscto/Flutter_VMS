class ManagerWeeklyPeriodlistModel {
  String? type;
  List<ManagerWeeklyPeriodlistModelValues>? values;

  ManagerWeeklyPeriodlistModel({this.type, this.values});

  ManagerWeeklyPeriodlistModel.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <ManagerWeeklyPeriodlistModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new ManagerWeeklyPeriodlistModelValues.fromJson(v));
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

class ManagerWeeklyPeriodlistModelValues {
  int? ttmPId;
  int? mIId;
  String? ttmPPeriodName;
  bool? ttmPActiveFlag;
  String? createdDate;
  String? updatedDate;

  ManagerWeeklyPeriodlistModelValues(
      {this.ttmPId,
      this.mIId,
      this.ttmPPeriodName,
      this.ttmPActiveFlag,
      this.createdDate,
      this.updatedDate});

  ManagerWeeklyPeriodlistModelValues.fromJson(Map<String, dynamic> json) {
    ttmPId = json['ttmP_Id'];
    mIId = json['mI_Id'];
    ttmPPeriodName = json['ttmP_PeriodName'];
    ttmPActiveFlag = json['ttmP_ActiveFlag'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ttmP_Id'] = this.ttmPId;
    data['mI_Id'] = this.mIId;
    data['ttmP_PeriodName'] = this.ttmPPeriodName;
    data['ttmP_ActiveFlag'] = this.ttmPActiveFlag;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}
