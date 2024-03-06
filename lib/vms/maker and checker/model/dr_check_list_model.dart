class DrCheckListModel {
  String? type;
  List<DrCheckListModelValues>? values;

  DrCheckListModel({this.type, this.values});

  DrCheckListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DrCheckListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DrCheckListModelValues.fromJson(v));
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

class DrCheckListModelValues {
  int? mIId;
  int? ismtcRId;
  int? ismdrpTId;
  int? userId;
  int? asmaYId;
  int? ivrmrTId;
  bool? roleflag;
  bool? returnval;
  String? fromdate;
  String? previousdate;
  String? todate;
  String? ismdrptfLFileName;
  String? ismdrptfLRefNo;
  String? ismdrptfLRemarks;
  String? ismdrptfLFilePath;
  String? ismmtcatcLCheckListName;
  int? ismmtcatcLId;
  int? hrmEId;
  int? monthId;
  int? yearId;
  int? ismdrptdwmapPApprovedHRMEId;
  String? ismdrptdwmapPCreatedDate;

  DrCheckListModelValues(
      {this.mIId,
      this.ismtcRId,
      this.ismdrpTId,
      this.userId,
      this.asmaYId,
      this.ivrmrTId,
      this.roleflag,
      this.returnval,
      this.fromdate,
      this.previousdate,
      this.todate,
      this.ismdrptfLFileName,
      this.ismdrptfLRefNo,
      this.ismdrptfLRemarks,
      this.ismdrptfLFilePath,
      this.ismmtcatcLCheckListName,
      this.ismmtcatcLId,
      this.hrmEId,
      this.monthId,
      this.yearId,
      this.ismdrptdwmapPApprovedHRMEId,
      this.ismdrptdwmapPCreatedDate});

  DrCheckListModelValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    ismtcRId = json['ismtcR_Id'];
    ismdrpTId = json['ismdrpT_Id'];
    userId = json['userId'];
    asmaYId = json['asmaY_Id'];
    ivrmrTId = json['ivrmrT_Id'];
    roleflag = json['roleflag'];
    returnval = json['returnval'];
    fromdate = json['fromdate'];
    previousdate = json['previousdate'];
    todate = json['todate'];
    ismdrptfLFileName = json['ismdrptfL_FileName'];
    ismdrptfLRefNo = json['ismdrptfL_RefNo'];
    ismdrptfLRemarks = json['ismdrptfL_Remarks'];
    ismdrptfLFilePath = json['ismdrptfL_FilePath'];
    ismmtcatcLCheckListName = json['ismmtcatcL_CheckListName'];
    ismmtcatcLId = json['ismmtcatcL_Id'];
    hrmEId = json['hrmE_Id'];
    monthId = json['monthId'];
    yearId = json['yearId'];
    ismdrptdwmapPApprovedHRMEId = json['ismdrptdwmapP_ApprovedHRME_Id'];
    ismdrptdwmapPCreatedDate = json['ismdrptdwmapP_CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mI_Id'] = mIId;
    data['ismtcR_Id'] = ismtcRId;
    data['ismdrpT_Id'] = ismdrpTId;
    data['userId'] = userId;
    data['asmaY_Id'] = asmaYId;
    data['ivrmrT_Id'] = ivrmrTId;
    data['roleflag'] = roleflag;
    data['returnval'] = returnval;
    data['fromdate'] = fromdate;
    data['previousdate'] = previousdate;
    data['todate'] = todate;
    data['ismdrptfL_FileName'] = ismdrptfLFileName;
    data['ismdrptfL_RefNo'] = ismdrptfLRefNo;
    data['ismdrptfL_Remarks'] = ismdrptfLRemarks;
    data['ismdrptfL_FilePath'] = ismdrptfLFilePath;
    data['ismmtcatcL_CheckListName'] = ismmtcatcLCheckListName;
    data['ismmtcatcL_Id'] = ismmtcatcLId;
    data['hrmE_Id'] = hrmEId;
    data['monthId'] = monthId;
    data['yearId'] = yearId;
    data['ismdrptdwmapP_ApprovedHRME_Id'] = ismdrptdwmapPApprovedHRMEId;
    data['ismdrptdwmapP_CreatedDate'] = ismdrptdwmapPCreatedDate;
    return data;
  }
}
