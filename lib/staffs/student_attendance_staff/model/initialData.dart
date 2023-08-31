// To parse this JSON data, do
//
//     final initialDataModel = initialDataModelFromJson(jsonString);

import 'dart:convert';

InitialDataModel initialDataModelFromJson(String str) =>
    InitialDataModel.fromJson(json.decode(str));

String initialDataModelToJson(InitialDataModel data) =>
    json.encode(data.toJson());

class InitialDataModel {
  InitialDataModel({
    this.asmaYId,
    this.asmcLId,
    this.asmCId,
    this.amMId,
    this.radiotype,
    this.monthid,
    this.yearid,
    this.asmCOrder,
    this.fromdate,
    this.todate,
    this.amaYRollNo,
    this.asAClassHeld,
    this.asAClassAttended,
    this.percentage,
    this.amsTId,
    this.academicList,
    this.classList,
    this.sectionList,
    this.monthList,
    this.type,
    this.classheld,
    this.attendance,
    this.absent,
    this.present,
    this.strength,
    this.totalPresent,
    this.totalAbsent,
    this.premale,
    this.preFemale,
    this.absmale,
    this.absFemale,
    this.yeaRName,
    this.totaLPresent,
    this.totaLClassheld,
    this.amsTDob,
    this.amsTDate,
    this.miid,
    this.amsTMobileNo,
    this.astCTcIssueDate,
    this.astCLastAttendedDate,
    this.tcdatess,
    this.username,
    this.userId,
    this.roleId,
    this.flag,
    this.datewise,
    this.countclass,
    this.classorder,
    this.secorder,
    this.hrmEId,
    this.noofDaysattended,
    this.noofSchooldays,
    this.ismSOrderFlag,
    this.categoryflag,
    this.amCId,
  });

  num? asmaYId;
  num? asmcLId;
  num? asmCId;
  num? amMId;
  num? radiotype;
  num? monthid;
  num? yearid;
  num? asmCOrder;
  DateTime? fromdate;
  DateTime? todate;
  num? amaYRollNo;
  double? asAClassHeld;
  double? asAClassAttended;
  double? percentage;
  num? amsTId;
  AcademicList? academicList;
  Classlist? classList;
  SectionList? sectionList;
  MonthList? monthList;
  num? type;
  double? classheld;
  double? attendance;
  num? absent;
  num? present;
  num? strength;
  num? totalPresent;
  num? totalAbsent;
  num? premale;
  num? preFemale;
  num? absmale;
  num? absFemale;
  num? yeaRName;
  num? totaLPresent;
  num? totaLClassheld;
  DateTime? amsTDob;
  DateTime? amsTDate;
  num? miid;
  num? amsTMobileNo;
  DateTime? astCTcIssueDate;
  DateTime? astCLastAttendedDate;
  DateTime? tcdatess;
  String? username;
  num? userId;
  num? roleId;
  String? flag;
  num? datewise;
  num? countclass;
  num? classorder;
  num? secorder;
  num? hrmEId;
  num? noofDaysattended;
  num? noofSchooldays;
  num? ismSOrderFlag;
  bool? categoryflag;
  num? amCId;

