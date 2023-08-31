import 'package:m_skool_flutter/student/certificates/model/cert_list_model.dart';
import 'package:m_skool_flutter/student/certificates/model/certificate_drop_down.dart';
import 'package:m_skool_flutter/student/certificates/model/get_cert_model.dart';
import 'package:m_skool_flutter/student/certificates/model/stud_list.dart';
import 'package:m_skool_flutter/student/certificates/model/student_details_model.dart';

class GetCertificateDataModel {
  int? ascAId;
  int? mIId;
  int? amsTId;
  int? asmaYId;
  String? atcctapPApprovedDate;
  String? atclibapPApprovedDate;
  String? atcfapPApprovedDate;
  String? atcpdaapPApprovedDate;
  String? ascAApplyDate;
  bool? ascAActiveFlg;
  int? ascaPId;
  int? ivrmalUId;
  String? ascaPApproveDate;
  bool? ascaPActiveFlg;
  bool? acertapPActiveFlg;
  int? asmcLId;
  int? asmSId;
  int? amsTMobileNo;
  CertificateDropDown? certificateDropdown;
  CertificateList? certificatelist;
  StudentDetails? studentdetails;
  String? flag;
  int? userId;
  int? ivrmrTId;
  String? flagType;
  int? acertapPId;
  bool? acertapPOnlineDownloadFlg;
  bool? acertapPApprovaReqlFlg;
  bool? amcTActiceFlag;
  GetCertModel? getCertificate;
  bool? returnval;
  String? roletype;
  int? hrmEId;
  StudList? studlist;
  bool? duplicate;

  GetCertificateDataModel(
      {this.ascAId,
      this.mIId,
      this.amsTId,
      this.asmaYId,
      this.atcctapPApprovedDate,
      this.atclibapPApprovedDate,
      this.atcfapPApprovedDate,
      this.atcpdaapPApprovedDate,
      this.ascAApplyDate,
      this.ascAActiveFlg,
      this.ascaPId,
      this.ivrmalUId,
      this.ascaPApproveDate,
      this.ascaPActiveFlg,
      this.acertapPActiveFlg,
      this.asmcLId,
      this.asmSId,
      this.amsTMobileNo,
      this.certificateDropdown,
      this.certificatelist,
      this.studentdetails,
      this.flag,
      this.userId,
      this.ivrmrTId,
      this.flagType,
      this.acertapPId,
      this.acertapPOnlineDownloadFlg,
      this.acertapPApprovaReqlFlg,
      this.amcTActiceFlag,
      this.getCertificate,
      this.returnval,
      this.roletype,
      this.hrmEId,
      this.studlist,
      this.duplicate});

