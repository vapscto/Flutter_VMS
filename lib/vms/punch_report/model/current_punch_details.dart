class CurrentPunchDetailsModel {
  String? type;
  List<CurrentPunchDetailsModelValues>? values;

  CurrentPunchDetailsModel({this.type, this.values});

  CurrentPunchDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <CurrentPunchDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CurrentPunchDetailsModelValues.fromJson(v));
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

class CurrentPunchDetailsModelValues {
  String? type;
  int? hRMEId;
  String? ecode;
  String? ename;
  String? depname;
  String? desgname;
  String? gtype;
  dynamic punchdate;
  dynamic intime;
  dynamic outtime;
  dynamic workingtime;

  CurrentPunchDetailsModelValues(
      {this.type,
      this.hRMEId,
      this.ecode,
      this.ename,
      this.depname,
      this.desgname,
      this.gtype,
      this.punchdate,
      this.intime,
      this.outtime,
      this.workingtime});

  CurrentPunchDetailsModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEId = json['HRME_Id'];
    ecode = json['ecode'];
    ename = json['ename'];
    depname = json['depname'];
    desgname = json['desgname'];
    gtype = json['gtype'];
    punchdate = json['punchdate'];
    intime = json['intime'];
    outtime = json['outtime'];
    workingtime = json['workingtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRME_Id'] = hRMEId;
    data['ecode'] = ecode;
    data['ename'] = ename;
    data['depname'] = depname;
    data['desgname'] = desgname;
    data['gtype'] = gtype;
    data['punchdate'] = punchdate;
    data['intime'] = intime;
    data['outtime'] = outtime;
    data['workingtime'] = workingtime;
    return data;
  }
}
