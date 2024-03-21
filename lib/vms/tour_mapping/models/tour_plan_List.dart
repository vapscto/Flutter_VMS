class TourPlanListModel {
  String? type;
  List<TourPlanListModelValues>? values;

  TourPlanListModel({this.type, this.values});

  TourPlanListModel.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <TourPlanListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add( TourPlanListModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   Map<String, dynamic>();
    data['\$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['IVRMMS_Id'] = this.iVRMMSId;
    data['ISMSLE_Id'] = this.iSMSLEId;
    data['ISMSLE_LeadName'] = this.iSMSLELeadName;
    data['ISMSLE_StudentStrength'] = this.iSMSLEStudentStrength;
    data['ISMSLE_StaffStrength'] = this.iSMSLEStaffStrength;
    data['ISMSMPR_ProductName'] = this.iSMSMPRProductName;
    data['ISMSMPR_Id'] = this.iSMSMPRId;
    data['SourceName'] = this.sourceName;
    data['IVRMMS_Name'] = this.iVRMMSName;
    data['IMRC_CategoryId'] = this.iMRCCategoryId;
    data['IMRC_CategoryName'] = this.iMRCCategoryName;
    data['IER_ID'] = this.iERID;
    data['ismsledM_Status_Flg'] = this.ismsledMStatusFlg;
    data['ISMSLEDM_Id'] = this.iSMSLEDMId;
    data['IERC_ID'] = this.iERCID;
    return data;
  }
}
