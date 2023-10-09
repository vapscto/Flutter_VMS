class EmployeelistModel {
  String? type;
  List<EmployeelistModelValues>? values;

  EmployeelistModel({this.type, this.values});

  EmployeelistModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <EmployeelistModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(EmployeelistModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeelistModelValues {
  int? vmmVId;
  int? vmaPId;
  int? mIId;
  int? hrmEId;
  int? tenantagRId;
  int? vmvtmTToMeetHRMEId;
  int? vmaPVisitorContactNo;
  String? hrmEEmployeeFirstName;
  int? vmmVVisitorContactNo;
  String? vmmVMeetingDateTime;
  int? vmmVToMeet;
  int? userId;
  bool? vmmVActiveFlag;
  bool? value;
  int? count;
  int? countSubvisitors;
  bool? vmmVDeptFlag;
  int? vmvaPId;
  int? hrmemnOMobileNo;
  int? vmvtmTId;
  bool? deptFlag;
  bool? vmvtmTMetFlg;
  String? vmvtmTDateTime;
  int? fhrors;
  int? fminutes;

  EmployeelistModelValues(
      {this.vmmVId,
      this.vmaPId,
      this.mIId,
      this.hrmEId,
      this.tenantagRId,
      this.vmvtmTToMeetHRMEId,
      this.vmaPVisitorContactNo,
      this.hrmEEmployeeFirstName,
      this.vmmVVisitorContactNo,
      this.vmmVMeetingDateTime,
      this.vmmVToMeet,
      this.userId,
      this.vmmVActiveFlag,
      this.value,
      this.count,
      this.countSubvisitors,
      this.vmmVDeptFlag,
      this.vmvaPId,
      this.hrmemnOMobileNo,
      this.vmvtmTId,
      this.deptFlag,
      this.vmvtmTMetFlg,
      this.vmvtmTDateTime,
      this.fhrors,
      this.fminutes});

  EmployeelistModelValues.fromJson(Map<String, dynamic> json) {
    vmmVId = json['vmmV_Id'];
    vmaPId = json['vmaP_Id'];
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    tenantagRId = json['tenantagR_Id'];
    vmvtmTToMeetHRMEId = json['vmvtmT_ToMeet_HRME_Id'];
    vmaPVisitorContactNo = json['vmaP_VisitorContactNo'];
    hrmEEmployeeFirstName = json['hrmE_EmployeeFirstName'];
    vmmVVisitorContactNo = json['vmmV_VisitorContactNo'];
    vmmVMeetingDateTime = json['vmmV_MeetingDateTime'];
    vmmVToMeet = json['vmmV_ToMeet'];
    userId = json['userId'];
    vmmVActiveFlag = json['vmmV_ActiveFlag'];
    value = json['value'];
    count = json['count'];
    countSubvisitors = json['count_subvisitors'];
    vmmVDeptFlag = json['vmmV_DeptFlag'];
    vmvaPId = json['vmvaP_Id'];
    hrmemnOMobileNo = json['hrmemnO_MobileNo'];
    vmvtmTId = json['vmvtmT_Id'];
    deptFlag = json['dept_flag'];
    vmvtmTMetFlg = json['vmvtmT_MetFlg'];
    vmvtmTDateTime = json['vmvtmT_DateTime'];
    fhrors = json['fhrors'];
    fminutes = json['fminutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vmmV_Id'] = vmmVId;
    data['vmaP_Id'] = vmaPId;
    data['mI_Id'] = mIId;
    data['hrmE_Id'] = hrmEId;
    data['tenantagR_Id'] = tenantagRId;
    data['vmvtmT_ToMeet_HRME_Id'] = vmvtmTToMeetHRMEId;
    data['vmaP_VisitorContactNo'] = vmaPVisitorContactNo;
    data['hrmE_EmployeeFirstName'] = hrmEEmployeeFirstName;
    data['vmmV_VisitorContactNo'] = vmmVVisitorContactNo;
    data['vmmV_MeetingDateTime'] = vmmVMeetingDateTime;
    data['vmmV_ToMeet'] = vmmVToMeet;
    data['userId'] = userId;
    data['vmmV_ActiveFlag'] = vmmVActiveFlag;
    data['value'] = value;
    data['count'] = count;
    data['count_subvisitors'] = countSubvisitors;
    data['vmmV_DeptFlag'] = vmmVDeptFlag;
    data['vmvaP_Id'] = vmvaPId;
    data['hrmemnO_MobileNo'] = hrmemnOMobileNo;
    data['vmvtmT_Id'] = vmvtmTId;
    data['dept_flag'] = deptFlag;
    data['vmvtmT_MetFlg'] = vmvtmTMetFlg;
    data['vmvtmT_DateTime'] = vmvtmTDateTime;
    data['fhrors'] = fhrors;
    data['fminutes'] = fminutes;
    return data;
  }
}
