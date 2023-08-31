class FeedBacksModel {
  String? type;
  List<FeedBacksModelValues>? values;

  FeedBacksModel({this.type, this.values});

  FeedBacksModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <FeedBacksModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(FeedBacksModelValues.fromJson(v));
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

class FeedBacksModelValues {
  int? asgfEId;
  int? mIId;
  int? amsTId;
  int? asmaYId;
  int? asmcLId;
  int? asmSId;
  String? asgfEFeedBack;
  String? asgfEFeedbackDate;
  bool? asgfEActiveFlag;
  int? asgfECreatedBy;
  int? asgfEUpdatedBy;
  String? createdDate;
  String? updatedDate;

  FeedBacksModelValues(
      {this.asgfEId,
      this.mIId,
      this.amsTId,
      this.asmaYId,
      this.asmcLId,
      this.asmSId,
      this.asgfEFeedBack,
      this.asgfEFeedbackDate,
      this.asgfEActiveFlag,
      this.asgfECreatedBy,
      this.asgfEUpdatedBy,
      this.createdDate,
      this.updatedDate});

  FeedBacksModelValues.fromJson(Map<String, dynamic> json) {
    asgfEId = json['asgfE_Id'];
    mIId = json['mI_Id'];
    amsTId = json['amsT_Id'];
    asmaYId = json['asmaY_Id'];
    asmcLId = json['asmcL_Id'];
    asmSId = json['asmS_Id'];
    asgfEFeedBack = json['asgfE_FeedBack'];
    asgfEFeedbackDate = json['asgfE_FeedbackDate'];
    asgfEActiveFlag = json['asgfE_ActiveFlag'];
    asgfECreatedBy = json['asgfE_CreatedBy'];
    asgfEUpdatedBy = json['asgfE_UpdatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['asgfE_Id'] = asgfEId;
    data['mI_Id'] = mIId;
    data['amsT_Id'] = amsTId;
    data['asmaY_Id'] = asmaYId;
    data['asmcL_Id'] = asmcLId;
    data['asmS_Id'] = asmSId;
    data['asgfE_FeedBack'] = asgfEFeedBack;
    data['asgfE_FeedbackDate'] = asgfEFeedbackDate;
    data['asgfE_ActiveFlag'] = asgfEActiveFlag;
    data['asgfE_CreatedBy'] = asgfECreatedBy;
    data['asgfE_UpdatedBy'] = asgfEUpdatedBy;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
