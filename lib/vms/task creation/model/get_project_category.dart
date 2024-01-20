class GeTskProjects {
  String? type;
  List<GeTskProjectsValues>? values;

  GeTskProjects({this.type, this.values});

  GeTskProjects.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GeTskProjectsValues>[];
      json['\$values'].forEach((v) {
        values!.add(GeTskProjectsValues.fromJson(v));
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

class GeTskProjectsValues {
  int? ismmcltpRId;
  int? ismmclTId;
  int? ismmmDId;
  int? ismmpRId;
  int? ismmmDModuleHeadId;
  bool? ismmcltpRActiveFlag;
  bool? moduleActiveFlag;
  int? ismmcltpRCreatedBy;
  int? ismmcltpRUpdatedBy;
  int? mIId;
  int? hrmDId;
  String? ismmpRProjectName;
  String? createdDate;
  String? updatedDate;
  int? createdBy;
  int? updatedBy;
  bool? activeFlag;
  int? ivrmMId;
  bool? duplicate;
  int? userId;
  bool? returnval;
  int? projectid;

  GeTskProjectsValues(
      {this.ismmcltpRId,
      this.ismmclTId,
      this.ismmmDId,
      this.ismmpRId,
      this.ismmmDModuleHeadId,
      this.ismmcltpRActiveFlag,
      this.moduleActiveFlag,
      this.ismmcltpRCreatedBy,
      this.ismmcltpRUpdatedBy,
      this.mIId,
      this.hrmDId,
      this.ismmpRProjectName,
      this.createdDate,
      this.updatedDate,
      this.createdBy,
      this.updatedBy,
      this.activeFlag,
      this.ivrmMId,
      this.duplicate,
      this.userId,
      this.returnval,
      this.projectid});

  GeTskProjectsValues.fromJson(Map<String, dynamic> json) {
    ismmcltpRId = json['ismmcltpR_Id'];
    ismmclTId = json['ismmclT_Id'];
    ismmmDId = json['ismmmD_Id'];
    ismmpRId = json['ismmpR_Id'];
    ismmmDModuleHeadId = json['ismmmD_ModuleHeadId'];
    ismmcltpRActiveFlag = json['ismmcltpR_ActiveFlag'];
    moduleActiveFlag = json['module_ActiveFlag'];
    ismmcltpRCreatedBy = json['ismmcltpR_CreatedBy'];
    ismmcltpRUpdatedBy = json['ismmcltpR_UpdatedBy'];
    mIId = json['mI_Id'];
    hrmDId = json['hrmD_Id'];
    ismmpRProjectName = json['ismmpR_ProjectName'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    activeFlag = json['active_Flag'];
    ivrmMId = json['ivrmM_Id'];
    duplicate = json['duplicate'];
    userId = json['userId'];
    returnval = json['returnval'];
    projectid = json['projectid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ismmcltpR_Id'] = ismmcltpRId;
    data['ismmclT_Id'] = ismmclTId;
    data['ismmmD_Id'] = ismmmDId;
    data['ismmpR_Id'] = ismmpRId;
    data['ismmmD_ModuleHeadId'] = ismmmDModuleHeadId;
    data['ismmcltpR_ActiveFlag'] = ismmcltpRActiveFlag;
    data['module_ActiveFlag'] = moduleActiveFlag;
    data['ismmcltpR_CreatedBy'] = ismmcltpRCreatedBy;
    data['ismmcltpR_UpdatedBy'] = ismmcltpRUpdatedBy;
    data['mI_Id'] = mIId;
    data['hrmD_Id'] = hrmDId;
    data['ismmpR_ProjectName'] = ismmpRProjectName;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['active_Flag'] = activeFlag;
    data['ivrmM_Id'] = ivrmMId;
    data['duplicate'] = duplicate;
    data['userId'] = userId;
    data['returnval'] = returnval;
    data['projectid'] = projectid;
    return data;
  }
}

class GeTskCategory {
  String? type;
  List<GeTskCategoryValues>? values;

  GeTskCategory({this.type, this.values});

  GeTskCategory.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GeTskCategoryValues>[];
      json['\$values'].forEach((v) {
        values!.add(GeTskCategoryValues.fromJson(v));
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

class GeTskCategoryValues {
  int? ismmtcaTId;
  int? mIId;
  int? hrmDId;
  String? ismmtcaTTaskCategoryName;
  double? ismmtcaTTaskPercentage;
  String? ismmtcaTTCRemarks;
  bool? ismmtcaTActiveFlag;
  int? ismmtcaTCreatedBy;
  int? ismmtcaTUpdatedBy;
  String? ismmtcaTCreatedDate;
  String? ismmtcaTUpdatedDate;
  String? ismmtcaTDurationFlg;
  bool? ismmtcaTCompulsoryFlg;
  String? ismmtcaTEachTaskMaxDuration;

  GeTskCategoryValues(
      {this.ismmtcaTId,
      this.mIId,
      this.hrmDId,
      this.ismmtcaTTaskCategoryName,
      this.ismmtcaTTaskPercentage,
      this.ismmtcaTTCRemarks,
      this.ismmtcaTActiveFlag,
      this.ismmtcaTCreatedBy,
      this.ismmtcaTUpdatedBy,
      this.ismmtcaTCreatedDate,
      this.ismmtcaTUpdatedDate,
      this.ismmtcaTDurationFlg,
      this.ismmtcaTCompulsoryFlg,
      this.ismmtcaTEachTaskMaxDuration});

  GeTskCategoryValues.fromJson(Map<String, dynamic> json) {
    ismmtcaTId = json['ismmtcaT_Id'];
    mIId = json['mI_Id'];
    hrmDId = json['hrmD_Id'];
    ismmtcaTTaskCategoryName = json['ismmtcaT_TaskCategoryName'];
    ismmtcaTTaskPercentage = json['ismmtcaT_TaskPercentage'];
    ismmtcaTTCRemarks = json['ismmtcaT_TCRemarks'];
    ismmtcaTActiveFlag = json['ismmtcaT_ActiveFlag'];
    ismmtcaTCreatedBy = json['ismmtcaT_CreatedBy'];
    ismmtcaTUpdatedBy = json['ismmtcaT_UpdatedBy'];
    ismmtcaTCreatedDate = json['ismmtcaT_CreatedDate'];
    ismmtcaTUpdatedDate = json['ismmtcaT_UpdatedDate'];
    ismmtcaTDurationFlg = json['ismmtcaT_DurationFlg'];
    ismmtcaTCompulsoryFlg = json['ismmtcaT_CompulsoryFlg'];
    ismmtcaTEachTaskMaxDuration = json['ismmtcaT_EachTaskMaxDuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ismmtcaT_Id'] = ismmtcaTId;
    data['mI_Id'] = mIId;
    data['hrmD_Id'] = hrmDId;
    data['ismmtcaT_TaskCategoryName'] = ismmtcaTTaskCategoryName;
    data['ismmtcaT_TaskPercentage'] = ismmtcaTTaskPercentage;
    data['ismmtcaT_TCRemarks'] = ismmtcaTTCRemarks;
    data['ismmtcaT_ActiveFlag'] = ismmtcaTActiveFlag;
    data['ismmtcaT_CreatedBy'] = ismmtcaTCreatedBy;
    data['ismmtcaT_UpdatedBy'] = ismmtcaTUpdatedBy;
    data['ismmtcaT_CreatedDate'] = ismmtcaTCreatedDate;
    data['ismmtcaT_UpdatedDate'] = ismmtcaTUpdatedDate;
    data['ismmtcaT_DurationFlg'] = ismmtcaTDurationFlg;
    data['ismmtcaT_CompulsoryFlg'] = ismmtcaTCompulsoryFlg;
    data['ismmtcaT_EachTaskMaxDuration'] = ismmtcaTEachTaskMaxDuration;
    return data;
  }
}
