class SearchPreviousTaskDetailsModel {
  String? type;
  List<SearchPreviousTaskDetailsModelValues>? values;

  SearchPreviousTaskDetailsModel({this.type, this.values});

  SearchPreviousTaskDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <SearchPreviousTaskDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(SearchPreviousTaskDetailsModelValues.fromJson(v));
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

class SearchPreviousTaskDetailsModelValues {
  int? ismdrptdWId;
  int? mIId;
  int? hrmEId;
  int? ismtpLId;
  int? ismtplaPId;
  String? ismdrptdWOverallComments;
  String? ismdrptdWDate;
  bool? ismdrptdWBlockedDayDRFlg;
  bool? ismdrptdWHalfDayDRFlg;
  bool? ismdrptdWActiveFlg;
  bool? ismdrptdWOrthersDateFlg;
  String? ismdrptdWOthersDateReason;
  String? ismdrptdWCreatedDate;
  String? ismdrptdWUpdatedDate;
  int? ismdrptdWCreatedBy;
  int? ismdrptdWUpdatedBy;
  double? ismdrptdWApprovedEffort;

  SearchPreviousTaskDetailsModelValues(
      {this.ismdrptdWId,
      this.mIId,
      this.hrmEId,
      this.ismtpLId,
      this.ismtplaPId,
      this.ismdrptdWOverallComments,
      this.ismdrptdWDate,
      this.ismdrptdWBlockedDayDRFlg,
      this.ismdrptdWHalfDayDRFlg,
      this.ismdrptdWActiveFlg,
      this.ismdrptdWOrthersDateFlg,
      this.ismdrptdWOthersDateReason,
      this.ismdrptdWCreatedDate,
      this.ismdrptdWUpdatedDate,
      this.ismdrptdWCreatedBy,
      this.ismdrptdWUpdatedBy,
      this.ismdrptdWApprovedEffort});

  SearchPreviousTaskDetailsModelValues.fromJson(Map<String, dynamic> json) {
    ismdrptdWId = json['ismdrptdW_Id'];
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    ismtpLId = json['ismtpL_Id'];
    ismtplaPId = json['ismtplaP_Id'];
    ismdrptdWOverallComments = json['ismdrptdW_OverallComments'];
    ismdrptdWDate = json['ismdrptdW_Date'];
    ismdrptdWBlockedDayDRFlg = json['ismdrptdW_BlockedDayDRFlg'];
    ismdrptdWHalfDayDRFlg = json['ismdrptdW_HalfDayDRFlg'];
    ismdrptdWActiveFlg = json['ismdrptdW_ActiveFlg'];
    ismdrptdWOrthersDateFlg = json['ismdrptdW_OrthersDateFlg'];
    ismdrptdWOthersDateReason = json['ismdrptdW_OthersDateReason'];
    ismdrptdWCreatedDate = json['ismdrptdW_CreatedDate'];
    ismdrptdWUpdatedDate = json['ismdrptdW_UpdatedDate'];
    ismdrptdWCreatedBy = json['ismdrptdW_CreatedBy'];
    ismdrptdWUpdatedBy = json['ismdrptdW_UpdatedBy'];
    ismdrptdWApprovedEffort = json['ismdrptdW_ApprovedEffort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ismdrptdW_Id'] = ismdrptdWId;
    data['mI_Id'] = mIId;
    data['hrmE_Id'] = hrmEId;
    data['ismtpL_Id'] = ismtpLId;
    data['ismtplaP_Id'] = ismtplaPId;
    data['ismdrptdW_OverallComments'] = ismdrptdWOverallComments;
    data['ismdrptdW_Date'] = ismdrptdWDate;
    data['ismdrptdW_BlockedDayDRFlg'] = ismdrptdWBlockedDayDRFlg;
    data['ismdrptdW_HalfDayDRFlg'] = ismdrptdWHalfDayDRFlg;
    data['ismdrptdW_ActiveFlg'] = ismdrptdWActiveFlg;
    data['ismdrptdW_OrthersDateFlg'] = ismdrptdWOrthersDateFlg;
    data['ismdrptdW_OthersDateReason'] = ismdrptdWOthersDateReason;
    data['ismdrptdW_CreatedDate'] = ismdrptdWCreatedDate;
    data['ismdrptdW_UpdatedDate'] = ismdrptdWUpdatedDate;
    data['ismdrptdW_CreatedBy'] = ismdrptdWCreatedBy;
    data['ismdrptdW_UpdatedBy'] = ismdrptdWUpdatedBy;
    data['ismdrptdW_ApprovedEffort'] = ismdrptdWApprovedEffort;
    return data;
  }
}
