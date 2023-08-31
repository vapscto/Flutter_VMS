// To parse this JSON data, do
//
//     final academicYearModel = academicYearModelFromJson(jsonString);

import 'dart:convert';

AcademicYearModel? academicYearModelFromJson(String str) =>
    AcademicYearModel.fromJson(json.decode(str));

String academicYearModelToJson(AcademicYearModel? data) =>
    json.encode(data!.toJson());

class Staffmobileappprivileges {
  Staffmobileappprivileges({
    this.type,
    this.values,
  });

  String? type;
  List<AcademicYearModel?>? values;

  factory Staffmobileappprivileges.fromJson(Map<String, dynamic> json) =>
      Staffmobileappprivileges(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<AcademicYearModel?>.from(
                json["\$values"]!.map((x) => AcademicYearModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class AcademicYearModel {
  AcademicYearModel({
    this.estMId,
    this.mIId,
    this.asmaYId,
    this.asmcLId,
    this.asmSId,
    this.amsTId,
    this.emEId,
    this.ismSId,
    this.roleid,
    this.estMMarks,
    this.id,
    this.loginDateTime,
    this.estMActiveFlg,
    // this.ctlist,
    this.acdlist,
    this.emgRId,
    this.saveupdatecount,
    this.lastdateentry,
    this.lastdateentryflag,
    this.emsSId,
    this.emsEId,
    this.lastdateexam,
    this.lastdateexamflag,
    this.mobileprivileges,
    // this.staffmobileappprivileges,
    this.pagename,
    this.pageicon,
    this.pageurl,
    this.ivrmrmaPId,
    this.ivrmmaPAddFlg,
    this.ivrmmaPUpdateFlg,
    this.ivrmmaPDeleteFlg,
  });

  num? estMId;
  num? mIId;
  num? asmaYId;
  num? asmcLId;
  num? asmSId;
  num? amsTId;
  num? emEId;
  num? ismSId;
  num? roleid;
  num? estMMarks;
  num? id;
  DateTime? loginDateTime;
  bool? estMActiveFlg;
  // CtList? ctlist;
  AcdlistClass? acdlist;
  num? emgRId;
  num? saveupdatecount;
  num? lastdateentry;
  bool? lastdateentryflag;
  num? emsSId;
  num? emsEId;
  num? lastdateexam;
  bool? lastdateexamflag;
  String? mobileprivileges;
  // Staffmobileappprivileges? staffmobileappprivileges;
  String? pagename;
  String? pageicon;
  String? pageurl;
  num? ivrmrmaPId;
  bool? ivrmmaPAddFlg;
  bool? ivrmmaPUpdateFlg;
  bool? ivrmmaPDeleteFlg;

  factory AcademicYearModel.fromJson(Map<String, dynamic> json) =>
      AcademicYearModel(
        estMId: json["estM_Id"],
        mIId: json["mI_Id"],
        asmaYId: json["asmaY_Id"],
        asmcLId: json["asmcL_Id"],
        asmSId: json["asmS_Id"],
        amsTId: json["amsT_Id"],
        emEId: json["emE_Id"],
        ismSId: json["ismS_Id"],
        roleid: json["roleid"],
        estMMarks: json["estM_Marks"],
        id: json["id"],
        loginDateTime: DateTime.parse(json["loginDateTime"]),
        estMActiveFlg: json["estM_ActiveFlg"],
        // ctlist: json["ctlist"] ?? {},
        acdlist: AcdlistClass.fromJson(json["acdlist"]),
        emgRId: json["emgR_Id"],
        saveupdatecount: json["saveupdatecount"],
        lastdateentry: json["lastdateentry"],
        lastdateentryflag: json["lastdateentryflag"],
        emsSId: json["emsS_Id"],
        emsEId: json["emsE_Id"],
        lastdateexam: json["lastdateexam"],
        lastdateexamflag: json["lastdateexamflag"],
        mobileprivileges: json["mobileprivileges"],
        // staffmobileappprivileges: json["staffmobileappprivileges"],
        pagename: json["pagename"],
        pageicon: json["pageicon"],
        pageurl: json["pageurl"],
        ivrmrmaPId: json["ivrmrmaP_Id"],
        ivrmmaPAddFlg: json["ivrmmaP_AddFlg"],
        ivrmmaPUpdateFlg: json["ivrmmaP_UpdateFlg"],
        ivrmmaPDeleteFlg: json["ivrmmaP_DeleteFlg"],
      );

  Map<String, dynamic> toJson() => {
        "estM_Id": estMId,
        "mI_Id": mIId,
        "asmaY_Id": asmaYId,
        "asmcL_Id": asmcLId,
        "asmS_Id": asmSId,
        "amsT_Id": amsTId,
        "emE_Id": emEId,
        "ismS_Id": ismSId,
        "roleid": roleid,
        "estM_Marks": estMMarks,
        "id": id,
        "loginDateTime": loginDateTime?.toIso8601String(),
        "estM_ActiveFlg": estMActiveFlg,
        // "ctlist": ctlist,
        "acdlist": acdlist!.toJson(),
        "emgR_Id": emgRId,
        "saveupdatecount": saveupdatecount,
        "lastdateentry": lastdateentry,
        "lastdateentryflag": lastdateentryflag,
        "emsS_Id": emsSId,
        "emsE_Id": emsEId,
        "lastdateexam": lastdateexam,
        "lastdateexamflag": lastdateexamflag,
        "mobileprivileges": mobileprivileges,
        // "staffmobileappprivileges": staffmobileappprivileges,
        "pagename": pagename,
        "pageicon": pageicon,
        "pageurl": pageurl,
        "ivrmrmaP_Id": ivrmrmaPId,
        "ivrmmaP_AddFlg": ivrmmaPAddFlg,
        "ivrmmaP_UpdateFlg": ivrmmaPUpdateFlg,
        "ivrmmaP_DeleteFlg": ivrmmaPDeleteFlg,
      };
}

class AcdlistClass {
  AcdlistClass({
    this.type,
    this.values,
  });

  String? type;
  List<AcdlistClassValue?>? values;

  factory AcdlistClass.fromJson(Map<String, dynamic> json) => AcdlistClass(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<AcdlistClassValue?>.from(
                json["\$values"]!.map((x) => AcdlistClassValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class AcdlistClassValue {
  AcdlistClassValue({
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
    this.asmaYRegularFeeFDate,
    this.asmaYRegularFeeTDate,
    this.createdDate,
    this.updatedDate,
    this.asmaYTransportSDate,
    this.asmaYTransportEDate,
    this.asmaYReferenceDate,
    this.asmaYAdvanceFeeDate,
    this.asmaYArrearFeeDate,
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
  String? asmaYRegularFeeFDate;
  String? asmaYRegularFeeTDate;
  String? createdDate;
  String? updatedDate;
  String? asmaYTransportSDate;
  String? asmaYTransportEDate;
  String? asmaYReferenceDate;
  String? asmaYAdvanceFeeDate;
  String? asmaYArrearFeeDate;

  factory AcdlistClassValue.fromJson(Map<String, dynamic> json) =>
      AcdlistClassValue(
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
        asmaYRegularFeeFDate: json["asmaY_RegularFeeFDate"],
        asmaYRegularFeeTDate: json["asmaY_RegularFeeTDate"],
        createdDate: json["createdDate"],
        updatedDate: json["updatedDate"],
        asmaYTransportSDate: json["asmaY_TransportSDate"],
        asmaYTransportEDate: json["asmaY_TransportEDate"],
        asmaYReferenceDate: json["asmaY_ReferenceDate"],
        asmaYAdvanceFeeDate: json["asmaY_AdvanceFeeDate"],
        asmaYArrearFeeDate: json["asmaY_ArrearFeeDate"],
      );

  Map<String, dynamic> toJson() => {
        "asmaY_Id": asmaYId,
        "mI_Id": mIId,
        "asmaY_Year": asmaYYear,
        "asmaY_From_Date": asmaYFromDate?.toIso8601String(),
        "asmaY_To_Date": asmaYToDate?.toIso8601String(),
        "asmaY_PreAdm_F_Date": asmaYPreAdmFDate?.toIso8601String(),
        "asmaY_PreAdm_T_Date": asmaYPreAdmTDate?.toIso8601String(),
        "asmaY_Order": asmaYOrder,
        "asmaY_ActiveFlag": asmaYActiveFlag,
        "asmaY_Cut_Of_Date": asmaYCutOfDate?.toIso8601String(),
        "asmaY_Pre_ActiveFlag": asmaYPreActiveFlag,
        "is_Active": isActive,
        "asmaY_ReggularFlg": asmaYReggularFlg,
        "asmaY_NewFlg": asmaYNewFlg,
        "asmaY_NewAdmissionFlg": asmaYNewAdmissionFlg,
        "asmaY_CreatedBy": asmaYCreatedBy,
        "asmaY_UpdatedBy": asmaYUpdatedBy,
        "asmaY_AcademicYearCode": asmaYAcademicYearCode,
        "asmaY_RegularFeeFDate": asmaYRegularFeeFDate,
        "asmaY_RegularFeeTDate": asmaYRegularFeeTDate,
        "createdDate": createdDate,
        "updatedDate": updatedDate,
        "asmaY_TransportSDate": asmaYTransportSDate,
        "asmaY_TransportEDate": asmaYTransportEDate,
        "asmaY_ReferenceDate": asmaYReferenceDate,
        "asmaY_AdvanceFeeDate": asmaYAdvanceFeeDate,
        "asmaY_ArrearFeeDate": asmaYArrearFeeDate,
      };
}

// class CtList {
//   CtList({
//     this.type,
//     this.values,
//   });

//   String? type;
//   List<CtListValue?>? values;

//   factory CtList.fromJson(Map<String, dynamic> json) => CtList(
//         type: json["\$type"],
//         values: json["\$values"] == null
//             ? []
//             : List<CtListValue?>.from(
//                 json["\$values"]!.map((x) => CtListValue.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "\$type": type,
//         "\$values": values == null
//             ? []
//             : List<dynamic>.from(values!.map((x) => x!.toJson())),
//       };
// }

// class CtListValue {
//   CtListValue({
//     this.asmaYId,
//     this.mIId,
//     this.asmaYYear,
//     this.asmaYFromDate,
//     this.asmaYToDate,
//     this.asmaYPreAdmFDate,
//     this.asmaYPreAdmTDate,
//     this.asmaYOrder,
//     this.asmaYActiveFlag,
//     this.asmaYCutOfDate,
//     this.asmaYPreActiveFlag,
//     this.isActive,
//     this.asmaYReggularFlg,
//     this.asmaYNewFlg,
//     this.asmaYNewAdmissionFlg,
//     this.asmaYCreatedBy,
//     this.asmaYUpdatedBy,
//     this.asmaYAcademicYearCode,
//     this.asmaYRegularFeeFDate,
//     this.asmaYRegularFeeTDate,
//     this.createdDate,
//     this.updatedDate,
//     this.asmaYTransportSDate,
//     this.asmaYTransportEDate,
//     this.asmaYReferenceDate,
//     this.asmaYAdvanceFeeDate,
//     this.asmaYArrearFeeDate,
//   });

//   num? asmaYId;
//   num? mIId;
//   String? asmaYYear;
//   DateTime? asmaYFromDate;
//   DateTime? asmaYToDate;
//   DateTime? asmaYPreAdmFDate;
//   DateTime? asmaYPreAdmTDate;
//   num? asmaYOrder;
//   num? asmaYActiveFlag;
//   DateTime? asmaYCutOfDate;
//   num? asmaYPreActiveFlag;
//   bool? isActive;
//   bool? asmaYReggularFlg;
//   bool? asmaYNewFlg;
//   bool? asmaYNewAdmissionFlg;
//   num? asmaYCreatedBy;
//   num? asmaYUpdatedBy;
//   String? asmaYAcademicYearCode;
//   DateTime? asmaYRegularFeeFDate;
//   DateTime? asmaYRegularFeeTDate;
//   DateTime? createdDate;
//   DateTime? updatedDate;
//   DateTime? asmaYTransportSDate;
//   DateTime? asmaYTransportEDate;
//   DateTime? asmaYReferenceDate;
//   DateTime? asmaYAdvanceFeeDate;
//   DateTime? asmaYArrearFeeDate;

//   factory CtListValue.fromJson(Map<String, dynamic> json) => CtListValue(
//         asmaYId: json["asmaY_Id"],
//         mIId: json["mI_Id"],
//         asmaYYear: json["asmaY_Year"],
//         asmaYFromDate: DateTime.parse(json["asmaY_From_Date"]),
//         asmaYToDate: DateTime.parse(json["asmaY_To_Date"]),
//         asmaYPreAdmFDate: DateTime.parse(json["asmaY_PreAdm_F_Date"]),
//         asmaYPreAdmTDate: DateTime.parse(json["asmaY_PreAdm_T_Date"]),
//         asmaYOrder: json["asmaY_Order"],
//         asmaYActiveFlag: json["asmaY_ActiveFlag"],
//         asmaYCutOfDate: DateTime.parse(json["asmaY_Cut_Of_Date"]),
//         asmaYPreActiveFlag: json["asmaY_Pre_ActiveFlag"],
//         isActive: json["is_Active"],
//         asmaYReggularFlg: json["asmaY_ReggularFlg"],
//         asmaYNewFlg: json["asmaY_NewFlg"],
//         asmaYNewAdmissionFlg: json["asmaY_NewAdmissionFlg"],
//         asmaYCreatedBy: json["asmaY_CreatedBy"],
//         asmaYUpdatedBy: json["asmaY_UpdatedBy"],
//         asmaYAcademicYearCode: json["asmaY_AcademicYearCode"],
//         asmaYRegularFeeFDate: json["asmaY_RegularFeeFDate"],
//         asmaYRegularFeeTDate: json["asmaY_RegularFeeTDate"],
//         createdDate: DateTime.parse(json["createdDate"]),
//         updatedDate: DateTime.parse(json["updatedDate"]),
//         asmaYTransportSDate: json["asmaY_TransportSDate"],
//         asmaYTransportEDate: json["asmaY_TransportEDate"],
//         asmaYReferenceDate: json["asmaY_ReferenceDate"],
//         asmaYAdvanceFeeDate: json["asmaY_AdvanceFeeDate"],
//         asmaYArrearFeeDate: json["asmaY_ArrearFeeDate"],
//       );

//   Map<String, dynamic> toJson() => {
//         "asmaY_Id": asmaYId,
//         "mI_Id": mIId,
//         "asmaY_Year": asmaYYear,
//         "asmaY_From_Date": asmaYFromDate?.toIso8601String(),
//         "asmaY_To_Date": asmaYToDate?.toIso8601String(),
//         "asmaY_PreAdm_F_Date": asmaYPreAdmFDate?.toIso8601String(),
//         "asmaY_PreAdm_T_Date": asmaYPreAdmTDate?.toIso8601String(),
//         "asmaY_Order": asmaYOrder,
//         "asmaY_ActiveFlag": asmaYActiveFlag,
//         "asmaY_Cut_Of_Date": asmaYCutOfDate?.toIso8601String(),
//         "asmaY_Pre_ActiveFlag": asmaYPreActiveFlag,
//         "is_Active": isActive,
//         "asmaY_ReggularFlg": asmaYReggularFlg,
//         "asmaY_NewFlg": asmaYNewFlg,
//         "asmaY_NewAdmissionFlg": asmaYNewAdmissionFlg,
//         "asmaY_CreatedBy": asmaYCreatedBy,
//         "asmaY_UpdatedBy": asmaYUpdatedBy,
//         "asmaY_AcademicYearCode": asmaYAcademicYearCode,
//         "asmaY_RegularFeeFDate": asmaYRegularFeeFDate,
//         "asmaY_RegularFeeTDate": asmaYRegularFeeTDate,
//         "createdDate": createdDate?.toIso8601String(),
//         "updatedDate": updatedDate?.toIso8601String(),
//         "asmaY_TransportSDate": asmaYTransportSDate,
//         "asmaY_TransportEDate": asmaYTransportEDate,
//         "asmaY_ReferenceDate": asmaYReferenceDate,
//         "asmaY_AdvanceFeeDate": asmaYAdvanceFeeDate,
//         "asmaY_ArrearFeeDate": asmaYArrearFeeDate,
//       };
// }