  GetCertificateDataModel.fromJson(Map<String, dynamic> json) {
    ascAId = json['ascA_Id'];
    mIId = json['mI_Id'];
    amsTId = json['amsT_Id'];
    asmaYId = json['asmaY_Id'];
    atcctapPApprovedDate = json['atcctapP_ApprovedDate'];
    atclibapPApprovedDate = json['atclibapP_ApprovedDate'];
    atcfapPApprovedDate = json['atcfapP_ApprovedDate'];
    atcpdaapPApprovedDate = json['atcpdaapP_ApprovedDate'];
    ascAApplyDate = json['ascA_ApplyDate'];
    ascAActiveFlg = json['ascA_ActiveFlg'];
    ascaPId = json['ascaP_Id'];
    ivrmalUId = json['ivrmalU_Id'];
    ascaPApproveDate = json['ascaP_ApproveDate'];
    ascaPActiveFlg = json['ascaP_ActiveFlg'];
    acertapPActiveFlg = json['acertapP_ActiveFlg'];
    asmcLId = json['asmcL_Id'];
    asmSId = json['asmS_Id'];
    amsTMobileNo = json['amsT_MobileNo'];
    certificateDropdown = json['certificate_dropdown'] != null
        ? CertificateDropDown.fromJson(json['certificate_dropdown'])
        : null;
    certificatelist = json['certificatelist'] != null
        ? CertificateList.fromJson(json['certificatelist'])
        : null;
    studentdetails = json['studentdetails'] != null
        ? StudentDetails.fromJson(json['studentdetails'])
        : null;
    flag = json['flag'];
    userId = json['userId'];
    ivrmrTId = json['ivrmrT_Id'];
    flagType = json['flag_Type'];
    acertapPId = json['acertapP_Id'];
    acertapPOnlineDownloadFlg = json['acertapP_OnlineDownloadFlg'];
    acertapPApprovaReqlFlg = json['acertapP_ApprovaReqlFlg'];
    amcTActiceFlag = json['amcT_ActiceFlag'];
    getCertificate = json['get_certificate'] != null
        ? GetCertModel.fromJson(json['get_certificate'])
        : null;
    returnval = json['returnval'];
    roletype = json['roletype'];
    hrmEId = json['hrmE_Id'];
    studlist =
        json['studlist'] != null ? StudList.fromJson(json['studlist']) : null;
    duplicate = json['duplicate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ascA_Id'] = ascAId;
    data['mI_Id'] = mIId;
    data['amsT_Id'] = amsTId;
    data['asmaY_Id'] = asmaYId;
    data['atcctapP_ApprovedDate'] = atcctapPApprovedDate;
    data['atclibapP_ApprovedDate'] = atclibapPApprovedDate;
    data['atcfapP_ApprovedDate'] = atcfapPApprovedDate;
    data['atcpdaapP_ApprovedDate'] = atcpdaapPApprovedDate;
    data['ascA_ApplyDate'] = ascAApplyDate;
    data['ascA_ActiveFlg'] = ascAActiveFlg;
    data['ascaP_Id'] = ascaPId;
    data['ivrmalU_Id'] = ivrmalUId;
    data['ascaP_ApproveDate'] = ascaPApproveDate;
    data['ascaP_ActiveFlg'] = ascaPActiveFlg;
    data['acertapP_ActiveFlg'] = acertapPActiveFlg;
    data['asmcL_Id'] = asmcLId;
    data['asmS_Id'] = asmSId;
    data['amsT_MobileNo'] = amsTMobileNo;
    if (certificateDropdown != null) {
      data['certificate_dropdown'] = certificateDropdown!.toJson();
    }
    if (certificatelist != null) {
      data['certificatelist'] = certificatelist!.toJson();
    }
    if (studentdetails != null) {
      data['studentdetails'] = studentdetails!.toJson();
    }
    data['flag'] = flag;
    data['userId'] = userId;
    data['ivrmrT_Id'] = ivrmrTId;
    data['flag_Type'] = flagType;
    data['acertapP_Id'] = acertapPId;
    data['acertapP_OnlineDownloadFlg'] = acertapPOnlineDownloadFlg;
    data['acertapP_ApprovaReqlFlg'] = acertapPApprovaReqlFlg;
    data['amcT_ActiceFlag'] = amcTActiceFlag;
    if (getCertificate != null) {
      data['get_certificate'] = getCertificate!.toJson();
    }
    data['returnval'] = returnval;
    data['roletype'] = roletype;
    data['hrmE_Id'] = hrmEId;
    if (studlist != null) {
      data['studlist'] = studlist!.toJson();
    }
    data['duplicate'] = duplicate;
    return data;
  }
}

// class CertificateDropdown {
//   String? type;
//   List<CertificateDropValues>? values;

//   CertificateDropdown({this.type, this.values});

//   CertificateDropdown.fromJson(Map<String, dynamic> json) {
//     type = json['\\$type'];
//     if (json['\$values'] != null) {
//       values = <CertificateDropValues>[];
//       json['\$values'].forEach((v) {
//         values!.add(CertificateDropValues.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['\\$type'] = type;
//     if (values != null) {
//       data['\$values'] = values!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class GetCert {
//   String? type;
//   List<CertificateListValues>? values;

//   GetCert({this.type, this.values});

//   GetCert.fromJson(Map<String, dynamic> json) {
//     type = json['\\$type'];
//     if (json['\$values'] != null) {
//       values = <CertificateListValues>[];
//       json['\$values'].forEach((v) {
//         values!.add(CertificateListValues.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['\\$type'] = type;
//     if (values != null) {
//       data['\$values'] = values!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class CertificateList {
//   String? type;
//   List<CertificateListValues>? values;

//   CertificateList({this.type, this.values});

//   CertificateList.fromJson(Map<String, dynamic> json) {
//     type = json['\\$type'];
//     if (json['\$values'] != null) {
//       values = <CertificateListValues>[];
//       json['\$values'].forEach((v) {
//         values!.add(CertificateListValues.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['\\$type'] = type;
//     if (values != null) {
//       data['\$values'] = values!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class StudentDetails {
//   String? type;
//   List<StuDetailValues>? values;

