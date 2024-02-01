class GetHCDataModel {
  String? type;
  List<GetHCDataModelValues>? values;

  GetHCDataModel({this.type, this.values});

  GetHCDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetHCDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(GetHCDataModelValues.fromJson(v));
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

class GetHCDataModelValues {
  int? mIId;
  int? userId;
  int? ismmclTId;
  int? hrmEId;
  int? hwhchuPId;
  int? hwhchupFId;
  int? count;
  int? levelNo;
  String? ismmclTClientName;
  String? remarks;
  String? hrmEEmployeeFirstName;
  String? visitedDate;
  bool? returnval;
  bool? activeFlag;
  String? status;
  String? fromDate;
  String? toDate;

  GetHCDataModelValues(
      {this.mIId,
      this.userId,
      this.ismmclTId,
      this.hrmEId,
      this.hwhchuPId,
      this.hwhchupFId,
      this.count,
      this.levelNo,
      this.ismmclTClientName,
      this.remarks,
      this.hrmEEmployeeFirstName,
      this.visitedDate,
      this.returnval,
      this.activeFlag,
      this.status,
      this.fromDate,
      this.toDate});

  GetHCDataModelValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    userId = json['userId'];
    ismmclTId = json['ismmclT_Id'];
    hrmEId = json['hrmE_Id'];
    hwhchuPId = json['hwhchuP_Id'];
    hwhchupFId = json['hwhchupF_Id'];
    count = json['count'];
    levelNo = json['levelNo'];
    ismmclTClientName = json['ismmclT_ClientName'];
    remarks = json['remarks'];
    hrmEEmployeeFirstName = json['hrmE_EmployeeFirstName'];
    visitedDate = json['visitedDate'];
    returnval = json['returnval'];
    activeFlag = json['activeFlag'];
    status = json['status'];
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
    data['ismmclT_ClientName'] = ismmclTClientName;
    data['remarks'] = remarks;
    data['hrmE_EmployeeFirstName'] = hrmEEmployeeFirstName;
    data['visitedDate'] = visitedDate;
    data['returnval'] = returnval;
    data['activeFlag'] = activeFlag;
    data['status'] = status;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    return data;
  }
}
