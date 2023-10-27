class ClientListModel {
  String? type;
  List<ClientListModelValues>? values;

  ClientListModel({this.type, this.values});

  ClientListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ClientListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new ClientListModelValues.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ismmclT_Id'] = this.ismmclTId;
    data['mI_Id'] = this.mIId;
    data['ismmclT_ClientName'] = this.ismmclTClientName;
    data['ismmclT_ContactNo'] = this.ismmclTContactNo;
    data['ismmclT_EmailId'] = this.ismmclTEmailId;
    data['ismmclT_Address'] = this.ismmclTAddress;
    data['ismmclT_NOName'] = this.ismmclTNOName;
    data['ismmclT_NOContactNo'] = this.ismmclTNOContactNo;
    data['ismmclT_CordinatorId'] = this.ismmclTCordinatorId;
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
    data['ismmclT_Desc'] = this.ismmclTDesc;
    data['ismmclT_NOEmailId'] = this.ismmclTNOEmailId;
    data['ismmclT_TeamLeadId'] = this.ismmclTTeamLeadId;
    data['ismmclT_GSTNO'] = this.ismmclTGSTNO;
    return data;
  }
}