//   StudentDetails({this.type, this.values});

//   StudentDetails.fromJson(Map<String, dynamic> json) {
//     type = json['\\$type'];
//     if (json['\$values'] != null) {
//       values = <StuDetailValues>[];
//       json['\$values'].forEach((v) {
//         values!.add(StuDetailValues.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['\\$type'] = type;
//     if (values != null) {
//       data['\$values'] = values!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class CertificateDropValues {
//   int? amcTId;
//   String? amcTCertificateName;
//   String? amcTCertificateCode;
//   String? amcTDescription;
//   bool? amcTActiceFlag;
//   String? createdDate;
//   String? updatedDate;

//   CertificateDropValues(
//       {this.amcTId,
//       this.amcTCertificateName,
//       this.amcTCertificateCode,
//       this.amcTDescription,
//       this.amcTActiceFlag,
//       this.createdDate,
//       this.updatedDate});

//   CertificateDropValues.fromJson(Map<String, dynamic> json) {
//     amcTId = json['amcT_Id'];
//     amcTCertificateName = json['amcT_Certificate_Name'];
//     amcTCertificateCode = json['amcT_Certificate_code'];
//     amcTDescription = json['amcT_Description'];
//     amcTActiceFlag = json['amcT_ActiceFlag'];
//     createdDate = json['createdDate'];
//     updatedDate = json['updatedDate'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['amcT_Id'] = amcTId;
//     data['amcT_Certificate_Name'] = amcTCertificateName;
//     data['amcT_Certificate_code'] = amcTCertificateCode;
//     data['amcT_Description'] = amcTDescription;
//     data['amcT_ActiceFlag'] = amcTActiceFlag;
//     data['createdDate'] = createdDate;
//     data['updatedDate'] = updatedDate;
//     return data;
//   }
// }

// // class CertificateListValues {
//   int? acertapPId;
//   int? mIId;
//   String? acertapPCertificateName;
//   String? acertapPCertificateCode;
//   bool? acertapPApprovaReqlFlg;
//   bool? acertapPOnlineDownloadFlg;
//   bool? acertapPActiveFlg;
//   String? createdDate;
//   int? acertapPCreatedBy;
//   int? acertapPUpdatedBy;

//   CertificateListValues(
//       {this.acertapPId,
//       this.mIId,
//       this.acertapPCertificateName,
//       this.acertapPCertificateCode,
//       this.acertapPApprovaReqlFlg,
//       this.acertapPOnlineDownloadFlg,
//       this.acertapPActiveFlg,
//       this.createdDate,
//       this.acertapPCreatedBy,
//       this.acertapPUpdatedBy});

//   CertificateListValues.fromJson(Map<String, dynamic> json) {
//     acertapPId = json['acertapP_Id'];
//     mIId = json['mI_Id'];
//     acertapPCertificateName = json['acertapP_CertificateName'];
//     acertapPCertificateCode = json['acertapP_CertificateCode'];
//     acertapPApprovaReqlFlg = json['acertapP_ApprovaReqlFlg'];
//     acertapPOnlineDownloadFlg = json['acertapP_OnlineDownloadFlg'];
//     acertapPActiveFlg = json['acertapP_ActiveFlg'];
//     createdDate = json['createdDate'];
//     acertapPCreatedBy = json['acertapP_CreatedBy'];
//     acertapPUpdatedBy = json['acertapP_UpdatedBy'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['acertapP_Id'] = acertapPId;
//     data['mI_Id'] = mIId;
//     data['acertapP_CertificateName'] = acertapPCertificateName;
//     data['acertapP_CertificateCode'] = acertapPCertificateCode;
//     data['acertapP_ApprovaReqlFlg'] = acertapPApprovaReqlFlg;
//     data['acertapP_OnlineDownloadFlg'] = acertapPOnlineDownloadFlg;
//     data['acertapP_ActiveFlg'] = acertapPActiveFlg;
//     data['createdDate'] = createdDate;
//     data['acertapP_CreatedBy'] = acertapPCreatedBy;
//     data['acertapP_UpdatedBy'] = acertapPUpdatedBy;
//     return data;
//   }
// }

