class GetHCEmpListModel {
  String? type;
  List<GetHCEmpListModelValues>? values;

  GetHCEmpListModel({this.type, this.values});

  GetHCEmpListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetHCEmpListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(GetHCEmpListModelValues.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mI_Id'] = mIId;
    data['userId'] = userId;
    data['ismmclT_Id'] = ismmclTId;
    data['hrmE_Id'] = hrmEId;
    data['hwhchuP_Id'] = hwhchuPId;
    data['hwhchupF_Id'] = hwhchupFId;
    data['count'] = count;
    data['levelNo'] = levelNo;
    data['hrmE_EmployeeFirstName'] = hrmEEmployeeFirstName;
    data['returnval'] = returnval;
    data['activeFlag'] = activeFlag;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    return data;
  }
}