  factory InitialDataModel.fromJson(Map<String, dynamic> json) =>
      InitialDataModel(
        asmaYId: json["asmaY_Id"],
        asmcLId: json["asmcL_Id"],
        asmCId: json["asmC_Id"],
        amMId: json["amM_ID"],
        radiotype: json["radiotype"],
        monthid: json["monthid"],
        yearid: json["yearid"],
        asmCOrder: json["asmC_Order"],
        fromdate: DateTime.parse(json["fromdate"]),
        todate: DateTime.parse(json["todate"]),
        amaYRollNo: json["amaY_Roll_No"],
        asAClassHeld: json["asA_ClassHeld"],
        asAClassAttended: json["asA_Class_Attended"],
        percentage: json["percentage"],
        amsTId: json["amsT_Id"],
        academicList: AcademicList.fromJson(json["academicList"]),
        classList: Classlist.fromJson(json['classlist']),
        sectionList: SectionList.fromJson(json['sectionList']),
        monthList: MonthList.fromJson(json['monthList']),
        type: json["type"],
        classheld: json["classheld"],
        attendance: json["attendance"],
        absent: json["absent"],
        present: json["present"],
        strength: json["strength"],
        totalPresent: json["totalPresent"],
        totalAbsent: json["totalAbsent"],
        premale: json["premale"],
        preFemale: json["preFemale"],
        absmale: json["absmale"],
        absFemale: json["absFemale"],
        yeaRName: json["yeaR_NAME"],
        totaLPresent: json["totaL_PRESENT"],
        totaLClassheld: json["totaL_classheld"],
        amsTDob: DateTime.parse(json["amsT_DOB"]),
        amsTDate: DateTime.parse(json["amsT_Date"]),
        miid: json["miid"],
        amsTMobileNo: json["amsT_MobileNo"],
        astCTcIssueDate: DateTime.parse(json["astC_TCIssueDate"]),
        astCLastAttendedDate: DateTime.parse(json["astC_LastAttendedDate"]),
        tcdatess: DateTime.parse(json["tcdatess"]),
        username: json["username"],
        userId: json["userId"],
        roleId: json["roleId"],
        flag: json["flag"],
        datewise: json["datewise"],
        countclass: json["countclass"],
        classorder: json["classorder"],
        secorder: json["secorder"],
        hrmEId: json["hrmE_Id"],
        noofDaysattended: json["noof_daysattended"],
        noofSchooldays: json["noof_schooldays"],
        ismSOrderFlag: json["ismS_OrderFlag"],
        categoryflag: json["categoryflag"],
        amCId: json["amC_Id"],
      );

  Map<String, dynamic> toJson() => {
        "asmaY_Id": asmaYId,
        "asmcL_Id": asmcLId,
        "asmC_Id": asmCId,
        "amM_ID": amMId,
        "radiotype": radiotype,
        "monthid": monthid,
        "yearid": yearid,
        "asmC_Order": asmCOrder,
        "fromdate": fromdate!.toIso8601String(),
        "todate": todate!.toIso8601String(),
        "amaY_Roll_No": amaYRollNo,
        "asA_ClassHeld": asAClassHeld,
        "asA_Class_Attended": asAClassAttended,
        "percentage": percentage,
        "amsT_Id": amsTId,
        "academicList": academicList!.toJson(),
        "classlist": classList!.toJson(),
        "sectionList": sectionList!.toJson(),
        "monthList": monthList!.toJson(),
        "type": type,
        "classheld": classheld,
        "attendance": attendance,
        "absent": absent,
        "present": present,
        "strength": strength,
        "totalPresent": totalPresent,
        "totalAbsent": totalAbsent,
        "premale": premale,
        "preFemale": preFemale,
        "absmale": absmale,
        "absFemale": absFemale,
        "yeaR_NAME": yeaRName,
        "totaL_PRESENT": totaLPresent,
        "totaL_classheld": totaLClassheld,
        "amsT_DOB": amsTDob!.toIso8601String(),
        "amsT_Date": amsTDate!.toIso8601String(),
        "miid": miid,
        "amsT_MobileNo": amsTMobileNo,
        "astC_TCIssueDate": astCTcIssueDate!.toIso8601String(),
        "astC_LastAttendedDate": astCLastAttendedDate!.toIso8601String(),
        "tcdatess": tcdatess!.toIso8601String(),
        "username": username,
        "userId": userId,
        "roleId": roleId,
        "flag": flag,
        "datewise": datewise,
        "countclass": countclass,
        "classorder": classorder,
        "secorder": secorder,
        "hrmE_Id": hrmEId,
        "noof_daysattended": noofDaysattended,
        "noof_schooldays": noofSchooldays,
        "ismS_OrderFlag": ismSOrderFlag,
        "categoryflag": categoryflag,
        "amC_Id": amCId,
      };
}

class AcademicList {
  AcademicList({
    this.type,
    this.values,
  });

  String? type;
  List<AcademicListValue?>? values;

