class SubmitFeedbackModel {
  bool? returnval;
  int? mIId;
  int? asgfEId;
  int? amsTId;
  int? asmaYId;
  int? asmcLId;
  int? asmSId;
  String? asgfEFeedBack;
  bool? asgfEActiveFlag;
  int? asgfECreatedBy;
  int? asgfEUpdatedBy;

  SubmitFeedbackModel(
      {this.returnval,
      this.mIId,
      this.asgfEId,
      this.amsTId,
      this.asmaYId,
      this.asmcLId,
      this.asmSId,
      this.asgfEFeedBack,
      this.asgfEActiveFlag,
      this.asgfECreatedBy,
      this.asgfEUpdatedBy});

  SubmitFeedbackModel.fromJson(Map<String, dynamic> json) {
    returnval = json['returnval'];
    mIId = json['mI_Id'];
    asgfEId = json['asgfE_Id'];
    amsTId = json['amsT_Id'];
    asmaYId = json['asmaY_Id'];
    asmcLId = json['asmcL_Id'];
    asmSId = json['asmS_Id'];
    asgfEFeedBack = json['asgfE_FeedBack'];
    asgfEActiveFlag = json['asgfE_ActiveFlag'];
    asgfECreatedBy = json['asgfE_CreatedBy'];
    asgfEUpdatedBy = json['asgfE_UpdatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['returnval'] = returnval;
    data['mI_Id'] = mIId;
    data['asgfE_Id'] = asgfEId;
    data['amsT_Id'] = amsTId;
    data['asmaY_Id'] = asmaYId;
    data['asmcL_Id'] = asmcLId;
    data['asmS_Id'] = asmSId;
    data['asgfE_FeedBack'] = asgfEFeedBack;
    data['asgfE_ActiveFlag'] = asgfEActiveFlag;
    data['asgfE_CreatedBy'] = asgfECreatedBy;
    data['asgfE_UpdatedBy'] = asgfEUpdatedBy;
    return data;
  }
}
