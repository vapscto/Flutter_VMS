// To parse this JSON data, do
//
//     final interactionSectionModel = interactionSectionModelFromJson(jsonString);

import 'dart:convert';

InteractionSectionModel interactionSectionModelFromJson(String str) =>
    InteractionSectionModel.fromJson(json.decode(str));

String interactionSectionModelToJson(InteractionSectionModel data) =>
    json.encode(data.toJson());

class InteractionSectionModel {
  InteractionSectionModel({
    this.emeRId,
    this.intBId,
    this.roleid,
    this.paymentNootificationStaff,
    this.disabledint,
    this.blockdashboard,
    this.disabledorg,
    this.disablesubscription,
    this.subscriptionover,
    this.roleflg,
    this.mIId,
    this.hrmEId,
    this.asmaYId,
    this.periodCount,
    this.ttmdpTActiveFlag,
    this.asmcLId,
    this.asmSId,
    this.ismSId,
    this.asmcLActiveFlag,
    this.dayCount,
    this.ttmDId,
    this.studentcount,
    this.amstId,
    this.amstDob,
    this.amayRollNo,
    this.rollno,
    this.amstMobile,
    this.studentdob,
    this.id,
    this.hreSId,
    this.hresId,
    this.userId,
    this.hrmLLeaveCreditFlg,
    this.ivrMMonthId,
    this.isActive,
    this.ivrMMonthMaxDays,
    this.hrmEDol,
    this.hreobLId,
    this.hrmlYId,
    this.hreobLDate,
    this.hreobLObLeaves,
    this.hrelTId,
    this.hrelTLeaveId,
    this.hrelTFromDate,
    this.hrelTToDate,
    this.hrelTTotDays,
    this.hrelTReportingdate,
    this.hrelTActiveFlag,
    this.hrmldcfMId,
    this.hrmldcFId,
    this.hrmldcfMMonthId,
    this.hrelCId,
    this.hrelCDate,
    this.hrelCCrLeaves,
    this.hrmGPayScaleFrom,
    this.hrmGIncrementOf,
    this.hrmGPayScaleTo,
    this.hrmGOrder,
    this.hrmGActiveFlag,
    this.hrlAId,
    this.hrlaoNId,
    this.hrlaoNSanctionLevelNo,
    this.hrlaoNFinalFlg,
    this.hreltDId,
    this.hreltDFromDate,
    this.hreltDToDate,
    this.hreltDLwpFlag,
    this.hrelSId,
    this.hrelSObLeaves,
    this.hrelSCreditedLeaves,
    this.hrelSTotalLeaves,
    this.hrelSTransLeaves,
    this.hrelSEncashedLeaves,
    this.hrelSCbLeaves,
    this.hrelaPId,
    this.hrelaPApplicationId,
    this.hrelaPTotalDays,
    this.hrelaPContactNoOnLeave,
    this.hrelaPFinalFlag,
    this.hrelaPActiveFlag,
    this.hrmlYFromDate,
    this.hrmlYToDate,
    this.hrmlYActiveFlag,
    this.hrmldcMId,
    this.hrmldcFMaxLeaveAplFlg,
    this.hrmldcFMaxLeaveCf,
    this.hrmldeCId,
    this.hrmldeCServiceAplFlg,
    this.hrmldeCMaxLeaveFlg,
    this.hrmldeCMaxLeaves,
    this.hrmldeCMinLeaveFlg,
    this.hrmldeCMinLeaves,
    this.hrmldeCVariableFixedFlg,
    this.hrmldeCFixedAmount,
    this.month,
    this.year,
    this.hrelapAId,
    this.hrelapAFinalFlag,
    this.igAId,
    this.igADate,
    this.igACommonGalleryFlg,
    this.igaPId,
    this.igaPCoverPhotoFlag,
    this.hrmLId,
    this.leavecode,
    this.count,
    this.returnval,
    this.editFlag,
    this.sectionList,
    this.miid,
    this.hrmDId,
    this.hrmdeSId,
    this.emEId,
    this.present,
    this.classheld,
    this.type,
    this.perc,
    this.monthid,
    this.emeRActiveFlag,
    this.ivrmuLId,
    this.ttmBAfterPeriod,
  });

