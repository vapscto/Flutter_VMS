class HCDocModel {
  String? type;
  List<HCDocModelValues>? values;

  HCDocModel({this.type, this.values});

  HCDocModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <HCDocModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new HCDocModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HCDocModelValues {
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

  HCDocModelValues(
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

  HCDocModelValues.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mI_Id'] = this.mIId;
    data['userId'] = this.userId;
    data['ismmclT_Id'] = this.ismmclTId;
    data['hrmE_Id'] = this.hrmEId;
    data['hwhchuP_Id'] = this.hwhchuPId;
    data['hwhchupF_Id'] = this.hwhchupFId;
    data['count'] = this.count;
    data['levelNo'] = this.levelNo;
    data['returnval'] = this.returnval;
    data['activeFlag'] = this.activeFlag;
    data['filepath'] = this.filepath;
    data['filename'] = this.filename;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    return data;
  }
}
