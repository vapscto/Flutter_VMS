class StudentDetails {
  String? type;
  List<StudentDetailsValues>? values;

  StudentDetails({this.type, this.values});

  StudentDetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <StudentDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(StudentDetailsValues.fromJson(v));
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

class StudentDetailsValues {
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
  String? amsTFirstName;
  String? asmcLClassName;
  String? asmCSectionName;
  int? asmSId;
  String? amsTRegistrationNo;
  String? amsTEmailId;
  int? amsTMobileNo;
  int? userId;
  int? ivrmrTId;
  int? acertapPId;
  bool? acertapPOnlineDownloadFlg;
  bool? acertapPApprovaReqlFlg;
  bool? amcTActiceFlag;
  bool? returnval;
  int? hrmEId;
  bool? duplicate;

  StudentDetailsValues(
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
      this.amsTFirstName,
      this.asmcLClassName,
      this.asmCSectionName,
      this.asmSId,
      this.amsTRegistrationNo,
      this.amsTEmailId,
      this.amsTMobileNo,
      this.userId,
      this.ivrmrTId,
      this.acertapPId,
      this.acertapPOnlineDownloadFlg,
      this.acertapPApprovaReqlFlg,
      this.amcTActiceFlag,
      this.returnval,
      this.hrmEId,
      this.duplicate});

  StudentDetailsValues.fromJson(Map<String, dynamic> json) {
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
    amsTFirstName = json['amsT_FirstName'];
    asmcLClassName = json['asmcL_ClassName'];
    asmCSectionName = json['asmC_SectionName'];
    asmSId = json['asmS_Id'];
    amsTRegistrationNo = json['amsT_RegistrationNo'];
    amsTEmailId = json['amsT_emailId'];
    amsTMobileNo = json['amsT_MobileNo'];
    userId = json['userId'];
    ivrmrTId = json['ivrmrT_Id'];
    acertapPId = json['acertapP_Id'];
    acertapPOnlineDownloadFlg = json['acertapP_OnlineDownloadFlg'];
    acertapPApprovaReqlFlg = json['acertapP_ApprovaReqlFlg'];
    amcTActiceFlag = json['amcT_ActiceFlag'];
    returnval = json['returnval'];
    hrmEId = json['hrmE_Id'];
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
    data['amsT_FirstName'] = amsTFirstName;
    data['asmcL_ClassName'] = asmcLClassName;
    data['asmC_SectionName'] = asmCSectionName;
    data['asmS_Id'] = asmSId;
    data['amsT_RegistrationNo'] = amsTRegistrationNo;
    data['amsT_emailId'] = amsTEmailId;
    data['amsT_MobileNo'] = amsTMobileNo;
    data['userId'] = userId;
    data['ivrmrT_Id'] = ivrmrTId;
    data['acertapP_Id'] = acertapPId;
    data['acertapP_OnlineDownloadFlg'] = acertapPOnlineDownloadFlg;
    data['acertapP_ApprovaReqlFlg'] = acertapPApprovaReqlFlg;
    data['amcT_ActiceFlag'] = amcTActiceFlag;
    data['returnval'] = returnval;
    data['hrmE_Id'] = hrmEId;
    data['duplicate'] = duplicate;
    return data;
  }
}