  int? emeRId;
  int? intBId;
  int? roleid;
  int? paymentNootificationStaff;
  bool? disabledint;
  bool? blockdashboard;
  bool? disabledorg;
  bool? disablesubscription;
  bool? subscriptionover;
  String? roleflg;
  int? mIId;
  int? hrmEId;
  int? asmaYId;
  int? periodCount;
  bool? ttmdpTActiveFlag;
  int? asmcLId;
  int? asmSId;
  int? ismSId;
  bool? asmcLActiveFlag;
  int? dayCount;
  int? ttmDId;
  int? studentcount;
  int? amstId;
  DateTime? amstDob;
  int? amayRollNo;
  int? rollno;
  int? amstMobile;
  DateTime? studentdob;
  int? id;
  int? hreSId;
  int? hresId;
  int? userId;
  bool? hrmLLeaveCreditFlg;
  int? ivrMMonthId;
  bool? isActive;
  int? ivrMMonthMaxDays;
  DateTime? hrmEDol;
  int? hreobLId;
  int? hrmlYId;
  DateTime? hreobLDate;
  int? hreobLObLeaves;
  int? hrelTId;
  int? hrelTLeaveId;
  DateTime? hrelTFromDate;
  DateTime? hrelTToDate;
  double? hrelTTotDays;
  DateTime? hrelTReportingdate;
  bool? hrelTActiveFlag;
  int? hrmldcfMId;
  int? hrmldcFId;
  int? hrmldcfMMonthId;
  int? hrelCId;
  DateTime? hrelCDate;
  int? hrelCCrLeaves;
  double? hrmGPayScaleFrom;
  num? hrmGIncrementOf;
  num? hrmGPayScaleTo;
  num? hrmGOrder;
  bool? hrmGActiveFlag;
  num? hrlAId;
  num? hrlaoNId;
  num? hrlaoNSanctionLevelNo;
  bool? hrlaoNFinalFlg;
  int? hreltDId;
  DateTime? hreltDFromDate;
  DateTime? hreltDToDate;
  bool? hreltDLwpFlag;
  int? hrelSId;
  num? hrelSObLeaves;
  num? hrelSCreditedLeaves;
  num? hrelSTotalLeaves;
  num? hrelSTransLeaves;
  num? hrelSEncashedLeaves;
  num? hrelSCbLeaves;
  num? hrelaPId;
  num? hrelaPApplicationId;
  num? hrelaPTotalDays;
  num? hrelaPContactNoOnLeave;
  bool? hrelaPFinalFlag;
  bool? hrelaPActiveFlag;
  DateTime? hrmlYFromDate;
  DateTime? hrmlYToDate;
  bool? hrmlYActiveFlag;
  num? hrmldcMId;
  bool? hrmldcFMaxLeaveAplFlg;
  num? hrmldcFMaxLeaveCf;
  num? hrmldeCId;
  bool? hrmldeCServiceAplFlg;
  bool? hrmldeCMaxLeaveFlg;
  num? hrmldeCMaxLeaves;
  bool? hrmldeCMinLeaveFlg;
  num? hrmldeCMinLeaves;
  bool? hrmldeCVariableFixedFlg;
  num? hrmldeCFixedAmount;
  num? month;
  num? year;
  num? hrelapAId;
  bool? hrelapAFinalFlag;
  num? igAId;
  DateTime? igADate;
  bool? igACommonGalleryFlg;
  num? igaPId;
  bool? igaPCoverPhotoFlag;
  num? hrmLId;
  num? leavecode;
  num? count;
  bool? returnval;
  bool? editFlag;
  InteractionSectionList? sectionList;
  num? miid;
  num? hrmDId;
  num? hrmdeSId;
  num? emEId;
  num? present;
  num? classheld;
  num? type;
  num? perc;
  num? monthid;
  bool? emeRActiveFlag;
  num? ivrmuLId;
  num? ttmBAfterPeriod;

