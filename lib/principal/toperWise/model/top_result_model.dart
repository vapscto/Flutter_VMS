class TopResultListModel {
  String? type;
  List<TopResultListModelValues>? values;
  String? reportType;
  String? subCheckType;
  String? exmCheckType;
  int? topper;

  TopResultListModel(
      {this.type,
      this.values,
      this.reportType,
      this.subCheckType,
      this.exmCheckType,
      this.topper});

  TopResultListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TopResultListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TopResultListModelValues.fromJson(v));
      });
    }
    reportType = json['report_type'];
    subCheckType = json['sub_check_type'];
    exmCheckType = json['exm_check_type'];
    topper = json['topper'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['\$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
    }
    data['report_type'] = this.reportType;
    data['sub_check_type'] = this.subCheckType;
    data['exm_check_type'] = this.exmCheckType;
    data['topper'] = this.topper;
    return data;
  }
}

class TopResultListModelValues {
  String? type;
  int? aMSTId;
  String? amsTFirstName;
  String? amsTAdmNo;
  String? asmcLClassName;
  String? ASMCLClassName;
  String? asmCSectionName;
  String? ASMCSectionName;
  int? estmPSectionRank;
  int? rNO;
  double? estmPTotalMaxMarks;
  double? estmPTotalObtMarks;
  double? estmpSObtainedMarks;
  double? estmpSMaxMarks;
  double? estmpSSectionHighest;
  double? estmPPercentage;
  int? aSMCLOrder;
  int? aSMCOrder;
  int? eMEExamOrder;
  String? emEExamName;
  double? MOBILENO;
  String? eMAILID;
  String? aMSTAppDownloadedDeviceId;

  TopResultListModelValues(
      {this.type,
      this.aMSTId,
      this.amsTFirstName,
      this.amsTAdmNo,
      this.asmcLClassName,
      this.ASMCLClassName,
      this.asmCSectionName,
      this.ASMCSectionName,
      this.estmPSectionRank,
      this.rNO,
      this.estmPTotalMaxMarks,
      this.estmPTotalObtMarks,
      this.estmpSObtainedMarks,
      this.estmpSMaxMarks,
      this.estmpSSectionHighest,
      this.estmPPercentage,
      this.aSMCLOrder,
      this.aSMCOrder,
      this.eMEExamOrder,
      this.emEExamName,
      this.MOBILENO,
      this.eMAILID,
      this.aMSTAppDownloadedDeviceId});

  TopResultListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    aMSTId = json['AMST_Id'];
    amsTFirstName = json['amsT_FirstName'];
    amsTAdmNo = json['amsT_AdmNo'];
    asmcLClassName = json['asmcL_ClassName'];
    ASMCLClassName = json['ASMCL_ClassName'];
    asmCSectionName = json['asmC_SectionName'];
    ASMCSectionName = json['ASMC_SectionName'];
    estmPSectionRank = json['estmP_SectionRank'];
    rNO = json['RNO'];
    estmPTotalMaxMarks = json['estmP_TotalMaxMarks'];
    estmPTotalObtMarks = json['estmP_TotalObtMarks'];
    estmpSObtainedMarks = json['estmpS_ObtainedMarks'];
    estmpSMaxMarks = json['estmpS_MaxMarks'];
    estmpSSectionHighest = json['estmpS_SectionHighest'];
    estmPPercentage = json['estmP_Percentage'];
    aSMCLOrder = json['ASMCL_Order'];
    aSMCOrder = json['ASMC_Order'];
    eMEExamOrder = json['EME_ExamOrder'];
    emEExamName = json['emE_ExamName'];
    MOBILENO = json['MOBILENO'];
    eMAILID = json['EMAILID'];
    aMSTAppDownloadedDeviceId = json['AMST_AppDownloadedDeviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    data['AMST_Id'] = this.aMSTId;
    data['amsT_FirstName'] = this.amsTFirstName;
    data['amsT_AdmNo'] = this.amsTAdmNo;
    data['asmcL_ClassName'] = this.asmcLClassName;
    data['ASMCL_ClassName'] = this.ASMCLClassName;
    data['asmC_SectionName'] = this.asmCSectionName;
    data['ASMC_SectionName'] = this.ASMCSectionName;
    data['estmP_SectionRank'] = this.estmPSectionRank;
    data['RNO'] = this.rNO;
    data['estmP_TotalMaxMarks'] = this.estmPTotalMaxMarks;
    data['estmP_TotalObtMarks'] = this.estmPTotalObtMarks;
    data['estmpS_ObtainedMarks'] = this.estmpSObtainedMarks;
    data['estmpS_MaxMarks'] = this.estmpSMaxMarks;
    data['estmpS_SectionHighest'] = this.estmpSSectionHighest;
    data['estmP_Percentage'] = this.estmPPercentage;
    data['ASMCL_Order'] = this.aSMCLOrder;
    data['ASMC_Order'] = this.aSMCOrder;
    data['EME_ExamOrder'] = this.eMEExamOrder;
    data['emE_ExamName'] = this.emEExamName;
    data['MOBILENO'] = this.MOBILENO;
    data['EMAILID'] = this.eMAILID;
    data['AMST_AppDownloadedDeviceId'] = this.aMSTAppDownloadedDeviceId;
    return data;
  }
}













