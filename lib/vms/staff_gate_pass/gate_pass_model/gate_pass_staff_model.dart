class GatePassStaffModel {
  String? type;
  List<GatePassStaffModelValues>? values;

  GatePassStaffModel({this.type, this.values});

  GatePassStaffModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GatePassStaffModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(GatePassStaffModelValues.fromJson(v));
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

class GatePassStaffModelValues {
  int? gphsTId;
  int? mIId;
  int? hrmEId;
  bool? gphsTActiveFlg;
  int? asmaYId;
  int? userId;
  bool? returnval;
  bool? dulicate;
  String? empname;

  GatePassStaffModelValues(
      {this.gphsTId,
      this.mIId,
      this.hrmEId,
      this.gphsTActiveFlg,
      this.asmaYId,
      this.userId,
      this.returnval,
      this.dulicate,
      this.empname});

  GatePassStaffModelValues.fromJson(Map<String, dynamic> json) {
    gphsTId = json['gphsT_Id'];
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    gphsTActiveFlg = json['gphsT_ActiveFlg'];
    asmaYId = json['asmaY_Id'];
    userId = json['userId'];
    returnval = json['returnval'];
    dulicate = json['dulicate'];
    empname = json['empname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gphsT_Id'] = gphsTId;
    data['mI_Id'] = mIId;
    data['hrmE_Id'] = hrmEId;
    data['gphsT_ActiveFlg'] = gphsTActiveFlg;
    data['asmaY_Id'] = asmaYId;
    data['userId'] = userId;
    data['returnval'] = returnval;
    data['dulicate'] = dulicate;
    data['empname'] = empname;
    return data;
  }
}
