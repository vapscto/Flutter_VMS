class GradeListModel {
  String? type;
  List<GradeListModelValues>? values;

  GradeListModel({this.type, this.values});

  GradeListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GradeListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(GradeListModelValues.fromJson(v));
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

class GradeListModelValues {
  dynamic hrcDId;
  dynamic mIId;
  dynamic hrmpTId;
  dynamic hrmCId;
  dynamic hrmEId;
  dynamic hrcDMRFNO;
  dynamic hrmJId;
  String? hrcDDOB;
  dynamic ivrmmGId;
  dynamic hrcDMobileNo;
  dynamic hrcDExpFrom;
  dynamic hrcDExpTo;
  dynamic hrcDLastCTC;
  dynamic hrcDExpectedCTC;
  String? hrcDAppDate;
  String? hrcDInterviewDate;
  String? hrcDExitDate;
  dynamic hrcDNoticePeriod;
  bool? hrcDActiveFlg;
  dynamic hrcDCreatedBy;
  dynamic hrcDUpdatedBy;
  dynamic hrmEID;
  bool? candidateflage;
  dynamic hrmDId;
  dynamic hrmdeSId;
  dynamic hrmeDId;
  dynamic hrmedTId;
  bool? hrmeDActiveFlag;
  dynamic hrmeDOrder;
  dynamic hrceDId;
  dynamic hrceDAmount;
  bool? hrceDActiveFlag;
  dynamic hrmGId;
  String? hrmGGradeName;
  String? hrcisCInterviewDateTime;
  dynamic casteCategoryId;
  dynamic casteId;
  dynamic religionId;
  dynamic userId;
  dynamic hrcDNationalityId;
  dynamic hrcDReligion;
  dynamic hrcDMaritalStatus;
  dynamic hrcDCasteId;
  bool? welcomenotice;
  bool? thanksnotice;
  dynamic hrcDAddLocalPIN;
  dynamic hrcDAddPermanentPIN;
  bool? hrcDDocSubmitFlag;
  dynamic hrcAAnnualCTC;
  dynamic hrcAMonthlyCTC;
  dynamic hrcAId;
  dynamic hrmPId;

  GradeListModelValues(
      {this.hrcDId,
      this.mIId,
      this.hrmpTId,
      this.hrmCId,
      this.hrmEId,
      this.hrcDMRFNO,
      this.hrmJId,
      this.hrcDDOB,
      this.ivrmmGId,
      this.hrcDMobileNo,
      this.hrcDExpFrom,
      this.hrcDExpTo,
      this.hrcDLastCTC,
      this.hrcDExpectedCTC,
      this.hrcDAppDate,
      this.hrcDInterviewDate,
      this.hrcDExitDate,
      this.hrcDNoticePeriod,
      this.hrcDActiveFlg,
      this.hrcDCreatedBy,
      this.hrcDUpdatedBy,
      this.hrmEID,
      this.candidateflage,
      this.hrmDId,
      this.hrmdeSId,
      this.hrmeDId,
      this.hrmedTId,
      this.hrmeDActiveFlag,
      this.hrmeDOrder,
      this.hrceDId,
      this.hrceDAmount,
      this.hrceDActiveFlag,
      this.hrmGId,
      this.hrmGGradeName,
      this.hrcisCInterviewDateTime,
      this.casteCategoryId,
      this.casteId,
      this.religionId,
      this.userId,
      this.hrcDNationalityId,
      this.hrcDReligion,
      this.hrcDMaritalStatus,
      this.hrcDCasteId,
      this.welcomenotice,
      this.thanksnotice,
      this.hrcDAddLocalPIN,
      this.hrcDAddPermanentPIN,
      this.hrcDDocSubmitFlag,
      this.hrcAAnnualCTC,
      this.hrcAMonthlyCTC,
      this.hrcAId,
      this.hrmPId});

  GradeListModelValues.fromJson(Map<String, dynamic> json) {
    hrcDId = json['hrcD_Id'];
    mIId = json['mI_Id'];
    hrmpTId = json['hrmpT_Id'];
    hrmCId = json['hrmC_Id'];
    hrmEId = json['hrmE_Id'];
    hrcDMRFNO = json['hrcD_MRFNO'];
    hrmJId = json['hrmJ_Id'];
    hrcDDOB = json['hrcD_DOB'];
    ivrmmGId = json['ivrmmG_Id'];
    hrcDMobileNo = json['hrcD_MobileNo'];
    hrcDExpFrom = json['hrcD_ExpFrom'];
    hrcDExpTo = json['hrcD_ExpTo'];
    hrcDLastCTC = json['hrcD_LastCTC'];
    hrcDExpectedCTC = json['hrcD_ExpectedCTC'];
    hrcDAppDate = json['hrcD_AppDate'];
    hrcDInterviewDate = json['hrcD_InterviewDate'];
    hrcDExitDate = json['hrcD_ExitDate'];
    hrcDNoticePeriod = json['hrcD_NoticePeriod'];
    hrcDActiveFlg = json['hrcD_ActiveFlg'];
    hrcDCreatedBy = json['hrcD_CreatedBy'];
    hrcDUpdatedBy = json['hrcD_UpdatedBy'];
    hrmEID = json['hrmE_ID'];
    candidateflage = json['candidateflage'];
    hrmDId = json['hrmD_Id'];
    hrmdeSId = json['hrmdeS_Id'];
    hrmeDId = json['hrmeD_Id'];
    hrmedTId = json['hrmedT_Id'];
    hrmeDActiveFlag = json['hrmeD_ActiveFlag'];
    hrmeDOrder = json['hrmeD_Order'];
    hrceDId = json['hrceD_Id'];
    hrceDAmount = json['hrceD_Amount'];
    hrceDActiveFlag = json['hrceD_ActiveFlag'];
    hrmGId = json['hrmG_Id'];
    hrmGGradeName = json['hrmG_GradeName'];
    hrcisCInterviewDateTime = json['hrcisC_InterviewDateTime'];
    casteCategoryId = json['casteCategoryId'];
    casteId = json['casteId'];
    religionId = json['religionId'];
    userId = json['userId'];
    hrcDNationalityId = json['hrcD_NationalityId'];
    hrcDReligion = json['hrcD_Religion'];
    hrcDMaritalStatus = json['hrcD_MaritalStatus'];
    hrcDCasteId = json['hrcD_CasteId'];
    welcomenotice = json['welcomenotice'];
    thanksnotice = json['thanksnotice'];
    hrcDAddLocalPIN = json['hrcD_AddLocalPIN'];
    hrcDAddPermanentPIN = json['hrcD_AddPermanentPIN'];
    hrcDDocSubmitFlag = json['hrcD_DocSubmitFlag'];
    hrcAAnnualCTC = json['hrcA_AnnualCTC'];
    hrcAMonthlyCTC = json['hrcA_MonthlyCTC'];
    hrcAId = json['hrcA_Id'];
    hrmPId = json['hrmP_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hrcD_Id'] = hrcDId;
    data['mI_Id'] = mIId;
    data['hrmpT_Id'] = hrmpTId;
    data['hrmC_Id'] = hrmCId;
    data['hrmE_Id'] = hrmEId;
    data['hrcD_MRFNO'] = hrcDMRFNO;
    data['hrmJ_Id'] = hrmJId;
    data['hrcD_DOB'] = hrcDDOB;
    data['ivrmmG_Id'] = ivrmmGId;
    data['hrcD_MobileNo'] = hrcDMobileNo;
    data['hrcD_ExpFrom'] = hrcDExpFrom;
    data['hrcD_ExpTo'] = hrcDExpTo;
    data['hrcD_LastCTC'] = hrcDLastCTC;
    data['hrcD_ExpectedCTC'] = hrcDExpectedCTC;
    data['hrcD_AppDate'] = hrcDAppDate;
    data['hrcD_InterviewDate'] = hrcDInterviewDate;
    data['hrcD_ExitDate'] = hrcDExitDate;
    data['hrcD_NoticePeriod'] = hrcDNoticePeriod;
    data['hrcD_ActiveFlg'] = hrcDActiveFlg;
    data['hrcD_CreatedBy'] = hrcDCreatedBy;
    data['hrcD_UpdatedBy'] = hrcDUpdatedBy;
    data['hrmE_ID'] = hrmEID;
    data['candidateflage'] = candidateflage;
    data['hrmD_Id'] = hrmDId;
    data['hrmdeS_Id'] = hrmdeSId;
    data['hrmeD_Id'] = hrmeDId;
    data['hrmedT_Id'] = hrmedTId;
    data['hrmeD_ActiveFlag'] = hrmeDActiveFlag;
    data['hrmeD_Order'] = hrmeDOrder;
    data['hrceD_Id'] = hrceDId;
    data['hrceD_Amount'] = hrceDAmount;
    data['hrceD_ActiveFlag'] = hrceDActiveFlag;
    data['hrmG_Id'] = hrmGId;
    data['hrmG_GradeName'] = hrmGGradeName;
    data['hrcisC_InterviewDateTime'] = hrcisCInterviewDateTime;
    data['casteCategoryId'] = casteCategoryId;
    data['casteId'] = casteId;
    data['religionId'] = religionId;
    data['userId'] = userId;
    data['hrcD_NationalityId'] = hrcDNationalityId;
    data['hrcD_Religion'] = hrcDReligion;
    data['hrcD_MaritalStatus'] = hrcDMaritalStatus;
    data['hrcD_CasteId'] = hrcDCasteId;
    data['welcomenotice'] = welcomenotice;
    data['thanksnotice'] = thanksnotice;
    data['hrcD_AddLocalPIN'] = hrcDAddLocalPIN;
    data['hrcD_AddPermanentPIN'] = hrcDAddPermanentPIN;
    data['hrcD_DocSubmitFlag'] = hrcDDocSubmitFlag;
    data['hrcA_AnnualCTC'] = hrcAAnnualCTC;
    data['hrcA_MonthlyCTC'] = hrcAMonthlyCTC;
    data['hrcA_Id'] = hrcAId;
    data['hrmP_Id'] = hrmPId;
    return data;
  }
}
