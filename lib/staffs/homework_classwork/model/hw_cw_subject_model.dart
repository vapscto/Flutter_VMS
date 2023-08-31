class HwCwSubjectListModel {
  String? type;
  List<HwCwSubjectListModelValues>? values;

  HwCwSubjectListModel({this.type, this.values});

  HwCwSubjectListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <HwCwSubjectListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(HwCwSubjectListModelValues.fromJson(v));
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

class HwCwSubjectListModelValues {
  int? icWId;
  int? icwupLId;
  int? icwuplatTId;
  int? mIId;
  int? icWTeachingAid;
  bool? icWActiveFlag;
  String? icWFromDate;
  String? icWToDate;
  int? asmaYId;
  int? userId;
  int? ivrmrTId;
  int? ismSId;
  int? hrmEId;
  int? loginId;
  int? asmcLId;
  int? amsTMobileNo;
  int? asmSId;
  String? asmCSectionName;
  int? asmCOrder;
  String? ismSSubjectCode;
  String? ismSSubjectName;
  bool? returnval;
  int? amsTId;
  bool? dulicate;
  int? asmcLOrder;
  int? ismSOrder;

  HwCwSubjectListModelValues(
      {this.icWId,
      this.icwupLId,
      this.icwuplatTId,
      this.mIId,
      this.icWTeachingAid,
      this.icWActiveFlag,
      this.icWFromDate,
      this.icWToDate,
      this.asmaYId,
      this.userId,
      this.ivrmrTId,
      this.ismSId,
      this.hrmEId,
      this.loginId,
      this.asmcLId,
      this.amsTMobileNo,
      this.asmSId,
      this.asmCSectionName,
      this.asmCOrder,
      this.ismSSubjectCode,
      this.ismSSubjectName,
      this.returnval,
      this.amsTId,
      this.dulicate,
      this.asmcLOrder,
      this.ismSOrder});

  HwCwSubjectListModelValues.fromJson(Map<String, dynamic> json) {
    icWId = json['icW_Id'];
    icwupLId = json['icwupL_Id'];
    icwuplatTId = json['icwuplatT_Id'];
    mIId = json['mI_Id'];
    icWTeachingAid = json['icW_TeachingAid'];
    icWActiveFlag = json['icW_ActiveFlag'];
    icWFromDate = json['icW_FromDate'];
    icWToDate = json['icW_ToDate'];
    asmaYId = json['asmaY_Id'];
    userId = json['userId'];
    ivrmrTId = json['ivrmrT_Id'];
    ismSId = json['ismS_Id'];
    hrmEId = json['hrmE_Id'];
    loginId = json['login_Id'];
    asmcLId = json['asmcL_Id'];
    amsTMobileNo = json['amsT_MobileNo'];
    asmSId = json['asmS_Id'];
    asmCSectionName = json['asmC_SectionName'];
    asmCOrder = json['asmC_Order'];
    ismSSubjectCode = json['ismS_SubjectCode'];
    ismSSubjectName = json['ismS_SubjectName'];
    returnval = json['returnval'];
    amsTId = json['amsT_Id'];
    dulicate = json['dulicate'];
    asmcLOrder = json['asmcL_Order'];
    ismSOrder = json['ismS_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icW_Id'] = icWId;
    data['icwupL_Id'] = icwupLId;
    data['icwuplatT_Id'] = icwuplatTId;
    data['mI_Id'] = mIId;
    data['icW_TeachingAid'] = icWTeachingAid;
    data['icW_ActiveFlag'] = icWActiveFlag;
    data['icW_FromDate'] = icWFromDate;
    data['icW_ToDate'] = icWToDate;
    data['asmaY_Id'] = asmaYId;
    data['userId'] = userId;
    data['ivrmrT_Id'] = ivrmrTId;
    data['ismS_Id'] = ismSId;
    data['hrmE_Id'] = hrmEId;
    data['login_Id'] = loginId;
    data['asmcL_Id'] = asmcLId;
    data['amsT_MobileNo'] = amsTMobileNo;
    data['asmS_Id'] = asmSId;
    data['asmC_SectionName'] = asmCSectionName;
    data['asmC_Order'] = asmCOrder;
    data['ismS_SubjectCode'] = ismSSubjectCode;
    data['ismS_SubjectName'] = ismSSubjectName;
    data['returnval'] = returnval;
    data['amsT_Id'] = amsTId;
    data['dulicate'] = dulicate;
    data['asmcL_Order'] = asmcLOrder;
    data['ismS_order'] = ismSOrder;
    return data;
  }
}
