class JobListModel {
  dynamic type;
  List<JobListModelValues>? values;

  JobListModel({this.type, this.values});

  JobListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <JobListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(JobListModelValues.fromJson(v));
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

class JobListModelValues {
  dynamic type;
  dynamic hrmrfRId;
  dynamic hrmPId;
  dynamic hrmPPosition;
  dynamic hrmDId;
  dynamic hrmDDepartmentName;
  dynamic hrmpRId;
  dynamic hrmPName;
  dynamic hrmpTId;
  dynamic hrmpTName;
  dynamic hrmCQulaificationName;
  dynamic hrmrfRNoofPosition;
  dynamic hrmrfRSkills;
  dynamic hrmrfRJobDesc;
  dynamic hrmrfRExpFrom;
  dynamic hrmrfRExpTo;
  dynamic hrmrfRAge;
  dynamic hrmrfRMRFNO;
  dynamic ivrmmGGenderName;
  dynamic hrmrfRReason;
  dynamic hrmrfRRemark;
  bool? hrmrfRWrittenTestFlg;
  bool? hrmrfROnlineTestFlg;
  bool? hrmrfRTechnicalInterviewFlg;
  dynamic hrmrfRAttachment;
  dynamic hrmrfRCreatedBy;
  dynamic createdDate;
  dynamic hrmrfRPayScaleFrom;
  dynamic hrmrfRPayScaleTo;
  dynamic hrmrfRPositionFilled;
  dynamic hrmrfRHRComment;
  dynamic hrmrfRJobLocation;
  dynamic hrmrfRMDComment;
  dynamic hrmrfRUpdatedBy;
  dynamic hrmrfRStatus;
  bool? hrmrfRActiveFlag;
  dynamic ivrmmSId;
  dynamic ivrmmCId;

  JobListModelValues(
      {this.type,
      this.hrmrfRId,
      this.hrmPId,
      this.hrmPPosition,
      this.hrmDId,
      this.hrmDDepartmentName,
      this.hrmpRId,
      this.hrmPName,
      this.hrmpTId,
      this.hrmpTName,
      this.hrmCQulaificationName,
      this.hrmrfRNoofPosition,
      this.hrmrfRSkills,
      this.hrmrfRJobDesc,
      this.hrmrfRExpFrom,
      this.hrmrfRExpTo,
      this.hrmrfRAge,
      this.hrmrfRMRFNO,
      this.ivrmmGGenderName,
      this.hrmrfRReason,
      this.hrmrfRRemark,
      this.hrmrfRWrittenTestFlg,
      this.hrmrfROnlineTestFlg,
      this.hrmrfRTechnicalInterviewFlg,
      this.hrmrfRAttachment,
      this.hrmrfRCreatedBy,
      this.createdDate,
      this.hrmrfRPayScaleFrom,
      this.hrmrfRPayScaleTo,
      this.hrmrfRPositionFilled,
      this.hrmrfRHRComment,
      this.hrmrfRJobLocation,
      this.hrmrfRMDComment,
      this.hrmrfRUpdatedBy,
      this.hrmrfRStatus,
      this.hrmrfRActiveFlag,
      this.ivrmmSId,
      this.ivrmmCId});

  JobListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hrmrfRId = json['hrmrfR_Id'];
    hrmPId = json['hrmP_Id'];
    hrmPPosition = json['hrmP_Position'];
    hrmDId = json['hrmD_Id'];
    hrmDDepartmentName = json['hrmD_DepartmentName'];
    hrmpRId = json['hrmpR_Id'];
    hrmPName = json['hrmP_Name'];
    hrmpTId = json['hrmpT_Id'];
    hrmpTName = json['hrmpT_Name'];
    hrmCQulaificationName = json['hrmC_QulaificationName'];
    hrmrfRNoofPosition = json['hrmrfR_NoofPosition'];
    hrmrfRSkills = json['hrmrfR_Skills'];
    hrmrfRJobDesc = json['hrmrfR_JobDesc'];
    hrmrfRExpFrom = json['hrmrfR_ExpFrom'];
    hrmrfRExpTo = json['hrmrfR_ExpTo'];
    hrmrfRAge = json['hrmrfR_Age'];
    hrmrfRMRFNO = json['hrmrfR_MRFNO'];
    ivrmmGGenderName = json['ivrmmG_GenderName'];
    hrmrfRReason = json['hrmrfR_Reason'];
    hrmrfRRemark = json['hrmrfR_Remark'];
    hrmrfRWrittenTestFlg = json['hrmrfR_WrittenTestFlg'];
    hrmrfROnlineTestFlg = json['hrmrfR_OnlineTestFlg'];
    hrmrfRTechnicalInterviewFlg = json['hrmrfR_TechnicalInterviewFlg'];
    hrmrfRAttachment = json['hrmrfR_Attachment'];
    hrmrfRCreatedBy = json['hrmrfR_CreatedBy'];
    createdDate = json['createdDate'];
    hrmrfRPayScaleFrom = json['hrmrfR_PayScaleFrom'];
    hrmrfRPayScaleTo = json['hrmrfR_PayScaleTo'];
    hrmrfRPositionFilled = json['hrmrfR_PositionFilled'];
    hrmrfRHRComment = json['hrmrfR_HRComment'];
    hrmrfRJobLocation = json['hrmrfR_JobLocation'];
    hrmrfRMDComment = json['hrmrfR_MDComment'];
    hrmrfRUpdatedBy = json['hrmrfR_UpdatedBy'];
    hrmrfRStatus = json['hrmrfR_Status'];
    hrmrfRActiveFlag = json['hrmrfR_ActiveFlag'];
    ivrmmSId = json['ivrmmS_Id'];
    ivrmmCId = json['ivrmmC_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['hrmrfR_Id'] = hrmrfRId;
    data['hrmP_Id'] = hrmPId;
    data['hrmP_Position'] = hrmPPosition;
    data['hrmD_Id'] = hrmDId;
    data['hrmD_DepartmentName'] = hrmDDepartmentName;
    data['hrmpR_Id'] = hrmpRId;
    data['hrmP_Name'] = hrmPName;
    data['hrmpT_Id'] = hrmpTId;
    data['hrmpT_Name'] = hrmpTName;
    data['hrmC_QulaificationName'] = hrmCQulaificationName;
    data['hrmrfR_NoofPosition'] = hrmrfRNoofPosition;
    data['hrmrfR_Skills'] = hrmrfRSkills;
    data['hrmrfR_JobDesc'] = hrmrfRJobDesc;
    data['hrmrfR_ExpFrom'] = hrmrfRExpFrom;
    data['hrmrfR_ExpTo'] = hrmrfRExpTo;
    data['hrmrfR_Age'] = hrmrfRAge;
    data['hrmrfR_MRFNO'] = hrmrfRMRFNO;
    data['ivrmmG_GenderName'] = ivrmmGGenderName;
    data['hrmrfR_Reason'] = hrmrfRReason;
    data['hrmrfR_Remark'] = hrmrfRRemark;
    data['hrmrfR_WrittenTestFlg'] = hrmrfRWrittenTestFlg;
    data['hrmrfR_OnlineTestFlg'] = hrmrfROnlineTestFlg;
    data['hrmrfR_TechnicalInterviewFlg'] = hrmrfRTechnicalInterviewFlg;
    data['hrmrfR_Attachment'] = hrmrfRAttachment;
    data['hrmrfR_CreatedBy'] = hrmrfRCreatedBy;
    data['createdDate'] = createdDate;
    data['hrmrfR_PayScaleFrom'] = hrmrfRPayScaleFrom;
    data['hrmrfR_PayScaleTo'] = hrmrfRPayScaleTo;
    data['hrmrfR_PositionFilled'] = hrmrfRPositionFilled;
    data['hrmrfR_HRComment'] = hrmrfRHRComment;
    data['hrmrfR_JobLocation'] = hrmrfRJobLocation;
    data['hrmrfR_MDComment'] = hrmrfRMDComment;
    data['hrmrfR_UpdatedBy'] = hrmrfRUpdatedBy;
    data['hrmrfR_Status'] = hrmrfRStatus;
    data['hrmrfR_ActiveFlag'] = hrmrfRActiveFlag;
    data['ivrmmS_Id'] = ivrmmSId;
    data['ivrmmC_Id'] = ivrmmCId;
    return data;
  }
}