// class StuDetailValues {
//   int? ascAId;
//   int? mIId;
//   int? amsTId;
//   int? asmaYId;
//   String? atcctapPApprovedDate;
//   String? atclibapPApprovedDate;
//   String? atcfapPApprovedDate;
//   String? atcpdaapPApprovedDate;
//   String? ascAApplyDate;
//   bool? ascAActiveFlg;
//   int? ascaPId;
//   int? ivrmalUId;
//   String? ascaPApproveDate;
//   bool? ascaPActiveFlg;
//   bool? acertapPActiveFlg;
//   int? asmcLId;
//   String? amsTFirstName;
//   String? asmcLClassName;
//   String? asmCSectionName;
//   int? asmSId;
//   String? amsTRegistrationNo;
//   String? amsTEmailId;
//   int? amsTMobileNo;
//   int? userId;
//   int? ivrmrTId;
//   int? acertapPId;
//   bool? acertapPOnlineDownloadFlg;
//   bool? acertapPApprovaReqlFlg;
//   bool? amcTActiceFlag;
//   bool? returnval;
//   int? hrmEId;
//   bool? duplicate;

//   StuDetailValues(
//       {this.ascAId,
//       this.mIId,
//       this.amsTId,
//       this.asmaYId,
//       this.atcctapPApprovedDate,
//       this.atclibapPApprovedDate,
//       this.atcfapPApprovedDate,
//       this.atcpdaapPApprovedDate,
//       this.ascAApplyDate,
//       this.ascAActiveFlg,
//       this.ascaPId,
//       this.ivrmalUId,
//       this.ascaPApproveDate,
//       this.ascaPActiveFlg,
//       this.acertapPActiveFlg,
//       this.asmcLId,
//       this.amsTFirstName,
//       this.asmcLClassName,
//       this.asmCSectionName,
//       this.asmSId,
//       this.amsTRegistrationNo,
//       this.amsTEmailId,
//       this.amsTMobileNo,
//       this.userId,
//       this.ivrmrTId,
//       this.acertapPId,
//       this.acertapPOnlineDownloadFlg,
//       this.acertapPApprovaReqlFlg,
//       this.amcTActiceFlag,
//       this.returnval,
//       this.hrmEId,
//       this.duplicate});

