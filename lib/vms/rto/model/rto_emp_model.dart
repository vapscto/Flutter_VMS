class RtoEmpModel {
  String? type;
  List<RtoEmpModelValues>? values;

  RtoEmpModel({this.type, this.values});

  RtoEmpModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <RtoEmpModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(RtoEmpModelValues.fromJson(v));
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

class RtoEmpModelValues {
  String? type;
  int? hRMEId;
  String? eMPNAME;

  RtoEmpModelValues({this.type, this.hRMEId, this.eMPNAME});

  RtoEmpModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEId = json['HRME_Id'];
    eMPNAME = json['EMPNAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRME_Id'] = hRMEId;
    data['EMPNAME'] = eMPNAME;
    return data;
  }
}
