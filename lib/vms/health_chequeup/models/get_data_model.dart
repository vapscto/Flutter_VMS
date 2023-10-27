class GetHCDataModel {
  String? type;
  List<GetHCDataModelValues>? values;

  GetHCDataModel({this.type, this.values});

  GetHCDataModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetHCDataModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new GetHCDataModelValues.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mI_Id'] = this.mIId;
    data['userId'] = this.userId;
    data['ismmclT_Id'] = this.ismmclTId;
    data['hrmE_Id'] = this.hrmEId;
    data['hwhchuP_Id'] = this.hwhchuPId;
    data['hwhchupF_Id'] = this.hwhchupFId;
    data['count'] = this.count;
    data['levelNo'] = this.levelNo;
    data['ismmclT_ClientName'] = this.ismmclTClientName;
    data['remarks'] = this.remarks;
    data['hrmE_EmployeeFirstName'] = this.hrmEEmployeeFirstName;
    data['visitedDate'] = this.visitedDate;
    data['returnval'] = this.returnval;
    data['activeFlag'] = this.activeFlag;
    data['status'] = this.status;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    return data;
  }
}
