class StudList {
  String? type;
  List<StudListValues>? values;

  StudList({this.type, this.values});

  StudList.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <StudListValues>[];
      json['\$values'].forEach((v) {
        values!.add(StudListValues.fromJson(v));
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

class StudListValues {
  int? ascAId;
  int? mIId;
  int? amsTId;
  int? asmaYId;
  String? atcctapPApprovedDate;
  String? atclibapPApprovedDate;
  String? atcfapPApprovedDate;
  String? atcpdaapPApprovedDate;
  String? ascAApplyDate;
  String? ascAStatus;
  bool? ascAActiveFlg;
  int? ascaPId;
  int? ivrmalUId;
  String? ascaPApproveDate;
  bool? ascaPActiveFlg;
  bool? acertapPActiveFlg;
  int? asmcLId;
  String? amsTFirstName;
  String? asmcLClassName;
  String? asmCSectionName;
  int? asmSId;
  int? amsTMobileNo;
  int? userId;
  int? ivrmrTId;
  int? acertapPId;
  String? acertapPCertificateName;
  String? acertapPCertificateCode;
  bool? acertapPOnlineDownloadFlg;
  bool? acertapPApprovaReqlFlg;
  bool? amcTActiceFlag;
  bool? returnval;
  int? hrmEId;
  bool? duplicate;
  String? ascaReason;

  StudListValues(
      {this.ascAId,
      this.mIId,
      this.amsTId,
      this.asmaYId,
      this.atcctapPApprovedDate,
      this.atclibapPApprovedDate,
      this.atcfapPApprovedDate,
      this.atcpdaapPApprovedDate,
      this.ascAApplyDate,
      this.ascAStatus,
      this.ascAActiveFlg,
      this.ascaPId,
      this.ivrmalUId,
      this.ascaPApproveDate,
      this.ascaPActiveFlg,
      this.acertapPActiveFlg,
      this.asmcLId,
      this.amsTFirstName,
      this.asmcLClassName,
      this.asmCSectionName,
      this.asmSId,
      this.amsTMobileNo,
      this.userId,
      this.ivrmrTId,
      this.acertapPId,
      this.acertapPCertificateName,
      this.acertapPCertificateCode,
      this.acertapPOnlineDownloadFlg,
      this.acertapPApprovaReqlFlg,
      this.amcTActiceFlag,
      this.returnval,
      this.hrmEId,
      this.duplicate,
      this.ascaReason});

  StudListValues.fromJson(Map<String, dynamic> json) {
    ascAId = json['ascA_Id'];
    mIId = json['mI_Id'];
    amsTId = json['amsT_Id'];
    asmaYId = json['asmaY_Id'];
    atcctapPApprovedDate = json['atcctapP_ApprovedDate'];
    atclibapPApprovedDate = json['atclibapP_ApprovedDate'];
    atcfapPApprovedDate = json['atcfapP_ApprovedDate'];
    atcpdaapPApprovedDate = json['atcpdaapP_ApprovedDate'];
    ascAApplyDate = json['ascA_ApplyDate'];
    ascAStatus = json['ascA_Status'];
    ascAActiveFlg = json['ascA_ActiveFlg'];
    ascaPId = json['ascaP_Id'];
    ivrmalUId = json['ivrmalU_Id'];
    ascaPApproveDate = json['ascaP_ApproveDate'];
    ascaPActiveFlg = json['ascaP_ActiveFlg'];
    acertapPActiveFlg = json['acertapP_ActiveFlg'];
    asmcLId = json['asmcL_Id'];
    amsTFirstName = json['amsT_FirstName'];
    asmcLClassName = json['asmcL_ClassName'];
    asmCSectionName = json['asmC_SectionName'];
    asmSId = json['asmS_Id'];
    amsTMobileNo = json['amsT_MobileNo'];
    userId = json['userId'];
    ivrmrTId = json['ivrmrT_Id'];
    acertapPId = json['acertapP_Id'];
    acertapPCertificateName = json['acertapP_CertificateName'];
    acertapPCertificateCode = json['acertapP_CertificateCode'];
    acertapPOnlineDownloadFlg = json['acertapP_OnlineDownloadFlg'];
    acertapPApprovaReqlFlg = json['acertapP_ApprovaReqlFlg'];
    amcTActiceFlag = json['amcT_ActiceFlag'];
    returnval = json['returnval'];
    hrmEId = json['hrmE_Id'];
    duplicate = json['duplicate'];
    ascaReason = json['ascA_Reason'];
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
    data['ascA_Status'] = ascAStatus;
    data['ascA_ActiveFlg'] = ascAActiveFlg;
    data['ascaP_Id'] = ascaPId;
    data['ivrmalU_Id'] = ivrmalUId;
    data['ascaP_ApproveDate'] = ascaPApproveDate;
    data['ascaP_ActiveFlg'] = ascaPActiveFlg;
    data['acertapP_ActiveFlg'] = acertapPActiveFlg;
    data['asmcL_Id'] = asmcLId;
    data['amsT_FirstName'] = amsTFirstName;
    data['asmcL_ClassName'] = asmcLClassName;
    data['asmC_SectionName'] = asmCSectionName;
    data['asmS_Id'] = asmSId;
    data['amsT_MobileNo'] = amsTMobileNo;
    data['userId'] = userId;
    data['ivrmrT_Id'] = ivrmrTId;
    data['acertapP_Id'] = acertapPId;
    data['acertapP_CertificateName'] = acertapPCertificateName;
    data['acertapP_CertificateCode'] = acertapPCertificateCode;
    data['acertapP_OnlineDownloadFlg'] = acertapPOnlineDownloadFlg;
    data['acertapP_ApprovaReqlFlg'] = acertapPApprovaReqlFlg;
    data['amcT_ActiceFlag'] = amcTActiceFlag;
    data['returnval'] = returnval;
    data['hrmE_Id'] = hrmEId;
    data['duplicate'] = duplicate;
    data['ascA_Reason'] = ascaReason;
    return data;
  }
}
