class TourPlanListModel {
  String? type;
  List<TourPlanListModelValues>? values;

  TourPlanListModel({this.type, this.values});

  TourPlanListModel.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <TourPlanListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TourPlanListModelValues.fromJson(v));
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

class TourPlanListModelValues {
  String? type;
  int? iVRMMSId;
  int? iSMSLEId;
  String? iSMSLELeadName;
  int? iSMSLEStudentStrength;
  int? iSMSLEStaffStrength;
  String? iSMSMPRProductName;
  int? iSMSMPRId;
  String? sourceName;
  String? iVRMMSName;
  int? iMRCCategoryId;
  String? iMRCCategoryName;
  int? iERID;
  int? ismsledMStatusFlg;
  int? iSMSLEDMId;
  int? iERCID;

  TourPlanListModelValues(
      {this.type,
      this.iVRMMSId,
      this.iSMSLEId,
      this.iSMSLELeadName,
      this.iSMSLEStudentStrength,
      this.iSMSLEStaffStrength,
      this.iSMSMPRProductName,
      this.iSMSMPRId,
      this.sourceName,
      this.iVRMMSName,
      this.iMRCCategoryId,
      this.iMRCCategoryName,
      this.iERID,
      this.ismsledMStatusFlg,
      this.iSMSLEDMId,
      this.iERCID});

  TourPlanListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iVRMMSId = json['IVRMMS_Id'];
    iSMSLEId = json['ISMSLE_Id'];
    iSMSLELeadName = json['ISMSLE_LeadName'];
    iSMSLEStudentStrength = json['ISMSLE_StudentStrength'];
    iSMSLEStaffStrength = json['ISMSLE_StaffStrength'];
    iSMSMPRProductName = json['ISMSMPR_ProductName'];
    iSMSMPRId = json['ISMSMPR_Id'];
    sourceName = json['SourceName'];
    iVRMMSName = json['IVRMMS_Name'];
    iMRCCategoryId = json['IMRC_CategoryId'];
    iMRCCategoryName = json['IMRC_CategoryName'];
    iERID = json['IER_ID'];
    ismsledMStatusFlg = json['ismsledM_Status_Flg'];
    iSMSLEDMId = json['ISMSLEDM_Id'];
    iERCID = json['IERC_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['IVRMMS_Id'] = iVRMMSId;
    data['ISMSLE_Id'] = iSMSLEId;
    data['ISMSLE_LeadName'] = iSMSLELeadName;
    data['ISMSLE_StudentStrength'] = iSMSLEStudentStrength;
    data['ISMSLE_StaffStrength'] = iSMSLEStaffStrength;
    data['ISMSMPR_ProductName'] = iSMSMPRProductName;
    data['ISMSMPR_Id'] = iSMSMPRId;
    data['SourceName'] = sourceName;
    data['IVRMMS_Name'] = iVRMMSName;
    data['IMRC_CategoryId'] = iMRCCategoryId;
    data['IMRC_CategoryName'] = iMRCCategoryName;
    data['IER_ID'] = iERID;
    data['ismsledM_Status_Flg'] = ismsledMStatusFlg;
    data['ISMSLEDM_Id'] = iSMSLEDMId;
    data['IERC_ID'] = iERCID;
    return data;
  }
}
