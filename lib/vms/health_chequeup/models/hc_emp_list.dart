class GetHCEmpListModel {
  String? type;
  List<GetHCEmpListModelValues>? values;

  GetHCEmpListModel({this.type, this.values});

  GetHCEmpListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetHCEmpListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new GetHCEmpListModelValues.fromJson(v));
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

class GetHCEmpListModelValues {
  int? mIId;
  int? userId;
  int? ismmclTId;
  int? hrmEId;
  int? hwhchuPId;
  int? hwhchupFId;
  int? count;
  int? levelNo;
  String? hrmEEmployeeFirstName;
  bool? returnval;
  bool? activeFlag;
  String? fromDate;
  String? toDate;

  GetHCEmpListModelValues(
      {this.mIId,
      this.userId,
      this.ismmclTId,
      this.hrmEId,
      this.hwhchuPId,
      this.hwhchupFId,
      this.count,
      this.levelNo,
      this.hrmEEmployeeFirstName,
      this.returnval,
      this.activeFlag,
      this.fromDate,
      this.toDate});

  GetHCEmpListModelValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    userId = json['userId'];
    ismmclTId = json['ismmclT_Id'];
    hrmEId = json['hrmE_Id'];
    hwhchuPId = json['hwhchuP_Id'];
    hwhchupFId = json['hwhchupF_Id'];
    count = json['count'];
    levelNo = json['levelNo'];
    hrmEEmployeeFirstName = json['hrmE_EmployeeFirstName'];
    returnval = json['returnval'];
    activeFlag = json['activeFlag'];
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
    data['hrmE_EmployeeFirstName'] = this.hrmEEmployeeFirstName;
    data['returnval'] = this.returnval;
    data['activeFlag'] = this.activeFlag;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    return data;
  }
}
