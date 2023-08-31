class ManagerDashboardFeeDetails {
  String? type;
  List<ManagerDashboardFeeDetailsValues>? values;

  ManagerDashboardFeeDetails({this.type, this.values});

  ManagerDashboardFeeDetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ManagerDashboardFeeDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(ManagerDashboardFeeDetailsValues.fromJson(v));
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

class ManagerDashboardFeeDetailsValues {
  String? type;
  int? totalAmount;
  int? totalPaidOnline;

  ManagerDashboardFeeDetailsValues(
      {this.type, this.totalAmount, this.totalPaidOnline});

  ManagerDashboardFeeDetailsValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    totalAmount = json['TotalAmount'];
    totalPaidOnline = json['TotalPaidOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['TotalAmount'] = totalAmount;
    data['TotalPaidOnline'] = totalPaidOnline;
    return data;
  }
}