  factory InteractionSectionModel.fromJson(Map<String, dynamic> json) =>
      InteractionSectionModel(
        emeRId: json["emeR_Id"],
        intBId: json["intB_Id"],
        roleid: json["roleid"],
        paymentNootificationStaff: json["paymentNootificationStaff"],
        disabledint: json["disabledint"],
        blockdashboard: json["blockdashboard"],
        disabledorg: json["disabledorg"],
        disablesubscription: json["disablesubscription"],
        subscriptionover: json["subscriptionover"],
        roleflg: json["roleflg"],
        mIId: json["mI_Id"],
        hrmEId: json["hrmE_Id"],
        asmaYId: json["asmaY_Id"],
        periodCount: json["periodCount"],
        ttmdpTActiveFlag: json["ttmdpT_ActiveFlag"],
        asmcLId: json["asmcL_Id"],
        asmSId: json["asmS_Id"],
        ismSId: json["ismS_Id"],
        asmcLActiveFlag: json["asmcL_ActiveFlag"],
        dayCount: json["dayCount"],
        ttmDId: json["ttmD_Id"],
        studentcount: json["studentcount"],
        amstId: json["amst_Id"],
        amstDob: DateTime.parse(json["amst_dob"]),
        amayRollNo: json["amay_RollNo"],
        rollno: json["rollno"],
        amstMobile: json["amst_mobile"],
        studentdob: DateTime.parse(json["studentdob"]),
        id: json["id"],
        hreSId: json["hreS_Id"],
        hresId: json["hres_id"],
        userId: json["userId"],
        hrmLLeaveCreditFlg: json["hrmL_LeaveCreditFlg"],
        ivrMMonthId: json["ivrM_Month_Id"],
        isActive: json["is_Active"],
        ivrMMonthMaxDays: json["ivrM_Month_Max_Days"],
        hrmEDol: DateTime.parse(json["hrmE_DOL"]),
        hreobLId: json["hreobL_Id"],
        hrmlYId: json["hrmlY_Id"],
        hreobLDate: DateTime.parse(json["hreobL_Date"]),
        hreobLObLeaves: json["hreobL_OBLeaves"],
        hrelTId: json["hrelT_Id"],
        hrelTLeaveId: json["hrelT_LeaveId"],
        hrelTFromDate: DateTime.parse(json["hrelT_FromDate"]),
        hrelTToDate: DateTime.parse(json["hrelT_ToDate"]),
        hrelTTotDays: json["hrelT_TotDays"],
        hrelTReportingdate: DateTime.parse(json["hrelT_Reportingdate"]),
        hrelTActiveFlag: json["hrelT_ActiveFlag"],
        hrmldcfMId: json["hrmldcfM_Id"],
        hrmldcFId: json["hrmldcF_Id"],
        hrmldcfMMonthId: json["hrmldcfM_MonthId"],
        hrelCId: json["hrelC_Id"],
        hrelCDate: DateTime.parse(json["hrelC_Date"]),
        hrelCCrLeaves: json["hrelC_CrLeaves"],
        hrmGPayScaleFrom: json["hrmG_PayScaleFrom"],
        hrmGIncrementOf: json["hrmG_IncrementOf"],
        hrmGPayScaleTo: json["hrmG_PayScaleTo"],
        hrmGOrder: json["hrmG_Order"],
        hrmGActiveFlag: json["hrmG_ActiveFlag"],
        hrlAId: json["hrlA_Id"],
        hrlaoNId: json["hrlaoN_Id"],
        hrlaoNSanctionLevelNo: json["hrlaoN_SanctionLevelNo"],
        hrlaoNFinalFlg: json["hrlaoN_FinalFlg"],
        hreltDId: json["hreltD_Id"],
        hreltDFromDate: DateTime.parse(json["hreltD_FromDate"]),
        hreltDToDate: DateTime.parse(json["hreltD_ToDate"]),
        hreltDLwpFlag: json["hreltD_LWPFlag"],
        hrelSId: json["hrelS_Id"],
        hrelSObLeaves: json["hrelS_OBLeaves"],
        hrelSCreditedLeaves: json["hrelS_CreditedLeaves"],
        hrelSTotalLeaves: json["hrelS_TotalLeaves"],
        hrelSTransLeaves: json["hrelS_TransLeaves"],
        hrelSEncashedLeaves: json["hrelS_EncashedLeaves"],
        hrelSCbLeaves: json["hrelS_CBLeaves"],
        hrelaPId: json["hrelaP_Id"],
        hrelaPApplicationId: json["hrelaP_ApplicationID"],
        hrelaPTotalDays: json["hrelaP_TotalDays"],
        hrelaPContactNoOnLeave: json["hrelaP_ContactNoOnLeave"],
        hrelaPFinalFlag: json["hrelaP_FinalFlag"],
        hrelaPActiveFlag: json["hrelaP_ActiveFlag"],
        hrmlYFromDate: DateTime.parse(json["hrmlY_FromDate"]),
        hrmlYToDate: DateTime.parse(json["hrmlY_ToDate"]),
        hrmlYActiveFlag: json["hrmlY_ActiveFlag"],
        hrmldcMId: json["hrmldcM_Id"],
        hrmldcFMaxLeaveAplFlg: json["hrmldcF_MaxLeaveAplFlg"],
        hrmldcFMaxLeaveCf: json["hrmldcF_MaxLeaveCF"],
        hrmldeCId: json["hrmldeC_Id"],
        hrmldeCServiceAplFlg: json["hrmldeC_ServiceAplFlg"],
        hrmldeCMaxLeaveFlg: json["hrmldeC_MaxLeaveFlg"],
        hrmldeCMaxLeaves: json["hrmldeC_MaxLeaves"],
        hrmldeCMinLeaveFlg: json["hrmldeC_MinLeaveFlg"],
        hrmldeCMinLeaves: json["hrmldeC_MinLeaves"],
        hrmldeCVariableFixedFlg: json["hrmldeC_VariableFixedFlg"],
        hrmldeCFixedAmount: json["hrmldeC_FixedAmount"],
        month: json["month"],
        year: json["year"],
        hrelapAId: json["hrelapA_Id"],
        hrelapAFinalFlag: json["hrelapA_FinalFlag"],
        igAId: json["igA_Id"],
        igADate: DateTime.parse(json["igA_Date"]),
        igACommonGalleryFlg: json["igA_CommonGalleryFlg"],
        igaPId: json["igaP_Id"],
        igaPCoverPhotoFlag: json["igaP_CoverPhotoFlag"],
        hrmLId: json["hrmL_Id"],
        leavecode: json["leavecode"],
        count: json["count"],
        returnval: json["returnval"],
        editFlag: json["edit_flag"],
        sectionList: InteractionSectionList.fromJson(json["sectionList"]),
        miid: json["miid"],
        hrmDId: json["hrmD_Id"],
        hrmdeSId: json["hrmdeS_Id"],
        emEId: json["emE_Id"],
        present: json["present"],
        classheld: json["classheld"],
        type: json["type"],
        perc: json["perc"],
        monthid: json["monthid"],
        emeRActiveFlag: json["emeR_ActiveFlag"],
        ivrmuLId: json["ivrmuL_Id"],
        ttmBAfterPeriod: json["ttmB_AfterPeriod"],
      );

