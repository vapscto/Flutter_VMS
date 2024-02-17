class PeriodicityListModel {
  String? type;
  List<PeriodicityListModelValues>? values;

  PeriodicityListModel({this.type, this.values});

  PeriodicityListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PeriodicityListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(PeriodicityListModelValues.fromJson(v));
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

class PeriodicityListModelValues {
  String? type;
  int? hRMPRId;
  String? hRMPName;
  int? totalcount;
  String? mIName;

  PeriodicityListModelValues(
      {this.type, this.hRMPRId, this.hRMPName, this.totalcount, this.mIName});

  PeriodicityListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMPRId = json['HRMPR_Id'];
    hRMPName = json['HRMP_Name'];
    totalcount = json['totalcount'];
    mIName = json['MI_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRMPR_Id'] = hRMPRId;
    data['HRMP_Name'] = hRMPName;
    data['totalcount'] = totalcount;
    data['MI_Name'] = mIName;
    return data;
  }
}
