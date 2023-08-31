// To parse this JSON data, do
//
//     final initialDataModel = initialDataModelFromJson(jsonString);

import 'dart:convert';

InitialDataModel? initialDataModelFromJson(String str) =>
    InitialDataModel.fromJson(json.decode(str));

String initialDataModelToJson(InitialDataModel? data) =>
    json.encode(data!.toJson());

class InitialDataModel {
  InitialDataModel({
    this.asAId,
    this.mIId,
    this.asmaYId,
    this.asmcLId,
    this.asmSId,
    this.amsTId,
    this.asAClassAttended,
    this.academicYearList,
    this.classList,
    this.sectionList,
    this.monthList,
    this.subjectList,
    this.batchList,
    this.returnval,
    this.countclass,
    this.countclass1,
    this.attdefaultdisplay,
    this.username,
    this.empCode,
    this.asalUId,
    this.userId,
    this.flag,
    this.roleId,
    this.currentYear,
    this.ismSId,
    this.periodlist,
    this.ttmPId,
    this.attcount,
    this.asasBId,
  });

  num? asAId;
  num? mIId;
  num? asmaYId;
  num? asmcLId;
  num? asmSId;
  num? amsTId;
  num? asAClassAttended;
  AcademicYearList? academicYearList;
  ClassListClass? classList;
  ClassListClass? sectionList;
  MonthList? monthList;
  SubjectList? subjectList;
  AcademicYearList? batchList;
  bool? returnval;
  num? countclass;
  num? countclass1;
  num? attdefaultdisplay;
  String? username;
  num? empCode;
  num? asalUId;
  num? userId;
  String? flag;
  num? roleId;
  CurrentYear? currentYear;
  num? ismSId;
  Periodlist? periodlist;
  num? ttmPId;
  num? attcount;
  num? asasBId;

  factory InitialDataModel.fromJson(Map<String, dynamic> json) =>
      InitialDataModel(
        asAId: json["asA_Id"],
        mIId: json["mI_Id"],
        asmaYId: json["asmaY_Id"],
        asmcLId: json["asmcL_Id"],
        asmSId: json["asmS_Id"],
        amsTId: json["amsT_Id"],
        asAClassAttended: json["asA_Class_Attended"],
        academicYearList: AcademicYearList.fromJson(json["academicYearList"]),
        classList: ClassListClass.fromJson(json["classList"]),
        sectionList: ClassListClass.fromJson(json["sectionList"]),
        monthList: MonthList.fromJson(json["monthList"]),
        subjectList: SubjectList.fromJson(json["subjectList"]),
        batchList: AcademicYearList.fromJson(json["batchList"]),
        returnval: json["returnval"],
        countclass: json["countclass"],
        countclass1: json["countclass1"],
        attdefaultdisplay: json["attdefaultdisplay"],
        username: json["username"],
        empCode: json["emp_Code"],
        asalUId: json["asalU_Id"],
        userId: json["userId"],
        flag: json["flag"],
        roleId: json["roleId"],
        currentYear: CurrentYear.fromJson(json["currentYear"]),
        ismSId: json["ismS_Id"],
        periodlist: Periodlist.fromJson(json["periodlist"]),
        ttmPId: json["ttmP_Id"],
        attcount: json["attcount"],
        asasBId: json["asasB_Id"],
      );

  Map<String, dynamic> toJson() => {
        "asA_Id": asAId,
        "mI_Id": mIId,
        "asmaY_Id": asmaYId,
        "asmcL_Id": asmcLId,
        "asmS_Id": asmSId,
        "amsT_Id": amsTId,
        "asA_Class_Attended": asAClassAttended,
        "academicYearList": academicYearList!.toJson(),
        "classList": classList!.toJson(),
        "sectionList": sectionList!.toJson(),
        "monthList": monthList!.toJson(),
        "subjectList": subjectList!.toJson(),
        "batchList": batchList!.toJson(),
        "returnval": returnval,
        "countclass": countclass,
        "countclass1": countclass1,
        "attdefaultdisplay": attdefaultdisplay,
        "username": username,
        "emp_Code": empCode,
        "asalU_Id": asalUId,
        "userId": userId,
        "flag": flag,
        "roleId": roleId,
        "currentYear": currentYear!.toJson(),
        "ismS_Id": ismSId,
        "periodlist": periodlist!.toJson(),
        "ttmP_Id": ttmPId,
        "attcount": attcount,
        "asasB_Id": asasBId,
      };
}

