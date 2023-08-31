class CoeMonthDataModel {
  String? type;
  List<CoeMonthDataModelValues>? values;

  CoeMonthDataModel({this.type, this.values});

  CoeMonthDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CoeMonthDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CoeMonthDataModelValues.fromJson(v));
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

class CoeMonthDataModelValues {
  int? mIId;
  int? hrmDId;
  int? hrmdeSId;
  int? hrmEId;
  int? monthid;
  String? monthname;
  int? yearid;

  CoeMonthDataModelValues(
      {this.mIId,
      this.hrmDId,
      this.hrmdeSId,
      this.hrmEId,
      this.monthid,
      this.monthname,
      this.yearid});

  CoeMonthDataModelValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    hrmDId = json['hrmD_Id'];
    hrmdeSId = json['hrmdeS_Id'];
    hrmEId = json['hrmE_Id'];
    monthid = json['monthid'];
    monthname = json['monthname'];
    yearid = json['yearid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mI_Id'] = mIId;
    data['hrmD_Id'] = hrmDId;
    data['hrmdeS_Id'] = hrmdeSId;
    data['hrmE_Id'] = hrmEId;
    data['monthid'] = monthid;
    data['monthname'] = monthname;
    data['yearid'] = yearid;
    return data;
  }
}
