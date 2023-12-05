class InteractionStaffListModel {
  String? type;
  List<InteractionStaffListModelValues>? values;

  InteractionStaffListModel({this.type, this.values});

  InteractionStaffListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <InteractionStaffListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(InteractionStaffListModelValues.fromJson(v));
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

class InteractionStaffListModelValues {
  String? type;
  int? hRMEId;
  int? hRMDId;
  String? employeeName;
  String? hRMDDepartmentName;

  InteractionStaffListModelValues(
      {this.type,
      this.hRMEId,
      this.hRMDId,
      this.employeeName,
      this.hRMDDepartmentName});

  InteractionStaffListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEId = json['HRME_Id'];
    hRMDId = json['HRMD_Id'];
    employeeName = json['employeeName'];
    hRMDDepartmentName = json['HRMD_DepartmentName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRME_Id'] = hRMEId;
    data['HRMD_Id'] = hRMDId;
    data['employeeName'] = employeeName;
    data['HRMD_DepartmentName'] = hRMDDepartmentName;
    return data;
  }
}
