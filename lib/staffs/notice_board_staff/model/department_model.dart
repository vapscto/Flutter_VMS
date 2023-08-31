class DepartmentListModel {
  String? type;
  List<DepartmentListModelValues>? values;

  DepartmentListModel({this.type, this.values});

  DepartmentListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DepartmentListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DepartmentListModelValues.fromJson(v));
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

class DepartmentListModelValues {
  String? type;
  String? hRMDCName;
  int? hRMDCID;

  DepartmentListModelValues({this.type, this.hRMDCName, this.hRMDCID});

  DepartmentListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMDCName = json['HRMDC_Name'];
    hRMDCID = json['HRMDC_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRMDC_Name'] = hRMDCName;
    data['HRMDC_ID'] = hRMDCID;
    return data;
  }
}
