class LateInModel {
  String? type;
  List<LateInModelValues>? values;

  LateInModel({this.type, this.values});

  LateInModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <LateInModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(LateInModelValues.fromJson(v));
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

class LateInModelValues {
  String? type;
  int? hRMEId;
  String? ecode;
  String? ename;
  String? depname;
  String? desgname;
  String? gtype;
  String? punchdate;
  String? punchtime;
  String? actualtime;
  String? relaxtime;
  String? lateby;
  String? earlyby;
  String? fOEPDInOutFlg;

  LateInModelValues(
      {this.type,
      this.hRMEId,
      this.ecode,
      this.ename,
      this.depname,
      this.desgname,
      this.gtype,
      this.punchdate,
      this.punchtime,
      this.actualtime,
      this.relaxtime,
      this.lateby,
      this.earlyby,
      this.fOEPDInOutFlg});

  LateInModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEId = json['HRME_Id'];
    ecode = json['ecode'];
    ename = json['ename'];
    depname = json['depname'];
    desgname = json['desgname'];
    gtype = json['gtype'];
    punchdate = json['punchdate'];
    punchtime = json['punchtime'];
    actualtime = json['actualtime'];
    relaxtime = json['relaxtime'];
    lateby = json['lateby'];
    earlyby = json['earlyby'];
    fOEPDInOutFlg = json['FOEPD_InOutFlg'];
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
    data['punchtime'] = punchtime;
    data['actualtime'] = actualtime;
    data['relaxtime'] = relaxtime;
    data['lateby'] = lateby;
    data['earlyby'] = earlyby;
    data['FOEPD_InOutFlg'] = fOEPDInOutFlg;
    return data;
  }
}
