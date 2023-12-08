class CreatedTaskListModel {
  String? type;
  List<CreatedTaskListModelValues>? values;

  CreatedTaskListModel({this.type, this.values});

  CreatedTaskListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CreatedTaskListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CreatedTaskListModelValues.fromJson(v));
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

class CreatedTaskListModelValues {
  String? type;
  int? iSMTCRId;
  String? iSMTCRTaskNo;
  int? hRMDId;
  String? hRMDDepartmentName;
  int? hRMPRId;
  String? hRMPName;
  String? iSMTCRBugOREnhancementFlg;
  String? iSMTCRCreationDate;
  String? iSMTCRTitle;
  String? iSMTCRDesc;
  String? iSMTCRStatus;
  bool? iSMTCRReOpenFlg;
  String? iSMTCRReOpenDate;
  bool? iSMTCRActiveFlg;
  String? iSMMCLTClientName;
  String? iVRMMModuleName;
  String? iSMMTCATTaskCategoryName;

  CreatedTaskListModelValues(
      {this.type,
      this.iSMTCRId,
      this.iSMTCRTaskNo,
      this.hRMDId,
      this.hRMDDepartmentName,
      this.hRMPRId,
      this.hRMPName,
      this.iSMTCRBugOREnhancementFlg,
      this.iSMTCRCreationDate,
      this.iSMTCRTitle,
      this.iSMTCRDesc,
      this.iSMTCRStatus,
      this.iSMTCRReOpenFlg,
      this.iSMTCRReOpenDate,
      this.iSMTCRActiveFlg,
      this.iSMMCLTClientName,
      this.iVRMMModuleName,
      this.iSMMTCATTaskCategoryName});

  CreatedTaskListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMTCRId = json['ISMTCR_Id'];
    iSMTCRTaskNo = json['ISMTCR_TaskNo'];
    hRMDId = json['HRMD_Id'];
    hRMDDepartmentName = json['HRMD_DepartmentName'];
    hRMPRId = json['HRMPR_Id'];
    hRMPName = json['HRMP_Name'];
    iSMTCRBugOREnhancementFlg = json['ISMTCR_BugOREnhancementFlg'];
    iSMTCRCreationDate = json['ISMTCR_CreationDate'];
    iSMTCRTitle = json['ISMTCR_Title'];
    iSMTCRDesc = json['ISMTCR_Desc'];
    iSMTCRStatus = json['ISMTCR_Status'];
    iSMTCRReOpenFlg = json['ISMTCR_ReOpenFlg'];
    iSMTCRReOpenDate = json['ISMTCR_ReOpenDate'];
    iSMTCRActiveFlg = json['ISMTCR_ActiveFlg'];
    iSMMCLTClientName = json['ISMMCLT_ClientName'];
    iVRMMModuleName = json['IVRMM_ModuleName'];
    iSMMTCATTaskCategoryName = json['ISMMTCAT_TaskCategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMTCR_Id'] = iSMTCRId;
    data['ISMTCR_TaskNo'] = iSMTCRTaskNo;
    data['HRMD_Id'] = hRMDId;
    data['HRMD_DepartmentName'] = hRMDDepartmentName;
    data['HRMPR_Id'] = hRMPRId;
    data['HRMP_Name'] = hRMPName;
    data['ISMTCR_BugOREnhancementFlg'] = iSMTCRBugOREnhancementFlg;
    data['ISMTCR_CreationDate'] = iSMTCRCreationDate;
    data['ISMTCR_Title'] = iSMTCRTitle;
    data['ISMTCR_Desc'] = iSMTCRDesc;
    data['ISMTCR_Status'] = iSMTCRStatus;
    data['ISMTCR_ReOpenFlg'] = iSMTCRReOpenFlg;
    data['ISMTCR_ReOpenDate'] = iSMTCRReOpenDate;
    data['ISMTCR_ActiveFlg'] = iSMTCRActiveFlg;
    data['ISMMCLT_ClientName'] = iSMMCLTClientName;
    data['IVRMM_ModuleName'] = iVRMMModuleName;
    data['ISMMTCAT_TaskCategoryName'] = iSMMTCATTaskCategoryName;
    return data;
  }
}