//   StuDetailValues.fromJson(Map<String, dynamic> json) {
//     ascAId = json['ascA_Id'];
//     mIId = json['mI_Id'];
//     amsTId = json['amsT_Id'];
//     asmaYId = json['asmaY_Id'];
//     atcctapPApprovedDate = json['atcctapP_ApprovedDate'];
//     atclibapPApprovedDate = json['atclibapP_ApprovedDate'];
//     atcfapPApprovedDate = json['atcfapP_ApprovedDate'];
//     atcpdaapPApprovedDate = json['atcpdaapP_ApprovedDate'];
//     ascAApplyDate = json['ascA_ApplyDate'];
//     ascAActiveFlg = json['ascA_ActiveFlg'];
//     ascaPId = json['ascaP_Id'];
//     ivrmalUId = json['ivrmalU_Id'];
//     ascaPApproveDate = json['ascaP_ApproveDate'];
//     ascaPActiveFlg = json['ascaP_ActiveFlg'];
//     acertapPActiveFlg = json['acertapP_ActiveFlg'];
//     asmcLId = json['asmcL_Id'];
//     amsTFirstName = json['amsT_FirstName'];
//     asmcLClassName = json['asmcL_ClassName'];
//     asmCSectionName = json['asmC_SectionName'];
//     asmSId = json['asmS_Id'];
//     amsTRegistrationNo = json['amsT_RegistrationNo'];
//     amsTEmailId = json['amsT_emailId'];
//     amsTMobileNo = json['amsT_MobileNo'];
//     userId = json['userId'];
//     ivrmrTId = json['ivrmrT_Id'];
//     acertapPId = json['acertapP_Id'];
//     acertapPOnlineDownloadFlg = json['acertapP_OnlineDownloadFlg'];
//     acertapPApprovaReqlFlg = json['acertapP_ApprovaReqlFlg'];
//     amcTActiceFlag = json['amcT_ActiceFlag'];
//     returnval = json['returnval'];
//     hrmEId = json['hrmE_Id'];
//     duplicate = json['duplicate'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['ascA_Id'] = ascAId;
//     data['mI_Id'] = mIId;
//     data['amsT_Id'] = amsTId;
//     data['asmaY_Id'] = asmaYId;
//     data['atcctapP_ApprovedDate'] = atcctapPApprovedDate;
//     data['atclibapP_ApprovedDate'] = atclibapPApprovedDate;
//     data['atcfapP_ApprovedDate'] = atcfapPApprovedDate;
//     data['atcpdaapP_ApprovedDate'] = atcpdaapPApprovedDate;
//     data['ascA_ApplyDate'] = ascAApplyDate;
//     data['ascA_ActiveFlg'] = ascAActiveFlg;
//     data['ascaP_Id'] = ascaPId;
//     data['ivrmalU_Id'] = ivrmalUId;
//     data['ascaP_ApproveDate'] = ascaPApproveDate;
//     data['ascaP_ActiveFlg'] = ascaPActiveFlg;
//     data['acertapP_ActiveFlg'] = acertapPActiveFlg;
//     data['asmcL_Id'] = asmcLId;
//     data['amsT_FirstName'] = amsTFirstName;
//     data['asmcL_ClassName'] = asmcLClassName;
//     data['asmC_SectionName'] = asmCSectionName;
//     data['asmS_Id'] = asmSId;
//     data['amsT_RegistrationNo'] = amsTRegistrationNo;
//     data['amsT_emailId'] = amsTEmailId;
//     data['amsT_MobileNo'] = amsTMobileNo;
//     data['userId'] = userId;
//     data['ivrmrT_Id'] = ivrmrTId;
//     data['acertapP_Id'] = acertapPId;
//     data['acertapP_OnlineDownloadFlg'] = acertapPOnlineDownloadFlg;
//     data['acertapP_ApprovaReqlFlg'] = acertapPApprovaReqlFlg;
//     data['amcT_ActiceFlag'] = amcTActiceFlag;
//     data['returnval'] = returnval;
//     data['hrmE_Id'] = hrmEId;
//     data['duplicate'] = duplicate;
//     return data;
//   }
// }

// // class StudListValue {
//   int? ascAId;
//   int? mIId;
//   int? amsTId;
//   int? asmaYId;
//   String? atcctapPApprovedDate;
//   String? atclibapPApprovedDate;
//   String? atcfapPApprovedDate;
//   String? atcpdaapPApprovedDate;
//   String? ascAApplyDate;
//   String? ascAStatus;
//   bool? ascAActiveFlg;
//   int? ascaPId;
//   int? ivrmalUId;
//   String? ascaPApproveDate;
//   bool? ascaPActiveFlg;
//   bool? acertapPActiveFlg;
//   int? asmcLId;
//   String? amsTFirstName;
//   String? asmcLClassName;
//   String? asmCSectionName;
//   int? asmSId;
//   int? amsTMobileNo;
//   int? userId;
//   int? ivrmrTId;
//   int? acertapPId;
//   String? acertapPCertificateName;
//   String? acertapPCertificateCode;
//   bool? acertapPOnlineDownloadFlg;
//   bool? acertapPApprovaReqlFlg;
//   bool? amcTActiceFlag;
//   bool? returnval;
//   int? hrmEId;
//   bool? duplicate;

//   StudListValue(
//       {this.ascAId,
//       this.mIId,
//       this.amsTId,
//       this.asmaYId,
//       this.atcctapPApprovedDate,
//       this.atclibapPApprovedDate,
//       this.atcfapPApprovedDate,
//       this.atcpdaapPApprovedDate,
//       this.ascAApplyDate,
//       this.ascAStatus,
//       this.ascAActiveFlg,
//       this.ascaPId,
//       this.ivrmalUId,
//       this.ascaPApproveDate,
//       this.ascaPActiveFlg,
//       this.acertapPActiveFlg,
//       this.asmcLId,
//       this.amsTFirstName,
//       this.asmcLClassName,
//       this.asmCSectionName,
//       this.asmSId,
//       this.amsTMobileNo,
//       this.userId,
//       this.ivrmrTId,
//       this.acertapPId,
//       this.acertapPCertificateName,
//       this.acertapPCertificateCode,
//       this.acertapPOnlineDownloadFlg,
//       this.acertapPApprovaReqlFlg,
//       this.amcTActiceFlag,
//       this.returnval,
//       this.hrmEId,
//       this.duplicate});

