import 'package:m_skool_flutter/student/feedback/model/get_feed_model.dart';
import 'package:m_skool_flutter/student/feedback/model/ins_detail_model.dart';

class FeedbackDetailsModel {
  bool? returnval;
  int? mIId;
  int? asgfEId;
  int? amsTId;
  int? asmaYId;
  int? asmcLId;
  int? asmSId;
  bool? asgfEActiveFlag;
  int? asgfECreatedBy;
  int? asgfEUpdatedBy;
  InsDetailModel? instname;
  FeedBacksModel? getFeedback;

  FeedbackDetailsModel(
      {this.returnval,
      this.mIId,
      this.asgfEId,
      this.amsTId,
      this.asmaYId,
      this.asmcLId,
      this.asmSId,
      this.asgfEActiveFlag,
      this.asgfECreatedBy,
      this.asgfEUpdatedBy,
      this.instname,
      this.getFeedback});

  FeedbackDetailsModel.fromJson(Map<String, dynamic> json) {
    returnval = json['returnval'];
    mIId = json['mI_Id'];
    asgfEId = json['asgfE_Id'];
    amsTId = json['amsT_Id'];
    asmaYId = json['asmaY_Id'];
    asmcLId = json['asmcL_Id'];
    asmSId = json['asmS_Id'];
    asgfEActiveFlag = json['asgfE_ActiveFlag'];
    asgfECreatedBy = json['asgfE_CreatedBy'];
    asgfEUpdatedBy = json['asgfE_UpdatedBy'];
    instname = json['instname'] != null
        ? InsDetailModel.fromJson(json['instname'])
        : null;
    getFeedback = json['get_feedback'] != null
        ? FeedBacksModel.fromJson(json['get_feedback'])
        : null;
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
    data['asgfE_ActiveFlag'] = asgfEActiveFlag;
    data['asgfE_CreatedBy'] = asgfECreatedBy;
    data['asgfE_UpdatedBy'] = asgfEUpdatedBy;
    if (instname != null) {
      data['instname'] = instname!.toJson();
    }
    if (getFeedback != null) {
      data['get_feedback'] = getFeedback!.toJson();
    }
    return data;
  }
}