  Map<String, dynamic> toJson() => {
        "emeR_Id": emeRId,
        "intB_Id": intBId,
        "roleid": roleid,
        "paymentNootificationStaff": paymentNootificationStaff,
        "disabledint": disabledint,
        "blockdashboard": blockdashboard,
        "disabledorg": disabledorg,
        "disablesubscription": disablesubscription,
        "subscriptionover": subscriptionover,
        "roleflg": roleflg,
        "mI_Id": mIId,
        "hrmE_Id": hrmEId,
        "asmaY_Id": asmaYId,
        "periodCount": periodCount,
        "ttmdpT_ActiveFlag": ttmdpTActiveFlag,
        "asmcL_Id": asmcLId,
        "asmS_Id": asmSId,
        "ismS_Id": ismSId,
        "asmcL_ActiveFlag": asmcLActiveFlag,
        "dayCount": dayCount,
        "ttmD_Id": ttmDId,
        "studentcount": studentcount,
        "amst_Id": amstId,
        "amst_dob": amstDob!.toIso8601String(),
        "amay_RollNo": amayRollNo,
        "rollno": rollno,
        "amst_mobile": amstMobile,
        "studentdob": studentdob!.toIso8601String(),
        "id": id,
        "hreS_Id": hreSId,
        "hres_id": hresId,
        "userId": userId,
        "hrmL_LeaveCreditFlg": hrmLLeaveCreditFlg,
        "ivrM_Month_Id": ivrMMonthId,
        "is_Active": isActive,
        "ivrM_Month_Max_Days": ivrMMonthMaxDays,
        "hrmE_DOL": hrmEDol!.toIso8601String(),
        "hreobL_Id": hreobLId,
        "hrmlY_Id": hrmlYId,
        "hreobL_Date": hreobLDate!.toIso8601String(),
        "hreobL_OBLeaves": hreobLObLeaves,
        "hrelT_Id": hrelTId,
        "hrelT_LeaveId": hrelTLeaveId,
        "hrelT_FromDate": hrelTFromDate!.toIso8601String(),
        "hrelT_ToDate": hrelTToDate!.toIso8601String(),
        "hrelT_TotDays": hrelTTotDays,
        "hrelT_Reportingdate": hrelTReportingdate!.toIso8601String(),
        "hrelT_ActiveFlag": hrelTActiveFlag,
        "hrmldcfM_Id": hrmldcfMId,
        "hrmldcF_Id": hrmldcFId,
        "hrmldcfM_MonthId": hrmldcfMMonthId,
        "hrelC_Id": hrelCId,
        "hrelC_Date": hrelCDate!.toIso8601String(),
        "hrelC_CrLeaves": hrelCCrLeaves,
        "hrmG_PayScaleFrom": hrmGPayScaleFrom,
        "hrmG_IncrementOf": hrmGIncrementOf,
        "hrmG_PayScaleTo": hrmGPayScaleTo,
        "hrmG_Order": hrmGOrder,
        "hrmG_ActiveFlag": hrmGActiveFlag,
        "hrlA_Id": hrlAId,
        "hrlaoN_Id": hrlaoNId,
        "hrlaoN_SanctionLevelNo": hrlaoNSanctionLevelNo,
        "hrlaoN_FinalFlg": hrlaoNFinalFlg,
        "hreltD_Id": hreltDId,
        "hreltD_FromDate": hreltDFromDate!.toIso8601String(),
        "hreltD_ToDate": hreltDToDate!.toIso8601String(),
        "hreltD_LWPFlag": hreltDLwpFlag,
        "hrelS_Id": hrelSId,
        "hrelS_OBLeaves": hrelSObLeaves,
        "hrelS_CreditedLeaves": hrelSCreditedLeaves,
        "hrelS_TotalLeaves": hrelSTotalLeaves,
        "hrelS_TransLeaves": hrelSTransLeaves,
        "hrelS_EncashedLeaves": hrelSEncashedLeaves,
        "hrelS_CBLeaves": hrelSCbLeaves,
        "hrelaP_Id": hrelaPId,
        "hrelaP_ApplicationID": hrelaPApplicationId,
        "hrelaP_TotalDays": hrelaPTotalDays,
        "hrelaP_ContactNoOnLeave": hrelaPContactNoOnLeave,
        "hrelaP_FinalFlag": hrelaPFinalFlag,
        "hrelaP_ActiveFlag": hrelaPActiveFlag,
        "hrmlY_FromDate": hrmlYFromDate!.toIso8601String(),
        "hrmlY_ToDate": hrmlYToDate!.toIso8601String(),
        "hrmlY_ActiveFlag": hrmlYActiveFlag,
        "hrmldcM_Id": hrmldcMId,
        "hrmldcF_MaxLeaveAplFlg": hrmldcFMaxLeaveAplFlg,
        "hrmldcF_MaxLeaveCF": hrmldcFMaxLeaveCf,
        "hrmldeC_Id": hrmldeCId,
        "hrmldeC_ServiceAplFlg": hrmldeCServiceAplFlg,
        "hrmldeC_MaxLeaveFlg": hrmldeCMaxLeaveFlg,
        "hrmldeC_MaxLeaves": hrmldeCMaxLeaves,
        "hrmldeC_MinLeaveFlg": hrmldeCMinLeaveFlg,
        "hrmldeC_MinLeaves": hrmldeCMinLeaves,
        "hrmldeC_VariableFixedFlg": hrmldeCVariableFixedFlg,
        "hrmldeC_FixedAmount": hrmldeCFixedAmount,
        "month": month,
        "year": year,
        "hrelapA_Id": hrelapAId,
        "hrelapA_FinalFlag": hrelapAFinalFlag,
        "igA_Id": igAId,
        "igA_Date": igADate!.toIso8601String(),
        "igA_CommonGalleryFlg": igACommonGalleryFlg,
        "igaP_Id": igaPId,
        "igaP_CoverPhotoFlag": igaPCoverPhotoFlag,
        "hrmL_Id": hrmLId,
        "leavecode": leavecode,
        "count": count,
        "returnval": returnval,
        "edit_flag": editFlag,
        "sectionList": sectionList!.toJson(),
        "miid": miid,
        "hrmD_Id": hrmDId,
        "hrmdeS_Id": hrmdeSId,
        "emE_Id": emEId,
        "present": present,
        "classheld": classheld,
        "type": type,
        "perc": perc,
        "monthid": monthid,
        "emeR_ActiveFlag": emeRActiveFlag,
        "ivrmuL_Id": ivrmuLId,
        "ttmB_AfterPeriod": ttmBAfterPeriod,
      };
}

class InteractionSectionList {
  InteractionSectionList({
    this.type,
    this.values,
  });

  String? type;
  List<InteractionSectionListValue?>? values;

  factory InteractionSectionList.fromJson(Map<String, dynamic> json) =>
      InteractionSectionList(
        type: json["\$type"],
        values: List<InteractionSectionListValue?>.from(json["\$values"]
            .map((x) => InteractionSectionListValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class InteractionSectionListValue {
  InteractionSectionListValue({
    this.type,
    this.asmSId,
    this.asmCSectionName,
  });

  String? type;
  int? asmSId;
  String? asmCSectionName;

  factory InteractionSectionListValue.fromJson(Map<String, dynamic> json) =>
      InteractionSectionListValue(
        type: json["\$type"],
        asmSId: json["asmS_Id"],
        asmCSectionName: json["asmC_SectionName"],
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "asmS_Id": asmSId,
        "asmC_SectionName": asmCSectionName,
      };
}
