class EmployeeSalarySlipModel {
  String? type;
  List<EmployeeSalarySlipValues>? values;

  EmployeeSalarySlipModel({this.type, this.values});

  EmployeeSalarySlipModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <EmployeeSalarySlipValues>[];
      json['\$values'].forEach((v) {
        values!.add(EmployeeSalarySlipValues.fromJson(v));
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

class EmployeeSalarySlipValues {
  int? hRMEId;
  String? ecode;
  String? ename;
  String? depname;
  String? desgname;
  String? gtype;
  String? punchdate;
  String? punchday;
  String? intime;
  String? outtime;
  String? workingtime;
  String? intemperature;

  EmployeeSalarySlipValues(
      {this.hRMEId,
      this.ecode,
      this.ename,
      this.depname,
      this.desgname,
      this.gtype,
      this.punchdate,
      this.punchday,
      this.intime,
      this.outtime,
      this.workingtime,
      this.intemperature});

  EmployeeSalarySlipValues.fromJson(Map<String, dynamic> json) {
    hRMEId = json['HRME_Id'];
    ecode = json['ecode'];
    ename = json['ename'];
    depname = json['depname'];
    desgname = json['desgname'];
    gtype = json['gtype'];
    punchdate = json['punchdate'];
    punchday = json['punchday'];
    intime = json['intime'];
    outtime = json['outtime'];
    workingtime = json['workingtime'];
    intemperature = json['intemperature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['HRME_Id'] = hRMEId;
    data['ecode'] = ecode;
    data['ename'] = ename;
    data['depname'] = depname;
    data['desgname'] = desgname;
    data['gtype'] = gtype;
    data['punchdate'] = punchdate;
    data['punchday'] = punchday;
    data['intime'] = intime;
    data['outtime'] = outtime;
    data['workingtime'] = workingtime;
    data['intemperature'] = intemperature;
    return data;
  }
}
