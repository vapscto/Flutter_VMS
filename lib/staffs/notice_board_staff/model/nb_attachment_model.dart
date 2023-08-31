class NBAttachmentModel {
  String? type;
  List<NBAttachmentModelValues>? values;

  NBAttachmentModel({this.type, this.values});

  NBAttachmentModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <NBAttachmentModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(NBAttachmentModelValues.fromJson(v));
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

class NBAttachmentModelValues {
  bool? duplicate;
  bool? returnval;
  bool? alreadyCnt;
  bool? getclass;
  int? asmaYId;
  int? hrmdeSId;
  int? hrmEId;
  int? userId;
  int? ivrmrTId;
  int? amsTId;
  int? asmSId;
  int? intBId;
  int? mIId;
  String? intbfLFileName;
  String? intbfLFilePath;
  bool? intBDispalyDisableFlg;
  int? intbCId;
  int? asmcLId;
  bool? intbCActiveFlag;
  bool? asmcLActiveFlag;
  String? intBStartDate;
  String? intBEndDate;
  bool? intBActiveFlag;
  bool? feeDef;
  bool? selectStudent;
  int? fmGId;
  int? fmTId;
  int? amsTMobileNo;

  NBAttachmentModelValues(
      {this.duplicate,
      this.returnval,
      this.alreadyCnt,
      this.getclass,
      this.asmaYId,
      this.hrmdeSId,
      this.hrmEId,
      this.userId,
      this.ivrmrTId,
      this.amsTId,
      this.asmSId,
      this.intBId,
      this.mIId,
      this.intbfLFileName,
      this.intbfLFilePath,
      this.intBDispalyDisableFlg,
      this.intbCId,
      this.asmcLId,
      this.intbCActiveFlag,
      this.asmcLActiveFlag,
      this.intBStartDate,
      this.intBEndDate,
      this.intBActiveFlag,
      this.feeDef,
      this.selectStudent,
      this.fmGId,
      this.fmTId,
      this.amsTMobileNo});

  NBAttachmentModelValues.fromJson(Map<String, dynamic> json) {
    duplicate = json['duplicate'];
    returnval = json['returnval'];
    alreadyCnt = json['already_cnt'];
    getclass = json['getclass'];
    asmaYId = json['asmaY_Id'];
    hrmdeSId = json['hrmdeS_Id'];
    hrmEId = json['hrmE_Id'];
    userId = json['userId'];
    ivrmrTId = json['ivrmrT_Id'];
    amsTId = json['amsT_Id'];
    asmSId = json['asmS_Id'];
    intBId = json['intB_Id'];
    mIId = json['mI_Id'];
    intbfLFileName = json['intbfL_FileName'];
    intbfLFilePath = json['intbfL_FilePath'];
    intBDispalyDisableFlg = json['intB_DispalyDisableFlg'];
    intbCId = json['intbC_Id'];
    asmcLId = json['asmcL_Id'];
    intbCActiveFlag = json['intbC_ActiveFlag'];
    asmcLActiveFlag = json['asmcL_ActiveFlag'];
    intBStartDate = json['intB_StartDate'];
    intBEndDate = json['intB_EndDate'];
    intBActiveFlag = json['intB_ActiveFlag'];
    feeDef = json['fee_def'];
    selectStudent = json['select_student'];
    fmGId = json['fmG_Id'];
    fmTId = json['fmT_Id'];
    amsTMobileNo = json['amsT_MobileNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['duplicate'] = duplicate;
    data['returnval'] = returnval;
    data['already_cnt'] = alreadyCnt;
    data['getclass'] = getclass;
    data['asmaY_Id'] = asmaYId;
    data['hrmdeS_Id'] = hrmdeSId;
    data['hrmE_Id'] = hrmEId;
    data['userId'] = userId;
    data['ivrmrT_Id'] = ivrmrTId;
    data['amsT_Id'] = amsTId;
    data['asmS_Id'] = asmSId;
    data['intB_Id'] = intBId;
    data['mI_Id'] = mIId;
    data['intbfL_FileName'] = intbfLFileName;
    data['intbfL_FilePath'] = intbfLFilePath;
    data['intB_DispalyDisableFlg'] = intBDispalyDisableFlg;
    data['intbC_Id'] = intbCId;
    data['asmcL_Id'] = asmcLId;
    data['intbC_ActiveFlag'] = intbCActiveFlag;
    data['asmcL_ActiveFlag'] = asmcLActiveFlag;
    data['intB_StartDate'] = intBStartDate;
    data['intB_EndDate'] = intBEndDate;
    data['intB_ActiveFlag'] = intBActiveFlag;
    data['fee_def'] = feeDef;
    data['select_student'] = selectStudent;
    data['fmG_Id'] = fmGId;
    data['fmT_Id'] = fmTId;
    data['amsT_MobileNo'] = amsTMobileNo;
    return data;
  }
}
