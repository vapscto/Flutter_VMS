class DashboardPunchReportModel {
  String? type;
  List<DashboardPunchReportModelValues>? values;

  DashboardPunchReportModel({this.type, this.values});

  DashboardPunchReportModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DashboardPunchReportModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DashboardPunchReportModelValues.fromJson(v));
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

class DashboardPunchReportModelValues {
  String? type;
  String? ecode;
  String? ename;
  int? hRMEId;
  String? punchdate;
  String? punchINtime;
  String? punchOUTtime;
  String? lateby;
  String? earlyby;

  DashboardPunchReportModelValues(
      {this.type,
      this.ecode,
      this.ename,
      this.hRMEId,
      this.punchdate,
      this.punchINtime,
      this.punchOUTtime,
      this.lateby,
      this.earlyby});

  DashboardPunchReportModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    ecode = json['ecode'];
    ename = json['ename'];
    hRMEId = json['HRME_Id'];
    punchdate = json['punchdate'];
    punchINtime = json['punchINtime'];
    punchOUTtime = json['punchOUTtime'];
    lateby = json['lateby'];
    earlyby = json['earlyby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ecode'] = ecode;
    data['ename'] = ename;
    data['HRME_Id'] = hRMEId;
    data['punchdate'] = punchdate;
    data['punchINtime'] = punchINtime;
    data['punchOUTtime'] = punchOUTtime;
    data['lateby'] = lateby;
    data['earlyby'] = earlyby;
    return data;
  }
}