  factory AcademicList.fromJson(Map<String, dynamic> json) => AcademicList(
        type: json["\$type"],
        values: json['\$values'] == null
            ? []
            : List<AcademicListValue?>.from(
                json["\$values"].map((x) => AcademicListValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class AcademicListValue {
  AcademicListValue({
    this.asmaYId,
    this.mIId,
    this.asmaYYear,
    this.asmaYFromDate,
    this.asmaYToDate,
    this.asmaYPreAdmFDate,
    this.asmaYPreAdmTDate,
    this.asmaYOrder,
    this.asmaYActiveFlag,
    this.asmaYCutOfDate,
    this.asmaYPreActiveFlag,
    this.isActive,
    this.asmaYReggularFlg,
    this.asmaYNewFlg,
    this.asmaYNewAdmissionFlg,
    this.asmaYCreatedBy,
    this.asmaYUpdatedBy,
    this.asmaYAcademicYearCode,
    // this.asmaYRegularFeeFDate,
    // this.asmaYRegularFeeTDate,
    this.createdDate,
    this.updatedDate,
    // this.asmaYTransportSDate,
    // this.asmaYTransportEDate,
    // this.asmaYReferenceDate,
    // this.asmaYAdvanceFeeDate,
    // this.asmaYArrearFeeDate,
  });

  num? asmaYId;
  num? mIId;
  String? asmaYYear;
  DateTime? asmaYFromDate;
  DateTime? asmaYToDate;
  DateTime? asmaYPreAdmFDate;
  DateTime? asmaYPreAdmTDate;
  num? asmaYOrder;
  num? asmaYActiveFlag;
  DateTime? asmaYCutOfDate;
  num? asmaYPreActiveFlag;
  bool? isActive;
  bool? asmaYReggularFlg;
  bool? asmaYNewFlg;
  bool? asmaYNewAdmissionFlg;
  num? asmaYCreatedBy;
  num? asmaYUpdatedBy;
  String? asmaYAcademicYearCode;
  // DateTime? asmaYRegularFeeFDate;
  // DateTime? asmaYRegularFeeTDate;
  DateTime? createdDate;
  DateTime? updatedDate;
  // DateTime? asmaYTransportSDate;
  // DateTime? asmaYTransportEDate;
  // DateTime? asmaYReferenceDate;
  // DateTime? asmaYAdvanceFeeDate;
  // DateTime? asmaYArrearFeeDate;

  factory AcademicListValue.fromJson(Map<String, dynamic> json) =>
      AcademicListValue(
        asmaYId: json["asmaY_Id"],
        mIId: json["mI_Id"],
        asmaYYear: json["asmaY_Year"],
        asmaYFromDate: DateTime.parse(json["asmaY_From_Date"]),
        asmaYToDate: DateTime.parse(json["asmaY_To_Date"]),
        asmaYPreAdmFDate: DateTime.parse(json["asmaY_PreAdm_F_Date"]),
        asmaYPreAdmTDate: DateTime.parse(json["asmaY_PreAdm_T_Date"]),
        asmaYOrder: json["asmaY_Order"],
        asmaYActiveFlag: json["asmaY_ActiveFlag"],
        asmaYCutOfDate: DateTime.parse(json["asmaY_Cut_Of_Date"]),
        asmaYPreActiveFlag: json["asmaY_Pre_ActiveFlag"],
        isActive: json["is_Active"],
        asmaYReggularFlg: json["asmaY_ReggularFlg"],
        asmaYNewFlg: json["asmaY_NewFlg"],
        asmaYNewAdmissionFlg: json["asmaY_NewAdmissionFlg"],
        asmaYCreatedBy: json["asmaY_CreatedBy"],
        asmaYUpdatedBy: json["asmaY_UpdatedBy"],
        asmaYAcademicYearCode: json["asmaY_AcademicYearCode"],
        // asmaYRegularFeeFDate: DateTime.parse(json["asmaY_RegularFeeFDate"]),
        // asmaYRegularFeeTDate: DateTime.parse(json["asmaY_RegularFeeTDate"]),
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
        // asmaYTransportSDate: DateTime.parse(json["asmaY_TransportSDate"]),
        // asmaYTransportEDate: DateTime.parse(json["asmaY_TransportEDate"]),
        // asmaYReferenceDate: DateTime.parse(json["asmaY_ReferenceDate"]),
        // asmaYAdvanceFeeDate: DateTime.parse(json["asmaY_AdvanceFeeDate"]),
        // asmaYArrearFeeDate: DateTime.parse(json["asmaY_ArrearFeeDate"]),
      );

  Map<String, dynamic> toJson() => {
        "asmaY_Id": asmaYId,
        "mI_Id": mIId,
        "asmaY_Year": asmaYYear,
        "asmaY_From_Date": asmaYFromDate!.toIso8601String(),
        "asmaY_To_Date": asmaYToDate!.toIso8601String(),
        "asmaY_PreAdm_F_Date": asmaYPreAdmFDate!.toIso8601String(),
        "asmaY_PreAdm_T_Date": asmaYPreAdmTDate!.toIso8601String(),
        "asmaY_Order": asmaYOrder,
        "asmaY_ActiveFlag": asmaYActiveFlag,
        "asmaY_Cut_Of_Date": asmaYCutOfDate!.toIso8601String(),
        "asmaY_Pre_ActiveFlag": asmaYPreActiveFlag,
        "is_Active": isActive,
        "asmaY_ReggularFlg": asmaYReggularFlg,
        "asmaY_NewFlg": asmaYNewFlg,
        "asmaY_NewAdmissionFlg": asmaYNewAdmissionFlg,
        "asmaY_CreatedBy": asmaYCreatedBy,
        "asmaY_UpdatedBy": asmaYUpdatedBy,
        "asmaY_AcademicYearCode": asmaYAcademicYearCode,
        // "asmaY_RegularFeeFDate": asmaYRegularFeeFDate!.toIso8601String(),
        // "asmaY_RegularFeeTDate": asmaYRegularFeeTDate!.toIso8601String(),
        "createdDate": createdDate!.toIso8601String(),
        "updatedDate": updatedDate!.toIso8601String(),
        // "asmaY_TransportSDate": asmaYTransportSDate!.toIso8601String(),
        // "asmaY_TransportEDate": asmaYTransportEDate!.toIso8601String(),
        // "asmaY_ReferenceDate": asmaYReferenceDate!.toIso8601String(),
        // "asmaY_AdvanceFeeDate": asmaYAdvanceFeeDate!.toIso8601String(),
        // "asmaY_ArrearFeeDate": asmaYArrearFeeDate!.toIso8601String(),
      };
}

class Classlist {
  Classlist({
    this.type,
    this.values,
  });

  String? type;
  List<ClasslistValue?>? values;

  factory Classlist.fromJson(Map<String, dynamic> json) => Classlist(
        type: json["\$type"],
        values: json['\$values'] == null
            ? []
            : List<ClasslistValue?>.from(
                json["\$values"].map((x) => ClasslistValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class ClasslistValue {
  ClasslistValue({
    this.asmaYId,
    this.asmcLId,
    this.asmCId,
    this.amMId,
    this.radiotype,
    this.monthid,
    this.yearid,
    this.asmCOrder,
    this.fromdate,
    this.todate,
    this.amaYRollNo,
    this.asAClassHeld,
    this.asAClassAttended,
    this.percentage,
    this.amsTId,
    this.type,
    this.classheld,
    this.attendance,
    this.absent,
    this.present,
    this.strength,
    this.totalPresent,
    this.totalAbsent,
    this.premale,
    this.preFemale,
    this.absmale,
    this.absFemale,
    this.yeaRName,
    this.totaLPresent,
    this.totaLClassheld,
    this.amsTDob,
    this.amsTDate,
    this.miid,
    this.amsTMobileNo,
    this.astCTcIssueDate,
    this.astCLastAttendedDate,
    this.tcdatess,
    this.username,
    this.userId,
    this.roleId,
    this.flag,
    this.datewise,
    this.countclass,
    this.classorder,
    this.secorder,
    this.hrmEId,
    this.noofDaysattended,
    this.noofSchooldays,
    this.ismSOrderFlag,
    this.categoryflag,
    this.amCId,
    this.asmcLClassName,
  });

  num? asmaYId;
  num? asmcLId;
  num? asmCId;
  num? amMId;
  num? radiotype;
  num? monthid;
  num? yearid;
  num? asmCOrder;
  DateTime? fromdate;
  DateTime? todate;
  num? amaYRollNo;
  double? asAClassHeld;
  double? asAClassAttended;
  double? percentage;
  num? amsTId;
  num? type;
  double? classheld;
  num? attendance;
  num? absent;
  num? present;
  num? strength;
  num? totalPresent;
  num? totalAbsent;
  num? premale;
  num? preFemale;
  num? absmale;
  num? absFemale;
  num? yeaRName;
  num? totaLPresent;
  num? totaLClassheld;
  DateTime? amsTDob;
  DateTime? amsTDate;
  num? miid;
  num? amsTMobileNo;
  DateTime? astCTcIssueDate;
  DateTime? astCLastAttendedDate;
  DateTime? tcdatess;
  String? username;
  num? userId;
  num? roleId;
  String? flag;
  num? datewise;
  num? countclass;
  num? classorder;
  num? secorder;
  num? hrmEId;
  num? noofDaysattended;
  num? noofSchooldays;
  num? ismSOrderFlag;
  bool? categoryflag;
  num? amCId;
  String? asmcLClassName;

  factory ClasslistValue.fromJson(Map<String, dynamic> json) => ClasslistValue(
        asmaYId: json["asmaY_Id"],
        asmcLId: json["asmcL_Id"],
        asmCId: json["asmC_Id"],
        amMId: json["amM_ID"],
        radiotype: json["radiotype"],
        monthid: json["monthid"],
        yearid: json["yearid"],
        asmCOrder: json["asmC_Order"],
        fromdate: DateTime.parse(json["fromdate"]),
        todate: DateTime.parse(json["todate"]),
        amaYRollNo: json["amaY_Roll_No"],
        asAClassHeld: json["asA_ClassHeld"],
        asAClassAttended: json["asA_Class_Attended"],
        percentage: json["percentage"],
        amsTId: json["amsT_Id"],
        type: json["type"],
        classheld: json["classheld"],
        attendance: json["attendance"],
        absent: json["absent"],
        present: json["present"],
        strength: json["strength"],
        totalPresent: json["totalPresent"],
        totalAbsent: json["totalAbsent"],
        premale: json["premale"],
        preFemale: json["preFemale"],
        absmale: json["absmale"],
        absFemale: json["absFemale"],
        yeaRName: json["yeaR_NAME"],
        totaLPresent: json["totaL_PRESENT"],
        totaLClassheld: json["totaL_classheld"],
        amsTDob: DateTime.parse(json["amsT_DOB"]),
        amsTDate: DateTime.parse(json["amsT_Date"]),
        miid: json["miid"],
        amsTMobileNo: json["amsT_MobileNo"],
        astCTcIssueDate: DateTime.parse(json["astC_TCIssueDate"]),
        astCLastAttendedDate: DateTime.parse(json["astC_LastAttendedDate"]),
        tcdatess: DateTime.parse(json["tcdatess"]),
        username: json["username"],
        userId: json["userId"],
        roleId: json["roleId"],
        flag: json["flag"],
        datewise: json["datewise"],
        countclass: json["countclass"],
        classorder: json["classorder"],
        secorder: json["secorder"],
        hrmEId: json["hrmE_Id"],
        noofDaysattended: json["noof_daysattended"],
        noofSchooldays: json["noof_schooldays"],
        ismSOrderFlag: json["ismS_OrderFlag"],
        categoryflag: json["categoryflag"],
        amCId: json["amC_Id"],
        asmcLClassName: json["asmcL_ClassName"],
      );

  Map<String, dynamic> toJson() => {
        "asmaY_Id": asmaYId,
        "asmcL_Id": asmcLId,
        "asmC_Id": asmCId,
        "amM_ID": amMId,
        "radiotype": radiotype,
        "monthid": monthid,
        "yearid": yearid,
        "asmC_Order": asmCOrder,
        "fromdate": fromdate!.toIso8601String(),
        "todate": todate!.toIso8601String(),
        "amaY_Roll_No": amaYRollNo,
        "asA_ClassHeld": asAClassHeld,
        "asA_Class_Attended": asAClassAttended,
        "percentage": percentage,
        "amsT_Id": amsTId,
        "type": type,
        "classheld": classheld,
        "attendance": attendance,
        "absent": absent,
        "present": present,
        "strength": strength,
        "totalPresent": totalPresent,
        "totalAbsent": totalAbsent,
        "premale": premale,
        "preFemale": preFemale,
        "absmale": absmale,
        "absFemale": absFemale,
        "yeaR_NAME": yeaRName,
        "totaL_PRESENT": totaLPresent,
        "totaL_classheld": totaLClassheld,
        "amsT_DOB": amsTDob!.toIso8601String(),
        "amsT_Date": amsTDate!.toIso8601String(),
        "miid": miid,
        "amsT_MobileNo": amsTMobileNo,
        "astC_TCIssueDate": astCTcIssueDate!.toIso8601String(),
        "astC_LastAttendedDate": astCLastAttendedDate!.toIso8601String(),
        "tcdatess": tcdatess!.toIso8601String(),
        "username": username,
        "userId": userId,
        "roleId": roleId,
        "flag": flag,
        "datewise": datewise,
        "countclass": countclass,
        "classorder": classorder,
        "secorder": secorder,
        "hrmE_Id": hrmEId,
        "noof_daysattended": noofDaysattended,
        "noof_schooldays": noofSchooldays,
        "ismS_OrderFlag": ismSOrderFlag,
        "categoryflag": categoryflag,
        "amC_Id": amCId,
        "asmcL_ClassName": asmcLClassName,
      };
}

class SectionList {
  SectionList({
    this.type,
    this.values,
  });

  String? type;
  List<SectionListValue?>? values;

  factory SectionList.fromJson(Map<String, dynamic> json) => SectionList(
        type: json["\$type"],
        values: List<SectionListValue?>.from(
            json["\$values"].map((x) => SectionListValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class SectionListValue {
  SectionListValue({
    this.asmaYId,
    this.asmcLId,
    this.asmCId,
    this.amMId,
    this.radiotype,
    this.monthid,
    this.yearid,
    this.asmCOrder,
    this.fromdate,
    this.todate,
    this.amaYRollNo,
    this.asAClassHeld,
    this.asAClassAttended,
    this.percentage,
    this.amsTId,
    this.type,
    this.classheld,
    this.attendance,
    this.asmCSectionName,
    this.absent,
    this.present,
    this.strength,
    this.totalPresent,
    this.totalAbsent,
    this.premale,
    this.preFemale,
    this.absmale,
    this.absFemale,
    this.yeaRName,
    this.totaLPresent,
    this.totaLClassheld,
    this.amsTDob,
    this.amsTDate,
    this.miid,
    this.amsTMobileNo,
    this.astCTcIssueDate,
    this.astCLastAttendedDate,
    this.tcdatess,
    this.asmSId,
    this.datewise,
    this.countclass,
    this.classorder,
    this.secorder,
    this.hrmEId,
    this.noofDaysattended,
    this.noofSchooldays,
    this.ismSOrderFlag,
    this.categoryflag,
    this.amCId,
  });

  num? asmaYId;
  num? asmcLId;
  num? asmCId;
  num? amMId;
  num? radiotype;
  num? monthid;
  num? yearid;
  num? asmCOrder;
  DateTime? fromdate;
  DateTime? todate;
  num? amaYRollNo;
  double? asAClassHeld;
  double? asAClassAttended;
  double? percentage;
  num? amsTId;
  num? type;
  double? classheld;
  num? attendance;
  String? asmCSectionName;
  num? absent;
  num? present;
  num? strength;
  num? totalPresent;
  num? totalAbsent;
  num? premale;
  num? preFemale;
  num? absmale;
  num? absFemale;
  num? yeaRName;
  num? totaLPresent;
  num? totaLClassheld;
  DateTime? amsTDob;
  DateTime? amsTDate;
  num? miid;
  num? amsTMobileNo;
  DateTime? astCTcIssueDate;
  DateTime? astCLastAttendedDate;
  DateTime? tcdatess;
  num? asmSId;
  num? datewise;
  num? countclass;
  num? classorder;
  num? secorder;
  num? hrmEId;
  num? noofDaysattended;
  num? noofSchooldays;
  num? ismSOrderFlag;
  bool? categoryflag;
  num? amCId;

  factory SectionListValue.fromJson(Map<String, dynamic> json) =>
      SectionListValue(
        asmaYId: json["asmaY_Id"],
        asmcLId: json["asmcL_Id"],
        asmCId: json["asmC_Id"],
        amMId: json["amM_ID"],
        radiotype: json["radiotype"],
        monthid: json["monthid"],
        yearid: json["yearid"],
        asmCOrder: json["asmC_Order"],
        fromdate: DateTime.parse(json["fromdate"]),
        todate: DateTime.parse(json["todate"]),
        amaYRollNo: json["amaY_Roll_No"],
        asAClassHeld: json["asA_ClassHeld"],
        asAClassAttended: json["asA_Class_Attended"],
        percentage: json["percentage"],
        amsTId: json["amsT_Id"],
        type: json["type"],
        classheld: json["classheld"],
        attendance: json["attendance"],
        asmCSectionName: json["asmC_SectionName"],
        absent: json["absent"],
        present: json["present"],
        strength: json["strength"],
        totalPresent: json["totalPresent"],
        totalAbsent: json["totalAbsent"],
        premale: json["premale"],
        preFemale: json["preFemale"],
        absmale: json["absmale"],
        absFemale: json["absFemale"],
        yeaRName: json["yeaR_NAME"],
        totaLPresent: json["totaL_PRESENT"],
        totaLClassheld: json["totaL_classheld"],
        amsTDob: DateTime.parse(json["amsT_DOB"]),
        amsTDate: DateTime.parse(json["amsT_Date"]),
        miid: json["miid"],
        amsTMobileNo: json["amsT_MobileNo"],
        astCTcIssueDate: DateTime.parse(json["astC_TCIssueDate"]),
        astCLastAttendedDate: DateTime.parse(json["astC_LastAttendedDate"]),
        tcdatess: DateTime.parse(json["tcdatess"]),
        asmSId: json["asmS_Id"],
        datewise: json["datewise"],
        countclass: json["countclass"],
        classorder: json["classorder"],
        secorder: json["secorder"],
        hrmEId: json["hrmE_Id"],
        noofDaysattended: json["noof_daysattended"],
        noofSchooldays: json["noof_schooldays"],
        ismSOrderFlag: json["ismS_OrderFlag"],
        categoryflag: json["categoryflag"],
        amCId: json["amC_Id"],
      );

  Map<String, dynamic> toJson() => {
        "asmaY_Id": asmaYId,
        "asmcL_Id": asmcLId,
        "asmC_Id": asmCId,
        "amM_ID": amMId,
        "radiotype": radiotype,
        "monthid": monthid,
        "yearid": yearid,
        "asmC_Order": asmCOrder,
        "fromdate": fromdate!.toIso8601String(),
        "todate": todate!.toIso8601String(),
        "amaY_Roll_No": amaYRollNo,
        "asA_ClassHeld": asAClassHeld,
        "asA_Class_Attended": asAClassAttended,
        "percentage": percentage,
        "amsT_Id": amsTId,
        "type": type,
        "classheld": classheld,
        "attendance": attendance,
        "asmC_SectionName": asmCSectionName,
        "absent": absent,
        "present": present,
        "strength": strength,
        "totalPresent": totalPresent,
        "totalAbsent": totalAbsent,
        "premale": premale,
        "preFemale": preFemale,
        "absmale": absmale,
        "absFemale": absFemale,
        "yeaR_NAME": yeaRName,
        "totaL_PRESENT": totaLPresent,
        "totaL_classheld": totaLClassheld,
        "amsT_DOB": amsTDob!.toIso8601String(),
        "amsT_Date": amsTDate!.toIso8601String(),
        "miid": miid,
        "amsT_MobileNo": amsTMobileNo,
        "astC_TCIssueDate": astCTcIssueDate!.toIso8601String(),
        "astC_LastAttendedDate": astCLastAttendedDate!.toIso8601String(),
        "tcdatess": tcdatess!.toIso8601String(),
        "asmS_Id": asmSId,
        "datewise": datewise,
        "countclass": countclass,
        "classorder": classorder,
        "secorder": secorder,
        "hrmE_Id": hrmEId,
        "noof_daysattended": noofDaysattended,
        "noof_schooldays": noofSchooldays,
        "ismS_OrderFlag": ismSOrderFlag,
        "categoryflag": categoryflag,
        "amC_Id": amCId,
      };
}

class MonthList {
  MonthList({
    this.type,
    this.values,
  });

  String? type;
  List<MonthListValue?>? values;

  factory MonthList.fromJson(Map<String, dynamic> json) => MonthList(
        type: json["\$type"],
        values: List<MonthListValue?>.from(
            json["\$values"].map((x) => MonthListValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class MonthListValue {
  MonthListValue({
    this.amMId,
    this.amMName,
    this.ftdDMonth,
    this.amMMonthMaxDays,
    this.createdDate,
    this.updatedDate,
  });

  num? amMId;
  String? amMName;
  num? ftdDMonth;
  num? amMMonthMaxDays;
  DateTime? createdDate;
  DateTime? updatedDate;

  factory MonthListValue.fromJson(Map<String, dynamic> json) => MonthListValue(
        amMId: json["amM_ID"],
        amMName: json["amM_NAME"],
        ftdDMonth: json["ftdD_Month"],
        amMMonthMaxDays: json["amM_Month_Max_Days"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "amM_ID": amMId,
        "amM_NAME": amMName,
        "ftdD_Month": ftdDMonth,
        "amM_Month_Max_Days": amMMonthMaxDays,
        "createdDate": createdDate!.toIso8601String(),
        "updatedDate": updatedDate!.toIso8601String(),
      };
}
