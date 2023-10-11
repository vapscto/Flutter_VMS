class CategoryWisePlanModel {
  String? type;
  List<CategoryWisePlanModelValues>? values;

  CategoryWisePlanModel({this.type, this.values});

  CategoryWisePlanModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CategoryWisePlanModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CategoryWisePlanModelValues.fromJson(v));
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

class CategoryWisePlanModelValues {
  bool? returnval;
  bool? alreadyCnt;
  int? userId;
  int? ismmaCId;
  int? mIId;
  int? completdcount;
  int? ivrmrTId;
  int? asmaYId;
  int? hrmDId;
  int? ismmpRId;
  int? hrmEId;
  int? ivrmMId;
  int? ismmmDId;
  int? ismtcRId;
  int? hrmpRId;
  bool? ismtcRReOpenFlg;
  bool? ismtcRActiveFlg;
  int? ivrMMonthId;
  int? ismtcrastOId;
  String? ismtcrastOAssignedDate;
  int? ismtcrastOAssignedBy;
  double? ismtcrastOEffortInHrs;
  bool? ismtcrastOActiveFlg;
  int? ismtpltAId;
  int? ismtpLId;
  double? ismtpltAEffortInHrs;
  bool? ismtpltADeviationFlg;
  bool? ismtpltAExtraFlg;
  double? ismtpltATimeTakenInHrs;
  bool? ismtpltAActiveFlg;
  int? ismtpltACreatedBy;
  int? ismtpltAUpdatedBy;
  int? ismtpLPlannedBy;
  double? ismtpLTotalHrs;
  int? ismtpLApprovedBy;
  bool? ismtpLActiveFlg;
  bool? ismtpltAApprovalFlg;
  int? ismtpLCreatedBy;
  int? ismtpLUpdatedBy;
  String? plannerMaxdate;
  bool? ismtplaPActiveFlg;
  int? ismtplaPCreatedBy;
  int? ismtplaPUpdatedBy;
  int? ismtplaptAId;
  double? ismtplaptAEffortInHrs;
  bool? ismtplaptADeviationFlg;
  bool? ismtplaptAExtraTaskFlg;
  double? ismtplaptATimeTakenInHrs;
  bool? ismtplaptAUnPlannedFlg;
  bool? ismtplaptAActiveFlg;
  int? ismtplaptACreatedBy;
  int? ismtplaptAUpdatedBy;
  bool? flgapproved;
  int? extraflag;
  bool? plannerextapproval;
  int? ismmtcaTId;
  String? ismmtcaTTaskCategoryName;
  double? ismmtcaTTaskPercentage;
  String? ismmtcaTEachTaskMaxDuration;
  String? ismmtcaTDurationFlg;
  bool? ismmtcaTCompulsoryFlg;

  CategoryWisePlanModelValues(
      {this.returnval,
      this.alreadyCnt,
      this.userId,
      this.ismmaCId,
      this.mIId,
      this.completdcount,
      this.ivrmrTId,
      this.asmaYId,
      this.hrmDId,
      this.ismmpRId,
      this.hrmEId,
      this.ivrmMId,
      this.ismmmDId,
      this.ismtcRId,
      this.hrmpRId,
      this.ismtcRReOpenFlg,
      this.ismtcRActiveFlg,
      this.ivrMMonthId,
      this.ismtcrastOId,
      this.ismtcrastOAssignedDate,
      this.ismtcrastOAssignedBy,
      this.ismtcrastOEffortInHrs,
      this.ismtcrastOActiveFlg,
      this.ismtpltAId,
      this.ismtpLId,
      this.ismtpltAEffortInHrs,
      this.ismtpltADeviationFlg,
      this.ismtpltAExtraFlg,
      this.ismtpltATimeTakenInHrs,
      this.ismtpltAActiveFlg,
      this.ismtpltACreatedBy,
      this.ismtpltAUpdatedBy,
      this.ismtpLPlannedBy,
      this.ismtpLTotalHrs,
      this.ismtpLApprovedBy,
      this.ismtpLActiveFlg,
      this.ismtpltAApprovalFlg,
      this.ismtpLCreatedBy,
      this.ismtpLUpdatedBy,
      this.plannerMaxdate,
      this.ismtplaPActiveFlg,
      this.ismtplaPCreatedBy,
      this.ismtplaPUpdatedBy,
      this.ismtplaptAId,
      this.ismtplaptAEffortInHrs,
      this.ismtplaptADeviationFlg,
      this.ismtplaptAExtraTaskFlg,
      this.ismtplaptATimeTakenInHrs,
      this.ismtplaptAUnPlannedFlg,
      this.ismtplaptAActiveFlg,
      this.ismtplaptACreatedBy,
      this.ismtplaptAUpdatedBy,
      this.flgapproved,
      this.extraflag,
      this.plannerextapproval,
      this.ismmtcaTId,
      this.ismmtcaTTaskCategoryName,
      this.ismmtcaTTaskPercentage,
      this.ismmtcaTEachTaskMaxDuration,
      this.ismmtcaTDurationFlg,
      this.ismmtcaTCompulsoryFlg});

