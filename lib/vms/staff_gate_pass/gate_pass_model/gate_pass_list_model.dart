class GatePassListModel {
  String? type;
  List<GatePassListModelValues>? values;

  GatePassListModel({this.type, this.values});

  GatePassListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GatePassListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(GatePassListModelValues.fromJson(v));
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

class GatePassListModelValues {
  int? gphsTId;
  int? mIId;
  int? hrmEId;
  String? gphsTIDCardNo;
  String? gphsTDateTime;
  String? gphsTRemarks;
  bool? gphsTActiveFlg;
  int? asmaYId;
  int? userId;
  bool? returnval;
  bool? dulicate;
  String? empname;
  int? hrmDId;
  int? hrmdeSId;
  String? hrmDDepartmentName;
  String? hrmdeSDesignationName;

  GatePassListModelValues(
      {this.gphsTId,
      this.mIId,
      this.hrmEId,
      this.gphsTIDCardNo,
      this.gphsTDateTime,
      this.gphsTRemarks,
      this.gphsTActiveFlg,
      this.asmaYId,
      this.userId,
      this.returnval,
      this.dulicate,
      this.empname,
      this.hrmDId,
      this.hrmdeSId,
      this.hrmDDepartmentName,
      this.hrmdeSDesignationName});

  GatePassListModelValues.fromJson(Map<String, dynamic> json) {
    gphsTId = json['gphsT_Id'];
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    gphsTIDCardNo = json['gphsT_IDCardNo'];
    gphsTDateTime = json['gphsT_DateTime'];
    gphsTRemarks = json['gphsT_Remarks'];
    gphsTActiveFlg = json['gphsT_ActiveFlg'];
    asmaYId = json['asmaY_Id'];
    userId = json['userId'];
    returnval = json['returnval'];
    dulicate = json['dulicate'];
    empname = json['empname'];
    hrmDId = json['hrmD_Id'];
    hrmdeSId = json['hrmdeS_Id'];
    hrmDDepartmentName = json['hrmD_DepartmentName'];
    hrmdeSDesignationName = json['hrmdeS_DesignationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gphsT_Id'] = gphsTId;
    data['mI_Id'] = mIId;
    data['hrmE_Id'] = hrmEId;
    data['gphsT_IDCardNo'] = gphsTIDCardNo;
    data['gphsT_DateTime'] = gphsTDateTime;
    data['gphsT_Remarks'] = gphsTRemarks;
    data['gphsT_ActiveFlg'] = gphsTActiveFlg;
    data['asmaY_Id'] = asmaYId;
    data['userId'] = userId;
    data['returnval'] = returnval;
    data['dulicate'] = dulicate;
    data['empname'] = empname;
    data['hrmD_Id'] = hrmDId;
    data['hrmdeS_Id'] = hrmdeSId;
    data['hrmD_DepartmentName'] = hrmDDepartmentName;
    data['hrmdeS_DesignationName'] = hrmdeSDesignationName;
    return data;
  }
}