class AcademicYearList {
  AcademicYearList({
    this.type,
    this.values,
  });

  String? type;
  List<AcademicYearListValue?>? values;

  factory AcademicYearList.fromJson(Map<String, dynamic> json) =>
      AcademicYearList(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<AcademicYearListValue?>.from(json["\$values"]!
                .map((x) => AcademicYearListValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class AcademicYearListValue {
  AcademicYearListValue({
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
  DateTime? createdDate;
  DateTime? updatedDate;
  String? asmaYTransportSDate;
  String? asmaYTransportEDate;
  String? asmaYReferenceDate;
  String? asmaYAdvanceFeeDate;
  String? asmaYArrearFeeDate;

  factory AcademicYearListValue.fromJson(Map<String, dynamic> json) =>
      AcademicYearListValue(
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
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
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
        "createdDate": createdDate?.toIso8601String(),
        "updatedDate": updatedDate?.toIso8601String(),
        "asmaY_TransportSDate": asmaYTransportSDate,
        "asmaY_TransportEDate": asmaYTransportEDate,
        "asmaY_ReferenceDate": asmaYReferenceDate,
        "asmaY_AdvanceFeeDate": asmaYAdvanceFeeDate,
        "asmaY_ArrearFeeDate": asmaYArrearFeeDate,
      };
}

class ClassListClass {
  ClassListClass({
    this.type,
    this.values,
  });

  String? type;
  List<ClassListValue?>? values;

  factory ClassListClass.fromJson(Map<String, dynamic> json) => ClassListClass(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<ClassListValue?>.from(
                json["\$values"]!.map((x) => ClassListValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class ClassListValue {
  ClassListValue({
    this.asAId,
    this.mIId,
    this.asmaYId,
    this.asmcLId,
    this.asmcLClassName,
    this.asmSId,
    this.amsTId,
    this.asAClassAttended,
    this.returnval,
    this.countclass,
    this.countclass1,
    this.attdefaultdisplay,
    this.empCode,
    this.asalUId,
    this.userId,
    this.roleId,
    this.ismSId,
    this.ttmPId,
    this.attcount,
    this.asasBId,
    this.asmCSectionName,
  });

  num? asAId;
  num? mIId;
  num? asmaYId;
  num? asmcLId;
  String? asmcLClassName;
  num? asmSId;
  num? amsTId;
  num? asAClassAttended;
  bool? returnval;
  num? countclass;
  num? countclass1;
  num? attdefaultdisplay;
  num? empCode;
  num? asalUId;
  num? userId;
  num? roleId;
  num? ismSId;
  num? ttmPId;
  num? attcount;
  num? asasBId;
  String? asmCSectionName;

  factory ClassListValue.fromJson(Map<String, dynamic> json) => ClassListValue(
        asAId: json["asA_Id"],
        mIId: json["mI_Id"],
        asmaYId: json["asmaY_Id"],
        asmcLId: json["asmcL_Id"],
        asmcLClassName: json["asmcL_ClassName"],
        asmSId: json["asmS_Id"],
        amsTId: json["amsT_Id"],
        asAClassAttended: json["asA_Class_Attended"],
        returnval: json["returnval"],
        countclass: json["countclass"],
        countclass1: json["countclass1"],
        attdefaultdisplay: json["attdefaultdisplay"],
        empCode: json["emp_Code"],
        asalUId: json["asalU_Id"],
        userId: json["userId"],
        roleId: json["roleId"],
        ismSId: json["ismS_Id"],
        ttmPId: json["ttmP_Id"],
        attcount: json["attcount"],
        asasBId: json["asasB_Id"],
        asmCSectionName: json["asmC_SectionName"],
      );

  Map<String, dynamic> toJson() => {
        "asA_Id": asAId,
        "mI_Id": mIId,
        "asmaY_Id": asmaYId,
        "asmcL_Id": asmcLId,
        "asmcL_ClassName": asmcLClassName,
        "asmS_Id": asmSId,
        "amsT_Id": amsTId,
        "asA_Class_Attended": asAClassAttended,
        "returnval": returnval,
        "countclass": countclass,
        "countclass1": countclass1,
        "attdefaultdisplay": attdefaultdisplay,
        "emp_Code": empCode,
        "asalU_Id": asalUId,
        "userId": userId,
        "roleId": roleId,
        "ismS_Id": ismSId,
        "ttmP_Id": ttmPId,
        "attcount": attcount,
        "asasB_Id": asasBId,
        "asmC_SectionName": asmCSectionName,
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
        values: json["\$values"] == null
            ? []
            : List<MonthListValue?>.from(
                json["\$values"]!.map((x) => MonthListValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class MonthListValue {
  MonthListValue({
    this.ivrMMonthId,
    this.ivrMMonthName,
    this.isActive,
    this.ivrMMonthMaxDays,
  });

  num? ivrMMonthId;
  String? ivrMMonthName;
  bool? isActive;
  num? ivrMMonthMaxDays;

  factory MonthListValue.fromJson(Map<String, dynamic> json) => MonthListValue(
        ivrMMonthId: json["ivrM_Month_Id"],
        ivrMMonthName: json["ivrM_Month_Name"],
        isActive: json["is_Active"],
        ivrMMonthMaxDays: json["ivrM_Month_Max_Days"],
      );

  Map<String, dynamic> toJson() => {
        "ivrM_Month_Id": ivrMMonthId,
        "ivrM_Month_Name": ivrMMonthName,
        "is_Active": isActive,
        "ivrM_Month_Max_Days": ivrMMonthMaxDays,
      };
}

class Periodlist {
  Periodlist({
    this.type,
    this.values,
  });

  String? type;
  List<PeriodlistValue?>? values;

  factory Periodlist.fromJson(Map<String, dynamic> json) => Periodlist(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<PeriodlistValue?>.from(
                json["\$values"]!.map((x) => PeriodlistValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class PeriodlistValue {
  PeriodlistValue({
    this.ttmPId,
    this.mIId,
    this.ttmPPeriodName,
    this.ttmPActiveFlag,
    this.createdDate,
    this.updatedDate,
  });

  num? ttmPId;
  num? mIId;
  String? ttmPPeriodName;
  bool? ttmPActiveFlag;
  DateTime? createdDate;
  DateTime? updatedDate;

  factory PeriodlistValue.fromJson(Map<String, dynamic> json) =>
      PeriodlistValue(
        ttmPId: json["ttmP_Id"],
        mIId: json["mI_Id"],
        ttmPPeriodName: json["ttmP_PeriodName"],
        ttmPActiveFlag: json["ttmP_ActiveFlag"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "ttmP_Id": ttmPId,
        "mI_Id": mIId,
        "ttmP_PeriodName": ttmPPeriodName,
        "ttmP_ActiveFlag": ttmPActiveFlag,
        "createdDate": createdDate?.toIso8601String(),
        "updatedDate": updatedDate?.toIso8601String(),
      };
}

class SubjectList {
  SubjectList({
    this.type,
    this.values,
  });

  String? type;
  List<SubjectListValue?>? values;

  factory SubjectList.fromJson(Map<String, dynamic> json) => SubjectList(
        type: json["\$type"],
        values: json["\$values"] == null
            ? []
            : List<SubjectListValue?>.from(
                json["\$values"]!.map((x) => SubjectListValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class SubjectListValue {
  SubjectListValue({
    this.ismSId,
    this.mIId,
    this.ismSSubjectName,
    this.ismSSubjectCode,
    this.ismSIvrsSubjectName,
    this.ismSMaxMarks,
    this.ismSMinMarks,
    this.ismSExamFlag,
    this.ismSPreadmFlag,
    this.ismSSubjectFlag,
    this.ismSBatchAppl,
    this.ismSActiveFlag,
    this.ismSOrderFlag,
    this.ismSTtFlag,
    this.ismSAttendanceFlag,
    this.ismSLanguageFlg,
    this.ismSAtExtraFeeFlg,
    this.ismSSubjectNameNew,
    this.createdDate,
    this.updatedDate,
  });

  num? ismSId;
  num? mIId;
  String? ismSSubjectName;
  String? ismSSubjectCode;
  String? ismSIvrsSubjectName;
  num? ismSMaxMarks;
  num? ismSMinMarks;
  num? ismSExamFlag;
  num? ismSPreadmFlag;
  num? ismSSubjectFlag;
  num? ismSBatchAppl;
  num? ismSActiveFlag;
  num? ismSOrderFlag;
  bool? ismSTtFlag;
  bool? ismSAttendanceFlag;
  num? ismSLanguageFlg;
  num? ismSAtExtraFeeFlg;
  String? ismSSubjectNameNew;
  DateTime? createdDate;
  DateTime? updatedDate;

  factory SubjectListValue.fromJson(Map<String, dynamic> json) =>
      SubjectListValue(
        ismSId: json["ismS_Id"],
        mIId: json["mI_Id"],
        ismSSubjectName: json["ismS_SubjectName"],
        ismSSubjectCode: json["ismS_SubjectCode"],
        ismSIvrsSubjectName: json["ismS_IVRSSubjectName"],
        ismSMaxMarks: json["ismS_Max_Marks"],
        ismSMinMarks: json["ismS_Min_Marks"],
        ismSExamFlag: json["ismS_ExamFlag"],
        ismSPreadmFlag: json["ismS_PreadmFlag"],
        ismSSubjectFlag: json["ismS_SubjectFlag"],
        ismSBatchAppl: json["ismS_BatchAppl"],
        ismSActiveFlag: json["ismS_ActiveFlag"],
        ismSOrderFlag: json["ismS_OrderFlag"],
        ismSTtFlag: json["ismS_TTFlag"],
        ismSAttendanceFlag: json["ismS_AttendanceFlag"],
        ismSLanguageFlg: json["ismS_LanguageFlg"],
        ismSAtExtraFeeFlg: json["ismS_AtExtraFeeFlg"],
        ismSSubjectNameNew: json["ismS_SubjectNameNew"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "ismS_Id": ismSId,
        "mI_Id": mIId,
        "ismS_SubjectName": ismSSubjectName,
        "ismS_SubjectCode": ismSSubjectCode,
        "ismS_IVRSSubjectName": ismSIvrsSubjectName,
        "ismS_Max_Marks": ismSMaxMarks,
        "ismS_Min_Marks": ismSMinMarks,
        "ismS_ExamFlag": ismSExamFlag,
        "ismS_PreadmFlag": ismSPreadmFlag,
        "ismS_SubjectFlag": ismSSubjectFlag,
        "ismS_BatchAppl": ismSBatchAppl,
        "ismS_ActiveFlag": ismSActiveFlag,
        "ismS_OrderFlag": ismSOrderFlag,
        "ismS_TTFlag": ismSTtFlag,
        "ismS_AttendanceFlag": ismSAttendanceFlag,
        "ismS_LanguageFlg": ismSLanguageFlg,
        "ismS_AtExtraFeeFlg": ismSAtExtraFeeFlg,
        "ismS_SubjectNameNew": ismSSubjectNameNew,
        "createdDate": createdDate?.toIso8601String(),
        "updatedDate": updatedDate?.toIso8601String(),
      };
}

class CurrentYear {
  CurrentYear({
    this.type,
    this.values,
  });

  String? type;
  List<CurrentYearValue?>? values;

  factory CurrentYear.fromJson(Map<String, dynamic> json) => CurrentYear(
        type: json["\$type"],
        values: List<CurrentYearValue>.from(
            json["\$values"].map((x) => CurrentYearValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\$type": type,
        "\$values": List<dynamic>.from(values!.map((x) => x!.toJson())),
      };
}

class CurrentYearValue {
  CurrentYearValue({
    this.asmaYId,
    this.mIId,
    this.asmaYYear,
    // this.asmaYFromDate,
    // this.asmaYToDate,
    // this.asmaYPreAdmFDate,
    // this.asmaYPreAdmTDate,
    // this.asmaYOrder,
    // this.asmaYActiveFlag,
    // this.asmaYCutOfDate,
    // this.asmaYPreActiveFlag,
    // this.isActive,
    // this.asmaYReggularFlg,
    // this.asmaYNewFlg,
    // this.asmaYNewAdmissionFlg,
    // this.asmaYTransportSDate,
    // this.asmaYTransportEDate,
    // this.asmaYCreatedBy,
    // this.asmaYUpdatedBy,
    // this.asmaYAcademicYearCode,
    // this.asmaYRegularFeeFDate,
    // this.asmaYRegularFeeTDate,
    // this.createdDate,
    // this.updatedDate,
  });

  int? asmaYId;
  int? mIId;
  String? asmaYYear;
  // DateTime? asmaYFromDate;
  // DateTime? asmaYToDate;
  // DateTime? asmaYPreAdmFDate;
  // DateTime? asmaYPreAdmTDate;
  // int? asmaYOrder;
  // int? asmaYActiveFlag;
  // DateTime? asmaYCutOfDate;
  // int? asmaYPreActiveFlag;
  // bool? isActive;
  // bool? asmaYReggularFlg;
  // bool? asmaYNewFlg;
  // bool? asmaYNewAdmissionFlg;
  // DateTime? asmaYTransportSDate;
  // DateTime? asmaYTransportEDate;
  // int? asmaYCreatedBy;
  // int? asmaYUpdatedBy;
  // String? asmaYAcademicYearCode;
  // DateTime? asmaYRegularFeeFDate;
  // DateTime? asmaYRegularFeeTDate;
  // DateTime? createdDate;
  // DateTime? updatedDate;

  factory CurrentYearValue.fromJson(Map<String, dynamic> json) =>
      CurrentYearValue(
        asmaYId: json["asmaY_Id"],
        mIId: json["mI_Id"],
        asmaYYear: json["asmaY_Year"],
        // asmaYFromDate: DateTime.parse(json["asmaY_From_Date"]),
        // asmaYToDate: DateTime.parse(json["asmaY_To_Date"]),
        // asmaYPreAdmFDate: DateTime.parse(json["asmaY_PreAdm_F_Date"]),
        // asmaYPreAdmTDate: DateTime.parse(json["asmaY_PreAdm_T_Date"]),
        // asmaYOrder: json["asmaY_Order"],
        // asmaYActiveFlag: json["asmaY_ActiveFlag"],
        // asmaYCutOfDate: DateTime.parse(json["asmaY_Cut_Of_Date"]),
        // asmaYPreActiveFlag: json["asmaY_Pre_ActiveFlag"],
        // isActive: json["is_Active"],
        // asmaYReggularFlg: json["asmaY_ReggularFlg"],
        // asmaYNewFlg: json["asmaY_NewFlg"],
        // asmaYNewAdmissionFlg: json["asmaY_NewAdmissionFlg"],
        // asmaYTransportSDate: DateTime.parse(json["asmaY_TransportSDate"] ?? ''),
        // asmaYTransportEDate: DateTime.parse(json["asmaY_TransportEDate"] ?? ''),
        // asmaYCreatedBy: json["asmaY_CreatedBy"],
        // asmaYUpdatedBy: json["asmaY_UpdatedBy"],
        // asmaYAcademicYearCode: json["asmaY_AcademicYearCode"],
        // asmaYRegularFeeFDate: DateTime.parse(json["asmaY_RegularFeeFDate"]),
        // asmaYRegularFeeTDate: DateTime.parse(json["asmaY_RegularFeeTDate"]),
        // createdDate: DateTime.parse(json["createdDate"]),
        // updatedDate: DateTime.parse(json["updatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "asmaY_Id": asmaYId,
        "mI_Id": mIId,
        "asmaY_Year": asmaYYear,
        // "asmaY_From_Date": asmaYFromDate!.toIso8601String(),
        // "asmaY_To_Date": asmaYToDate!.toIso8601String(),
        // "asmaY_PreAdm_F_Date": asmaYPreAdmFDate!.toIso8601String(),
        // "asmaY_PreAdm_T_Date": asmaYPreAdmTDate!.toIso8601String(),
        // "asmaY_Order": asmaYOrder,
        // "asmaY_ActiveFlag": asmaYActiveFlag,
        // "asmaY_Cut_Of_Date": asmaYCutOfDate!.toIso8601String(),
        // "asmaY_Pre_ActiveFlag": asmaYPreActiveFlag,
        // "is_Active": isActive,
        // "asmaY_ReggularFlg": asmaYReggularFlg,
        // "asmaY_NewFlg": asmaYNewFlg,
        // "asmaY_NewAdmissionFlg": asmaYNewAdmissionFlg,
        // "asmaY_TransportSDate": asmaYTransportSDate!.toIso8601String(),
        // "asmaY_TransportEDate": asmaYTransportEDate!.toIso8601String(),
        // "asmaY_CreatedBy": asmaYCreatedBy,
        // "asmaY_UpdatedBy": asmaYUpdatedBy,
        // "asmaY_AcademicYearCode": asmaYAcademicYearCode,
        // "asmaY_RegularFeeFDate": asmaYRegularFeeFDate!.toIso8601String(),
        // "asmaY_RegularFeeTDate": asmaYRegularFeeTDate!.toIso8601String(),
        // "createdDate": createdDate!.toIso8601String(),
        // "updatedDate": updatedDate!.toIso8601String(),
      };
}
