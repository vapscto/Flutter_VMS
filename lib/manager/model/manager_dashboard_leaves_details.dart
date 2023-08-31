class ManagerDashboardLeaveDetails {
  String? type;
  List<ManagerDashboardLeaveDetailsValues>? values;

  ManagerDashboardLeaveDetails({this.type, this.values});

  ManagerDashboardLeaveDetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ManagerDashboardLeaveDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(ManagerDashboardLeaveDetailsValues.fromJson(v));
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

class ManagerDashboardLeaveDetailsValues {
  String? type;
  int? totalLeave;
  int? appliedLeave;

  ManagerDashboardLeaveDetailsValues(
      {this.type, this.totalLeave, this.appliedLeave});

  ManagerDashboardLeaveDetailsValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    totalLeave = json['TotalLeave'];
    appliedLeave = json['AppliedLeave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['TotalLeave'] = totalLeave;
    data['AppliedLeave'] = appliedLeave;
    return data;
  }
}
