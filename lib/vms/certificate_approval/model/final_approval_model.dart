class CertificateFinalApprovalModel {
  String? type;
  List<CertificateFinalApprovalModelValues>? values;

  CertificateFinalApprovalModel({this.type, this.values});

  CertificateFinalApprovalModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CertificateFinalApprovalModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CertificateFinalApprovalModelValues.fromJson(v));
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

class CertificateFinalApprovalModelValues {
  String? type;
  int? iSMCERTREQId;
  String? iSMCERTDISDETReceivedMode;
  double? iSMCERTDISDETFineAmount;
  String? iSMCERTDISDETFileName;
  String? iSMCERTDISDETFiePath;
  String? iSMCERTDISDETRemarks;
  bool? iSMCERTDISDETActiveFlag;
  String? iSMCERTDISDETReceivingFromDate;
  String? iSMCERTDISDETReceivingToDate;
  String? iSMCERTREQAPPApprovedDate;
  String? iSMCERTREQAPPReceiningDate;
  String? iSMCERTREQAPPRemarks;
  bool? iSMCERTREQAPPFinalFlg;
  String? iSMCERTREQAPPAppRejFlag;
  String? iSMCERTDISDETReceivedateTime;
  String? iSMCERTREQAPPACK;
  String? iSMCERTREQRequestDate;
  String? iSMCERTREQRemarks;
  String? iSMCERTREQReceivingMode;
  String? iSMCERTREQFileName;
  String? iSMCERTREQFilePath;
  bool? iSMCERTREQActiveFlag;
  String? iSMCERTREQAppRejFlag;
  String? iSMCERTREQRecivingAddress;
  String? authorisedEmployee;

  CertificateFinalApprovalModelValues(
      {this.type,
      this.iSMCERTREQId,
      this.iSMCERTDISDETReceivedMode,
      this.iSMCERTDISDETFineAmount,
      this.iSMCERTDISDETFileName,
      this.iSMCERTDISDETFiePath,
      this.iSMCERTDISDETRemarks,
      this.iSMCERTDISDETActiveFlag,
      this.iSMCERTDISDETReceivingFromDate,
      this.iSMCERTDISDETReceivingToDate,
      this.iSMCERTREQAPPApprovedDate,
      this.iSMCERTREQAPPReceiningDate,
      this.iSMCERTREQAPPRemarks,
      this.iSMCERTREQAPPFinalFlg,
      this.iSMCERTREQAPPAppRejFlag,
      this.iSMCERTDISDETReceivedateTime,
      this.iSMCERTREQAPPACK,
      this.iSMCERTREQRequestDate,
      this.iSMCERTREQRemarks,
      this.iSMCERTREQReceivingMode,
      this.iSMCERTREQFileName,
      this.iSMCERTREQFilePath,
      this.iSMCERTREQActiveFlag,
      this.iSMCERTREQAppRejFlag,
      this.iSMCERTREQRecivingAddress,
      this.authorisedEmployee});

  CertificateFinalApprovalModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMCERTREQId = json['ISMCERTREQ_Id'];
    iSMCERTDISDETReceivedMode = json['ISMCERTDISDET_ReceivedMode'];
    iSMCERTDISDETFineAmount = json['ISMCERTDISDET_FineAmount'];
    iSMCERTDISDETFileName = json['ISMCERTDISDET_FileName'];
    iSMCERTDISDETFiePath = json['ISMCERTDISDET_FiePath'];
    iSMCERTDISDETRemarks = json['ISMCERTDISDET_Remarks'];
    iSMCERTDISDETActiveFlag = json['ISMCERTDISDET_ActiveFlag'];
    iSMCERTDISDETReceivingFromDate = json['ISMCERTDISDET_ReceivingFromDate'];
    iSMCERTDISDETReceivingToDate = json['ISMCERTDISDET_ReceivingToDate'];
    iSMCERTREQAPPApprovedDate = json['ISMCERTREQAPP_ApprovedDate'];
    iSMCERTREQAPPReceiningDate = json['ISMCERTREQAPP_ReceiningDate'];
    iSMCERTREQAPPRemarks = json['ISMCERTREQAPP_Remarks'];
    iSMCERTREQAPPFinalFlg = json['ISMCERTREQAPP_FinalFlg'];
    iSMCERTREQAPPAppRejFlag = json['ISMCERTREQAPP_AppRejFlag'];
    iSMCERTDISDETReceivedateTime = json['ISMCERTDISDET_ReceivedateTime'];
    iSMCERTREQAPPACK = json['ISMCERTREQAPP_ACK'];
    iSMCERTREQRequestDate = json['ISMCERTREQ_RequestDate'];
    iSMCERTREQRemarks = json['ISMCERTREQ_Remarks'];
    iSMCERTREQReceivingMode = json['ISMCERTREQ_ReceivingMode'];
    iSMCERTREQFileName = json['ISMCERTREQ_FileName'];
    iSMCERTREQFilePath = json['ISMCERTREQ_FilePath'];
    iSMCERTREQActiveFlag = json['ISMCERTREQ_ActiveFlag'];
    iSMCERTREQAppRejFlag = json['ISMCERTREQ_AppRejFlag'];
    iSMCERTREQRecivingAddress = json['ISMCERTREQ_RecivingAddress'];
    authorisedEmployee = json['AuthorisedEmployee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMCERTREQ_Id'] = iSMCERTREQId;
    data['ISMCERTDISDET_ReceivedMode'] = iSMCERTDISDETReceivedMode;
    data['ISMCERTDISDET_FineAmount'] = iSMCERTDISDETFineAmount;
    data['ISMCERTDISDET_FileName'] = iSMCERTDISDETFileName;
    data['ISMCERTDISDET_FiePath'] = iSMCERTDISDETFiePath;
    data['ISMCERTDISDET_Remarks'] = iSMCERTDISDETRemarks;
    data['ISMCERTDISDET_ActiveFlag'] = iSMCERTDISDETActiveFlag;
    data['ISMCERTDISDET_ReceivingFromDate'] = iSMCERTDISDETReceivingFromDate;
    data['ISMCERTDISDET_ReceivingToDate'] = iSMCERTDISDETReceivingToDate;
    data['ISMCERTREQAPP_ApprovedDate'] = iSMCERTREQAPPApprovedDate;
    data['ISMCERTREQAPP_ReceiningDate'] = iSMCERTREQAPPReceiningDate;
    data['ISMCERTREQAPP_Remarks'] = iSMCERTREQAPPRemarks;
    data['ISMCERTREQAPP_FinalFlg'] = iSMCERTREQAPPFinalFlg;
    data['ISMCERTREQAPP_AppRejFlag'] = iSMCERTREQAPPAppRejFlag;
    data['ISMCERTDISDET_ReceivedateTime'] = iSMCERTDISDETReceivedateTime;
    data['ISMCERTREQAPP_ACK'] = iSMCERTREQAPPACK;
    data['ISMCERTREQ_RequestDate'] = iSMCERTREQRequestDate;
    data['ISMCERTREQ_Remarks'] = iSMCERTREQRemarks;
    data['ISMCERTREQ_ReceivingMode'] = iSMCERTREQReceivingMode;
    data['ISMCERTREQ_FileName'] = iSMCERTREQFileName;
    data['ISMCERTREQ_FilePath'] = iSMCERTREQFilePath;
    data['ISMCERTREQ_ActiveFlag'] = iSMCERTREQActiveFlag;
    data['ISMCERTREQ_AppRejFlag'] = iSMCERTREQAppRejFlag;
    data['ISMCERTREQ_RecivingAddress'] = iSMCERTREQRecivingAddress;
    data['AuthorisedEmployee'] = authorisedEmployee;
    return data;
  }
}
