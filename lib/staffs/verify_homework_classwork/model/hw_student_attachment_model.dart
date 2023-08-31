class HwStuAttachmentModel {
  String? type;
  List<HwStuAttachmentModelValues>? values;

  HwStuAttachmentModel({this.type, this.values});

  HwStuAttachmentModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <HwStuAttachmentModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(HwStuAttachmentModelValues.fromJson(v));
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

class HwStuAttachmentModelValues {
  int? ihWId;
  int? ihwupLId;
  int? mIId;
  int? userId;
  int? ivrmrTId;
  int? asmaYId;
  int? amsTId;
  double? marks;
  int? ihWAssignmentNo;
  int? ismSId;
  int? ivrmuLId;
  int? asmcLId;
  int? asmSId;
  String? ihwupLFileName;
  String? ihwupLAttachment;
  bool? ihWActiveFlag;
  int? loginId;
  int? hrmEId;
  bool? returnval;
  int? amsTMobileNo;
  bool? dulicate;
  int? ihwuplatTId;

  HwStuAttachmentModelValues(
      {this.ihWId,
      this.ihwupLId,
      this.mIId,
      this.userId,
      this.ivrmrTId,
      this.asmaYId,
      this.amsTId,
      this.marks,
      this.ihWAssignmentNo,
      this.ismSId,
      this.ivrmuLId,
      this.asmcLId,
      this.asmSId,
      this.ihwupLFileName,
      this.ihwupLAttachment,
      this.ihWActiveFlag,
      this.loginId,
      this.hrmEId,
      this.returnval,
      this.amsTMobileNo,
      this.dulicate,
      this.ihwuplatTId});

  HwStuAttachmentModelValues.fromJson(Map<String, dynamic> json) {
    ihWId = json['ihW_Id'];
    ihwupLId = json['ihwupL_Id'];
    mIId = json['mI_Id'];
    userId = json['userId'];
    ivrmrTId = json['ivrmrT_Id'];
    asmaYId = json['asmaY_Id'];
    amsTId = json['amsT_Id'];
    marks = json['marks'];
    ihWAssignmentNo = json['ihW_AssignmentNo'];
    ismSId = json['ismS_Id'];
    ivrmuLId = json['ivrmuL_Id'];
    asmcLId = json['asmcL_Id'];
    asmSId = json['asmS_Id'];
    ihwupLFileName = json['ihwupL_FileName'];
    ihwupLAttachment = json['ihwupL_Attachment'];
    ihWActiveFlag = json['ihW_ActiveFlag'];
    loginId = json['login_Id'];
    hrmEId = json['hrmE_Id'];
    returnval = json['returnval'];
    amsTMobileNo = json['amsT_MobileNo'];
    dulicate = json['dulicate'];
    ihwuplatTId = json['ihwuplatT_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ihW_Id'] = ihWId;
    data['ihwupL_Id'] = ihwupLId;
    data['mI_Id'] = mIId;
    data['userId'] = userId;
    data['ivrmrT_Id'] = ivrmrTId;
    data['asmaY_Id'] = asmaYId;
    data['amsT_Id'] = amsTId;
    data['marks'] = marks;
    data['ihW_AssignmentNo'] = ihWAssignmentNo;
    data['ismS_Id'] = ismSId;
    data['ivrmuL_Id'] = ivrmuLId;
    data['asmcL_Id'] = asmcLId;
    data['asmS_Id'] = asmSId;
    data['ihwupL_FileName'] = ihwupLFileName;
    data['ihwupL_Attachment'] = ihwupLAttachment;
    data['ihW_ActiveFlag'] = ihWActiveFlag;
    data['login_Id'] = loginId;
    data['hrmE_Id'] = hrmEId;
    data['returnval'] = returnval;
    data['amsT_MobileNo'] = amsTMobileNo;
    data['dulicate'] = dulicate;
    data['ihwuplatT_Id'] = ihwuplatTId;
    return data;
  }
}
