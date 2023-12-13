class VersionChangeModel {
  String? type;
  List<Values>? values;

  VersionChangeModel({this.type, this.values});

  VersionChangeModel.fromJson(Map<String, dynamic> json) {
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
  int? iMVEId;
  int? mIId;
  Null? iMVEAppTypeFlg;
  Null? iMVEAppUserTypeFlg;
  String? iMVEAppVersion;
  Null? iMVEAppUploadedDate;
  bool? iMVEActiveFlg;
  Null? iMVECreatedBy;
  Null? iMVEUpdatedBy;
  Null? createdDate;
  Null? updatedDate;
  Null? vId;
  Null? studentName;

  Values(
      {this.type,
      this.iMVEId,
      this.mIId,
      this.iMVEAppTypeFlg,
      this.iMVEAppUserTypeFlg,
      this.iMVEAppVersion,
      this.iMVEAppUploadedDate,
      this.iMVEActiveFlg,
      this.iMVECreatedBy,
      this.iMVEUpdatedBy,
      this.createdDate,
      this.updatedDate,
      this.vId,
      this.studentName});

  Values.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iMVEId = json['IMVE_Id'];
    mIId = json['MI_Id'];
    iMVEAppTypeFlg = json['IMVE_AppTypeFlg'];
    iMVEAppUserTypeFlg = json['IMVE_AppUserTypeFlg'];
    iMVEAppVersion = json['IMVE_AppVersion'];
    iMVEAppUploadedDate = json['IMVE_AppUploadedDate'];
    iMVEActiveFlg = json['IMVE_ActiveFlg'];
    iMVECreatedBy = json['IMVE_CreatedBy'];
    iMVEUpdatedBy = json['IMVE_UpdatedBy'];
    createdDate = json['CreatedDate'];
    updatedDate = json['UpdatedDate'];
    vId = json['V_Id'];
    studentName = json['Student_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['IMVE_Id'] = iMVEId;
    data['MI_Id'] = mIId;
    data['IMVE_AppTypeFlg'] = iMVEAppTypeFlg;
    data['IMVE_AppUserTypeFlg'] = iMVEAppUserTypeFlg;
    data['IMVE_AppVersion'] = iMVEAppVersion;
    data['IMVE_AppUploadedDate'] = iMVEAppUploadedDate;
    data['IMVE_ActiveFlg'] = iMVEActiveFlg;
    data['IMVE_CreatedBy'] = iMVECreatedBy;
    data['IMVE_UpdatedBy'] = iMVEUpdatedBy;
    data['CreatedDate'] = createdDate;
    data['UpdatedDate'] = updatedDate;
    data['V_Id'] = vId;
    data['Student_name'] = studentName;
    return data;
  }
}
