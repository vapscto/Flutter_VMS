class AttStaffDetailsModel {
  String? type;
  List<AttStaffDetailsModelValues>? values;

  AttStaffDetailsModel({this.type, this.values});

  AttStaffDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <AttStaffDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(AttStaffDetailsModelValues.fromJson(v));
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

class AttStaffDetailsModelValues {
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
  String? daysLop;
  String? fOEPWorkingHours;
  int? updatedLateins;
  int? updatedLateinstotal;

  AttStaffDetailsModelValues(
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
      this.fOEPDInOutFlg,
      this.daysLop,
      this.fOEPWorkingHours,
      this.updatedLateins,
      this.updatedLateinstotal});

  AttStaffDetailsModelValues.fromJson(Map<String, dynamic> json) {
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
    daysLop = json['DaysLop'];
    fOEPWorkingHours = json['FOEP_WorkingHours'];
    updatedLateins = json['UpdatedLateins'];
    updatedLateinstotal = json['UpdatedLateinstotal'];
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
    data['DaysLop'] = daysLop;
    data['FOEP_WorkingHours'] = fOEPWorkingHours;
    data['UpdatedLateins'] = updatedLateins;
    data['UpdatedLateinstotal'] = updatedLateinstotal;
    return data;
  }
}
