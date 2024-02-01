class ClientListModel {
  String? type;
  List<ClientListModelValues>? values;

  ClientListModel({this.type, this.values});

  ClientListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ClientListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ClientListModelValues.fromJson(v));
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

class ClientListModelValues {
  int? ismmclTId;
  int? mIId;
  String? ismmclTClientName;
  int? ismmclTContactNo;
  String? ismmclTEmailId;
  String? ismmclTAddress;
  String? ismmclTNOName;
  int? ismmclTNOContactNo;
  int? ismmclTCordinatorId;
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
  String? ismmclTDesc;
  String? ismmclTNOEmailId;
  int? ismmclTTeamLeadId;
  String? ismmclTGSTNO;

  ClientListModelValues(
      {this.ismmclTId,
      this.mIId,
      this.ismmclTClientName,
      this.ismmclTContactNo,
      this.ismmclTEmailId,
      this.ismmclTAddress,
      this.ismmclTNOName,
      this.ismmclTNOContactNo,
      this.ismmclTCordinatorId,
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
      this.ismmclTDesc,
      this.ismmclTNOEmailId,
      this.ismmclTTeamLeadId,
      this.ismmclTGSTNO});

  ClientListModelValues.fromJson(Map<String, dynamic> json) {
    ismmclTId = json['ismmclT_Id'];
    mIId = json['mI_Id'];
    ismmclTClientName = json['ismmclT_ClientName'];
    ismmclTContactNo = json['ismmclT_ContactNo'];
    ismmclTEmailId = json['ismmclT_EmailId'];
    ismmclTAddress = json['ismmclT_Address'];
    ismmclTNOName = json['ismmclT_NOName'];
    ismmclTNOContactNo = json['ismmclT_NOContactNo'];
    ismmclTCordinatorId = json['ismmclT_CordinatorId'];
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
    ismmclTDesc = json['ismmclT_Desc'];
    ismmclTNOEmailId = json['ismmclT_NOEmailId'];
    ismmclTTeamLeadId = json['ismmclT_TeamLeadId'];
    ismmclTGSTNO = json['ismmclT_GSTNO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ismmclT_Id'] = ismmclTId;
    data['mI_Id'] = mIId;
    data['ismmclT_ClientName'] = ismmclTClientName;
    data['ismmclT_ContactNo'] = ismmclTContactNo;
    data['ismmclT_EmailId'] = ismmclTEmailId;
    data['ismmclT_Address'] = ismmclTAddress;
    data['ismmclT_NOName'] = ismmclTNOName;
    data['ismmclT_NOContactNo'] = ismmclTNOContactNo;
    data['ismmclT_CordinatorId'] = ismmclTCordinatorId;
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
    data['ismmclT_Desc'] = ismmclTDesc;
    data['ismmclT_NOEmailId'] = ismmclTNOEmailId;
    data['ismmclT_TeamLeadId'] = ismmclTTeamLeadId;
    data['ismmclT_GSTNO'] = ismmclTGSTNO;
    return data;
  }
}