// class TopResultListModel {
//   String? type;
//   List<TopResultListModelValues>? values;

//   TopResultListModel({this.type, this.values});

//   TopResultListModel.fromJson(Map<String, dynamic> json) {
//     type = json['\$type'];
//     if (json['\$values'] != null) {
//       values = <TopResultListModelValues>[];
//       json['\$values'].forEach((v) {
//         values!.add(TopResultListModelValues.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['\$type'] = this.type;
//     if (this.values != null) {
//       data['\$values'] = this.values!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class TopResultListModelValues {
//   String? type;
//   int? aMSTId;
//   String? amsTFirstName;
//   String? amsTAdmNo;
//   String? asmcLClassName;
//   String? asmCSectionName;
//   int? estmPSectionRank;
//   double? estmPTotalMaxMarks;
//   double? estmPTotalObtMarks;
//   double? estmPPercentage;
//   int? aSMCLOrder;
//   int? aSMCOrder;
//   int? eMEExamOrder;
//   String? emEExamName;
//   double? mOBILENO;
//   String? eMAILID;
//   String? aMSTAppDownloadedDeviceId;

//   TopResultListModelValues(
//       {this.type,
//       this.aMSTId,
//       this.amsTFirstName,
//       this.amsTAdmNo,
//       this.asmcLClassName,
//       this.asmCSectionName,
//       this.estmPSectionRank,
//       this.estmPTotalMaxMarks,
//       this.estmPTotalObtMarks,
//       this.estmPPercentage,
//       this.aSMCLOrder,
//       this.aSMCOrder,
//       this.eMEExamOrder,
//       this.emEExamName,
//       this.mOBILENO,
//       this.eMAILID,
//       this.aMSTAppDownloadedDeviceId});

//   TopResultListModelValues.fromJson(Map<String, dynamic> json) {
//     type = json['\$type'];
//     aMSTId = json['AMST_Id'];
//     amsTFirstName = json['amsT_FirstName'];
//     amsTAdmNo = json['amsT_AdmNo'];
//     asmcLClassName = json['asmcL_ClassName'];
//     asmCSectionName = json['asmC_SectionName'];
//     estmPSectionRank = json['estmP_SectionRank'];
//     estmPTotalMaxMarks = json['estmP_TotalMaxMarks'];
//     estmPTotalObtMarks = json['estmP_TotalObtMarks'];
//     estmPPercentage = json['estmP_Percentage'];
//     aSMCLOrder = json['ASMCL_Order'];
//     aSMCOrder = json['ASMC_Order'];
//     eMEExamOrder = json['EME_ExamOrder'];
//     emEExamName = json['emE_ExamName'];
//     mOBILENO = json['MOBILENO'];
//     eMAILID = json['EMAILID'];
//     aMSTAppDownloadedDeviceId = json['AMST_AppDownloadedDeviceId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['\$type'] = this.type;
//     data['AMST_Id'] = this.aMSTId;
//     data['amsT_FirstName'] = this.amsTFirstName;
//     data['amsT_AdmNo'] = this.amsTAdmNo;
//     data['asmcL_ClassName'] = this.asmcLClassName;
//     data['asmC_SectionName'] = this.asmCSectionName;
//     data['estmP_SectionRank'] = this.estmPSectionRank;
//     data['estmP_TotalMaxMarks'] = this.estmPTotalMaxMarks;
//     data['estmP_TotalObtMarks'] = this.estmPTotalObtMarks;
//     data['estmP_Percentage'] = this.estmPPercentage;
//     data['ASMCL_Order'] = this.aSMCLOrder;
//     data['ASMC_Order'] = this.aSMCOrder;
//     data['EME_ExamOrder'] = this.eMEExamOrder;
//     data['emE_ExamName'] = this.emEExamName;
//     data['MOBILENO'] = this.mOBILENO;
//     data['EMAILID'] = this.eMAILID;
//     data['AMST_AppDownloadedDeviceId'] = this.aMSTAppDownloadedDeviceId;
//     return data;
//   }
// }