  CategoryWisePlanModelValues.fromJson(Map<String, dynamic> json) {
    returnval = json['returnval'];
    alreadyCnt = json['already_cnt'];
    userId = json['userId'];
    ismmaCId = json['ismmaC_Id'];
    mIId = json['mI_Id'];
    completdcount = json['completdcount'];
    ivrmrTId = json['ivrmrT_Id'];
    asmaYId = json['asmaY_Id'];
    hrmDId = json['hrmD_Id'];
    ismmpRId = json['ismmpR_Id'];
    hrmEId = json['hrmE_Id'];
    ivrmMId = json['ivrmM_Id'];
    ismmmDId = json['ismmmD_Id'];
    ismtcRId = json['ismtcR_Id'];
    hrmpRId = json['hrmpR_Id'];
    ismtcRReOpenFlg = json['ismtcR_ReOpenFlg'];
    ismtcRActiveFlg = json['ismtcR_ActiveFlg'];
    ivrMMonthId = json['ivrM_Month_Id'];
    ismtcrastOId = json['ismtcrastO_Id'];
    ismtcrastOAssignedDate = json['ismtcrastO_AssignedDate'];
    ismtcrastOAssignedBy = json['ismtcrastO_AssignedBy'];
    ismtcrastOEffortInHrs = json['ismtcrastO_EffortInHrs'];
    ismtcrastOActiveFlg = json['ismtcrastO_ActiveFlg'];
    ismtpltAId = json['ismtpltA_Id'];
    ismtpLId = json['ismtpL_Id'];
    ismtpltAEffortInHrs = json['ismtpltA_EffortInHrs'];
    ismtpltADeviationFlg = json['ismtpltA_DeviationFlg'];
    ismtpltAExtraFlg = json['ismtpltA_ExtraFlg'];
    ismtpltATimeTakenInHrs = json['ismtpltA_TimeTakenInHrs'];
    ismtpltAActiveFlg = json['ismtpltA_ActiveFlg'];
    ismtpltACreatedBy = json['ismtpltA_CreatedBy'];
    ismtpltAUpdatedBy = json['ismtpltA_UpdatedBy'];
    ismtpLPlannedBy = json['ismtpL_PlannedBy'];
    ismtpLTotalHrs = json['ismtpL_TotalHrs'];
    ismtpLApprovedBy = json['ismtpL_ApprovedBy'];
    ismtpLActiveFlg = json['ismtpL_ActiveFlg'];
    ismtpltAApprovalFlg = json['ismtpltA_ApprovalFlg'];
    ismtpLCreatedBy = json['ismtpL_CreatedBy'];
    ismtpLUpdatedBy = json['ismtpL_UpdatedBy'];
    plannerMaxdate = json['plannerMaxdate'];
    ismtplaPActiveFlg = json['ismtplaP_ActiveFlg'];
    ismtplaPCreatedBy = json['ismtplaP_CreatedBy'];
    ismtplaPUpdatedBy = json['ismtplaP_UpdatedBy'];
    ismtplaptAId = json['ismtplaptA_Id'];
    ismtplaptAEffortInHrs = json['ismtplaptA_EffortInHrs'];
    ismtplaptADeviationFlg = json['ismtplaptA_DeviationFlg'];
    ismtplaptAExtraTaskFlg = json['ismtplaptA_ExtraTaskFlg'];
    ismtplaptATimeTakenInHrs = json['ismtplaptA_TimeTakenInHrs'];
    ismtplaptAUnPlannedFlg = json['ismtplaptA_UnPlannedFlg'];
    ismtplaptAActiveFlg = json['ismtplaptA_ActiveFlg'];
    ismtplaptACreatedBy = json['ismtplaptA_CreatedBy'];
    ismtplaptAUpdatedBy = json['ismtplaptA_UpdatedBy'];
    flgapproved = json['flgapproved'];
    extraflag = json['extraflag'];
    plannerextapproval = json['plannerextapproval'];
    ismmtcaTId = json['ismmtcaT_Id'];
    ismmtcaTTaskCategoryName = json['ismmtcaT_TaskCategoryName'];
    ismmtcaTTaskPercentage = json['ismmtcaT_TaskPercentage'];
    ismmtcaTEachTaskMaxDuration = json['ismmtcaT_EachTaskMaxDuration'];
    ismmtcaTDurationFlg = json['ismmtcaT_DurationFlg'];
    ismmtcaTCompulsoryFlg = json['ismmtcaT_CompulsoryFlg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['returnval'] = returnval;
    data['already_cnt'] = alreadyCnt;
    data['userId'] = userId;
    data['ismmaC_Id'] = ismmaCId;
    data['mI_Id'] = mIId;
    data['completdcount'] = completdcount;
    data['ivrmrT_Id'] = ivrmrTId;
    data['asmaY_Id'] = asmaYId;
    data['hrmD_Id'] = hrmDId;
    data['ismmpR_Id'] = ismmpRId;
    data['hrmE_Id'] = hrmEId;
    data['ivrmM_Id'] = ivrmMId;
    data['ismmmD_Id'] = ismmmDId;
    data['ismtcR_Id'] = ismtcRId;
    data['hrmpR_Id'] = hrmpRId;
    data['ismtcR_ReOpenFlg'] = ismtcRReOpenFlg;
    data['ismtcR_ActiveFlg'] = ismtcRActiveFlg;
    data['ivrM_Month_Id'] = ivrMMonthId;
    data['ismtcrastO_Id'] = ismtcrastOId;
    data['ismtcrastO_AssignedDate'] = ismtcrastOAssignedDate;
    data['ismtcrastO_AssignedBy'] = ismtcrastOAssignedBy;
    data['ismtcrastO_EffortInHrs'] = ismtcrastOEffortInHrs;
    data['ismtcrastO_ActiveFlg'] = ismtcrastOActiveFlg;
    data['ismtpltA_Id'] = ismtpltAId;
    data['ismtpL_Id'] = ismtpLId;
    data['ismtpltA_EffortInHrs'] = ismtpltAEffortInHrs;
    data['ismtpltA_DeviationFlg'] = ismtpltADeviationFlg;
    data['ismtpltA_ExtraFlg'] = ismtpltAExtraFlg;
    data['ismtpltA_TimeTakenInHrs'] = ismtpltATimeTakenInHrs;
    data['ismtpltA_ActiveFlg'] = ismtpltAActiveFlg;
    data['ismtpltA_CreatedBy'] = ismtpltACreatedBy;
    data['ismtpltA_UpdatedBy'] = ismtpltAUpdatedBy;
    data['ismtpL_PlannedBy'] = ismtpLPlannedBy;
    data['ismtpL_TotalHrs'] = ismtpLTotalHrs;
    data['ismtpL_ApprovedBy'] = ismtpLApprovedBy;
    data['ismtpL_ActiveFlg'] = ismtpLActiveFlg;
    data['ismtpltA_ApprovalFlg'] = ismtpltAApprovalFlg;
    data['ismtpL_CreatedBy'] = ismtpLCreatedBy;
    data['ismtpL_UpdatedBy'] = ismtpLUpdatedBy;
    data['plannerMaxdate'] = plannerMaxdate;
    data['ismtplaP_ActiveFlg'] = ismtplaPActiveFlg;
    data['ismtplaP_CreatedBy'] = ismtplaPCreatedBy;
    data['ismtplaP_UpdatedBy'] = ismtplaPUpdatedBy;
    data['ismtplaptA_Id'] = ismtplaptAId;
    data['ismtplaptA_EffortInHrs'] = ismtplaptAEffortInHrs;
    data['ismtplaptA_DeviationFlg'] = ismtplaptADeviationFlg;
    data['ismtplaptA_ExtraTaskFlg'] = ismtplaptAExtraTaskFlg;
    data['ismtplaptA_TimeTakenInHrs'] = ismtplaptATimeTakenInHrs;
    data['ismtplaptA_UnPlannedFlg'] = ismtplaptAUnPlannedFlg;
    data['ismtplaptA_ActiveFlg'] = ismtplaptAActiveFlg;
    data['ismtplaptA_CreatedBy'] = ismtplaptACreatedBy;
    data['ismtplaptA_UpdatedBy'] = ismtplaptAUpdatedBy;
    data['flgapproved'] = flgapproved;
    data['extraflag'] = extraflag;
    data['plannerextapproval'] = plannerextapproval;
    data['ismmtcaT_Id'] = ismmtcaTId;
    data['ismmtcaT_TaskCategoryName'] = ismmtcaTTaskCategoryName;
    data['ismmtcaT_TaskPercentage'] = ismmtcaTTaskPercentage;
    data['ismmtcaT_EachTaskMaxDuration'] = ismmtcaTEachTaskMaxDuration;
    data['ismmtcaT_DurationFlg'] = ismmtcaTDurationFlg;
    data['ismmtcaT_CompulsoryFlg'] = ismmtcaTCompulsoryFlg;
    return data;
  }
}
