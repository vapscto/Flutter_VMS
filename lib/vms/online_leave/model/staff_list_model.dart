class StaffPrevilegeListModel {
  String? type;
  List<StaffPrevilegeListModelValues>? values;

  StaffPrevilegeListModel({this.type, this.values});

  StaffPrevilegeListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <StaffPrevilegeListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(StaffPrevilegeListModelValues.fromJson(v));
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

class StaffPrevilegeListModelValues {
  String? type;
  int? hRMEId;
  String? hRMEEmployeeFirstName;

  StaffPrevilegeListModelValues(
      {this.type, this.hRMEId, this.hRMEEmployeeFirstName});

  StaffPrevilegeListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEId = json['HRME_Id'];
    hRMEEmployeeFirstName = json['HRME_EmployeeFirstName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRME_Id'] = hRMEId;
    data['HRME_EmployeeFirstName'] = hRMEEmployeeFirstName;
    return data;
  }
}
