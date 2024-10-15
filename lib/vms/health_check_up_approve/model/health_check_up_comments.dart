class HealthCheckupComments {
  String? type;
  List<HealthCheckupCommentsValues>? values;

  HealthCheckupComments({this.type, this.values});

  HealthCheckupComments.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <HealthCheckupCommentsValues>[];
      json['\$values'].forEach((v) {
        values!.add(HealthCheckupCommentsValues.fromJson(v));
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

class HealthCheckupCommentsValues {
  int? mIId;
  int? userId;
  int? ismmclTId;
  int? hrmEId;
  int? hwhchuPId;
  int? hwhchupFId;
  int? count;
  int? levelNo;
  String? remarks;
  String? visitedDate;
  bool? returnval;
  bool? activeFlag;
  String? status;
  String? userName;
  String? fromDate;
  String? toDate;

  HealthCheckupCommentsValues(
      {this.mIId,
      this.userId,
      this.ismmclTId,
      this.hrmEId,
      this.hwhchuPId,
      this.hwhchupFId,
      this.count,
      this.levelNo,
      this.remarks,
      this.visitedDate,
      this.returnval,
      this.activeFlag,
      this.status,
      this.userName,
      this.fromDate,
      this.toDate});

  HealthCheckupCommentsValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    userId = json['userId'];
    ismmclTId = json['ismmclT_Id'];
    hrmEId = json['hrmE_Id'];
    hwhchuPId = json['hwhchuP_Id'];
    hwhchupFId = json['hwhchupF_Id'];
    count = json['count'];
    levelNo = json['levelNo'] ?? 0;
    remarks = json['remarks'];
    visitedDate = json['visitedDate'];
    returnval = json['returnval'];
    activeFlag = json['activeFlag'];
    status = json['status'];
    userName = json['userName'];
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
    data['remarks'] = remarks;
    data['visitedDate'] = visitedDate;
    data['returnval'] = returnval;
    data['activeFlag'] = activeFlag;
    data['status'] = status;
    data['userName'] = userName;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    return data;
  }
}
