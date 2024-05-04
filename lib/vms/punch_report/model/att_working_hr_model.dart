class AttWorkingHrModel {
  String? type;
  List<Values>? values;

  AttWorkingHrModel({this.type, this.values});

  AttWorkingHrModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <Values>[];
      json['\$values'].forEach((v) {
        values!.add(Values.fromJson(v));
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

class Values {
  String? type;
  int? hRMEId;
  String? empName;
  String? punchDate;
  String? workingHours;

  Values(
      {this.type,
      this.hRMEId,
      this.empName,
      this.punchDate,
      this.workingHours});

  Values.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEId = json['HRME_Id'];
    empName = json['EmpName'];
    punchDate = json['PunchDate'];
    workingHours = json['WorkingHours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRME_Id'] = hRMEId;
    data['EmpName'] = empName;
    data['PunchDate'] = punchDate;
    data['WorkingHours'] = workingHours;
    return data;
  }
}
