 class GetGpsClientDetails {
  String? type;
  List<GetGpsClientDetailsValues>? values;

  GetGpsClientDetails({this.type, this.values});

  GetGpsClientDetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetGpsClientDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(new GetGpsClientDetailsValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetGpsClientDetailsValues {
  int? ismmclTId;
  int? mIId;
  String? ismmclTClientName;
  String? ismmclTDesc;
  int? ismmclTContactNo;
  String? ismmclTEmailId;
  String? ismmclTAddress;
  String? ismmclTNOName;
  String? ismmclTNOEmailId;
  int? ismmclTNOContactNo;
  int? ismmclTCordinatorId;
  int? ismmclTTeamLeadId;
  bool? ismmclTActiveFlag;
  int? ismmclTCreatedBy;
  int? ismmclTUpdatedBy;
  int? ivrMMIId;
  int? ismmclTRemainderDays;
  String? ismmclTClientCode;
  String? ismmclTCode;
  String? ismmclTIVRMURL;
  String? createdDate;
  String? updatedDate;
  String? ismmclTGSTNO;

  GetGpsClientDetailsValues(
      {this.ismmclTId,
      this.mIId,
      this.ismmclTClientName,
      this.ismmclTDesc,
      this.ismmclTContactNo,
      this.ismmclTEmailId,
      this.ismmclTAddress,
      this.ismmclTNOName,
      this.ismmclTNOEmailId,
      this.ismmclTNOContactNo,
      this.ismmclTCordinatorId,
      this.ismmclTTeamLeadId,
      this.ismmclTActiveFlag,
      this.ismmclTCreatedBy,
      this.ismmclTUpdatedBy,
      this.ivrMMIId,
      this.ismmclTRemainderDays,
      this.ismmclTClientCode,
      this.ismmclTCode,
      this.ismmclTIVRMURL,
      this.createdDate,
      this.updatedDate,
      this.ismmclTGSTNO});

  GetGpsClientDetailsValues.fromJson(Map<String, dynamic> json) {
    ismmclTId = json['ismmclT_Id'];
    mIId = json['mI_Id'];
    ismmclTClientName = json['ismmclT_ClientName'];
    ismmclTDesc = json['ismmclT_Desc'];
    ismmclTContactNo = json['ismmclT_ContactNo'];
    ismmclTEmailId = json['ismmclT_EmailId'];
    ismmclTAddress = json['ismmclT_Address'];
    ismmclTNOName = json['ismmclT_NOName'];
    ismmclTNOEmailId = json['ismmclT_NOEmailId'];
    ismmclTNOContactNo = json['ismmclT_NOContactNo'];
    ismmclTCordinatorId = json['ismmclT_CordinatorId'];
    ismmclTTeamLeadId = json['ismmclT_TeamLeadId'];
    ismmclTActiveFlag = json['ismmclT_ActiveFlag'];
    ismmclTCreatedBy = json['ismmclT_CreatedBy'];
    ismmclTUpdatedBy = json['ismmclT_UpdatedBy'];
    ivrMMIId = json['ivrM_MI_Id'];
    ismmclTRemainderDays = json['ismmclT_RemainderDays'];
    ismmclTClientCode = json['ismmclT_ClientCode'];
    ismmclTCode = json['ismmclT_Code'];
    ismmclTIVRMURL = json['ismmclT_IVRM_URL'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    ismmclTGSTNO = json['ismmclT_GSTNO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ismmclT_Id'] = this.ismmclTId;
    data['mI_Id'] = this.mIId;
    data['ismmclT_ClientName'] = this.ismmclTClientName;
    data['ismmclT_Desc'] = this.ismmclTDesc;
    data['ismmclT_ContactNo'] = this.ismmclTContactNo;
    data['ismmclT_EmailId'] = this.ismmclTEmailId;
    data['ismmclT_Address'] = this.ismmclTAddress;
    data['ismmclT_NOName'] = this.ismmclTNOName;
    data['ismmclT_NOEmailId'] = this.ismmclTNOEmailId;
    data['ismmclT_NOContactNo'] = this.ismmclTNOContactNo;
    data['ismmclT_CordinatorId'] = this.ismmclTCordinatorId;
    data['ismmclT_TeamLeadId'] = this.ismmclTTeamLeadId;
    data['ismmclT_ActiveFlag'] = this.ismmclTActiveFlag;
    data['ismmclT_CreatedBy'] = this.ismmclTCreatedBy;
    data['ismmclT_UpdatedBy'] = this.ismmclTUpdatedBy;
    data['ivrM_MI_Id'] = this.ivrMMIId;
    data['ismmclT_RemainderDays'] = this.ismmclTRemainderDays;
    data['ismmclT_ClientCode'] = this.ismmclTClientCode;
    data['ismmclT_Code'] = this.ismmclTCode;
    data['ismmclT_IVRM_URL'] = this.ismmclTIVRMURL;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['ismmclT_GSTNO'] = this.ismmclTGSTNO;
    return data;
  }
}
