class DashboardLopModel {
  String? type;
  List<DashboardLopModelValues>? values;

  DashboardLopModel({this.type, this.values});

  DashboardLopModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DashboardLopModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DashboardLopModelValues.fromJson(v));
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

class DashboardLopModelValues {
  String? type;
  num? lOPAmount;
  int? lOPCOUNT;
  String? monthname;

  DashboardLopModelValues({this.type, this.lOPAmount, this.lOPCOUNT});

  DashboardLopModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    lOPAmount = json['LOPAmount'];
    lOPCOUNT = json['LOPCOUNT'];
    monthname = json['monthname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['LOPAmount'] = lOPAmount;
    data['LOPCOUNT'] = lOPCOUNT;
    data['monthname'] = monthname;
    return data;
  }
}