//   StudListValue.fromJson(Map<String, dynamic> json) {
//     ascAId = json['ascA_Id'];
//     mIId = json['mI_Id'];
//     amsTId = json['amsT_Id'];
//     asmaYId = json['asmaY_Id'];
//     atcctapPApprovedDate = json['atcctapP_ApprovedDate'];
//     atclibapPApprovedDate = json['atclibapP_ApprovedDate'];
//     atcfapPApprovedDate = json['atcfapP_ApprovedDate'];
//     atcpdaapPApprovedDate = json['atcpdaapP_ApprovedDate'];
//     ascAApplyDate = json['ascA_ApplyDate'];
//     ascAStatus = json['ascA_Status'];
//     ascAActiveFlg = json['ascA_ActiveFlg'];
//     ascaPId = json['ascaP_Id'];
//     ivrmalUId = json['ivrmalU_Id'];
//     ascaPApproveDate = json['ascaP_ApproveDate'];
//     ascaPActiveFlg = json['ascaP_ActiveFlg'];
//     acertapPActiveFlg = json['acertapP_ActiveFlg'];
//     asmcLId = json['asmcL_Id'];
//     amsTFirstName = json['amsT_FirstName'];
//     asmcLClassName = json['asmcL_ClassName'];
//     asmCSectionName = json['asmC_SectionName'];
//     asmSId = json['asmS_Id'];
//     amsTMobileNo = json['amsT_MobileNo'];
//     userId = json['userId'];
//     ivrmrTId = json['ivrmrT_Id'];
//     acertapPId = json['acertapP_Id'];
//     acertapPCertificateName = json['acertapP_CertificateName'];
//     acertapPCertificateCode = json['acertapP_CertificateCode'];
//     acertapPOnlineDownloadFlg = json['acertapP_OnlineDownloadFlg'];
//     acertapPApprovaReqlFlg = json['acertapP_ApprovaReqlFlg'];
//     amcTActiceFlag = json['amcT_ActiceFlag'];
//     returnval = json['returnval'];
//     hrmEId = json['hrmE_Id'];
//     duplicate = json['duplicate'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['ascA_Id'] = ascAId;
//     data['mI_Id'] = mIId;
//     data['amsT_Id'] = amsTId;
//     data['asmaY_Id'] = asmaYId;
//     data['atcctapP_ApprovedDate'] = atcctapPApprovedDate;
//     data['atclibapP_ApprovedDate'] = atclibapPApprovedDate;
//     data['atcfapP_ApprovedDate'] = atcfapPApprovedDate;
//     data['atcpdaapP_ApprovedDate'] = atcpdaapPApprovedDate;
//     data['ascA_ApplyDate'] = ascAApplyDate;
//     data['ascA_Status'] = ascAStatus;
//     data['ascA_ActiveFlg'] = ascAActiveFlg;
//     data['ascaP_Id'] = ascaPId;
//     data['ivrmalU_Id'] = ivrmalUId;
//     data['ascaP_ApproveDate'] = ascaPApproveDate;
//     data['ascaP_ActiveFlg'] = ascaPActiveFlg;
//     data['acertapP_ActiveFlg'] = acertapPActiveFlg;
//     data['asmcL_Id'] = asmcLId;
//     data['amsT_FirstName'] = amsTFirstName;
//     data['asmcL_ClassName'] = asmcLClassName;
//     data['asmC_SectionName'] = asmCSectionName;
//     data['asmS_Id'] = asmSId;
//     data['amsT_MobileNo'] = amsTMobileNo;
//     data['userId'] = userId;
//     data['ivrmrT_Id'] = ivrmrTId;
//     data['acertapP_Id'] = acertapPId;
//     data['acertapP_CertificateName'] = acertapPCertificateName;
//     data['acertapP_CertificateCode'] = acertapPCertificateCode;
//     data['acertapP_OnlineDownloadFlg'] = acertapPOnlineDownloadFlg;
//     data['acertapP_ApprovaReqlFlg'] = acertapPApprovaReqlFlg;
//     data['amcT_ActiceFlag'] = amcTActiceFlag;
//     data['returnval'] = returnval;
//     data['hrmE_Id'] = hrmEId;
//     data['duplicate'] = duplicate;
//     return data;
//   }
// }
