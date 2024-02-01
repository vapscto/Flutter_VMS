class GetGpsClientDetails {
  String? type;
  List<GetGpsClientDetailsValues>? values;

  GetGpsClientDetails({this.type, this.values});

  GetGpsClientDetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetGpsClientDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(GetGpsClientDetailsValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ismmclT_Id'] = ismmclTId;
    data['mI_Id'] = mIId;
    data['ismmclT_ClientName'] = ismmclTClientName;
    data['ismmclT_Desc'] = ismmclTDesc;
    data['ismmclT_ContactNo'] = ismmclTContactNo;
    data['ismmclT_EmailId'] = ismmclTEmailId;
    data['ismmclT_Address'] = ismmclTAddress;
    data['ismmclT_NOName'] = ismmclTNOName;
    data['ismmclT_NOEmailId'] = ismmclTNOEmailId;
    data['ismmclT_NOContactNo'] = ismmclTNOContactNo;
    data['ismmclT_CordinatorId'] = ismmclTCordinatorId;
    data['ismmclT_TeamLeadId'] = ismmclTTeamLeadId;
    data['ismmclT_ActiveFlag'] = ismmclTActiveFlag;
    data['ismmclT_CreatedBy'] = ismmclTCreatedBy;
    data['ismmclT_UpdatedBy'] = ismmclTUpdatedBy;
    data['ivrM_MI_Id'] = ivrMMIId;
    data['ismmclT_RemainderDays'] = ismmclTRemainderDays;
    data['ismmclT_ClientCode'] = ismmclTClientCode;
    data['ismmclT_Code'] = ismmclTCode;
    data['ismmclT_IVRM_URL'] = ismmclTIVRMURL;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['ismmclT_GSTNO'] = ismmclTGSTNO;
    return data;
  }
}
