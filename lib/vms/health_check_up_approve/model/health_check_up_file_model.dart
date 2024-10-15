class HealthCheckupFileModel {
  String? type;
  List<HealthCheckupFileModelValues>? values;

  HealthCheckupFileModel({this.type, this.values});

  HealthCheckupFileModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <HealthCheckupFileModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(HealthCheckupFileModelValues.fromJson(v));
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

class HealthCheckupFileModelValues {
  int? mIId;
  int? userId;
  int? ismmclTId;
  int? hrmEId;
  int? hwhchuPId;
  int? hwhchupFId;
  int? count;
  int? levelNo;
  bool? returnval;
  bool? activeFlag;
  String? filepath;
  String? filename;
  String? fromDate;
  String? toDate;

  HealthCheckupFileModelValues(
      {this.mIId,
      this.userId,
      this.ismmclTId,
      this.hrmEId,
      this.hwhchuPId,
      this.hwhchupFId,
      this.count,
      this.levelNo,
      this.returnval,
      this.activeFlag,
      this.filepath,
      this.filename,
      this.fromDate,
      this.toDate});

  HealthCheckupFileModelValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    userId = json['userId'];
    ismmclTId = json['ismmclT_Id'];
    hrmEId = json['hrmE_Id'];
    hwhchuPId = json['hwhchuP_Id'];
    hwhchupFId = json['hwhchupF_Id'];
    count = json['count'];
    levelNo = json['levelNo'];
    returnval = json['returnval'];
    activeFlag = json['activeFlag'];
    filepath = json['filepath'];
    filename = json['filename'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mI_Id'] = mIId;
    data['userId'] = userId;
    data['ismmclT_Id'] = ismmclTId;
    data['hrmE_Id'] = hrmEId;
    data['hwhchuP_Id'] = hwhchuPId;
    data['hwhchupF_Id'] = hwhchupFId;
    data['count'] = count;
    data['levelNo'] = levelNo;
    data['returnval'] = returnval;
    data['activeFlag'] = activeFlag;
    data['filepath'] = filepath;
    data['filename'] = filename;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    return data;
  }
}
