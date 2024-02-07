class CertificateApprovalListModel {
  String? type;
  List<CertificateApprovalListModelValues>? values;

  CertificateApprovalListModel({this.type, this.values});

  CertificateApprovalListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CertificateApprovalListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CertificateApprovalListModelValues.fromJson(v));
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

class CertificateApprovalListModelValues {
  String? type;
  int? iSMCERTREQAPPId;
  int? iSMCERTREQId;
  String? hRMEEmployeeFirstName;
  String? iSMCERTREQCertificateName;
  String? iSMCERTREQRequestDate;
  String? iSMCERTREQAPPApprovedDate;
  String? iSMCERTREQAPPAppRejFlag;
  String? iSMCERTREQFilePath;
  int? hRMEId;
  String? iSMCERTREQAPPRemarks;

  CertificateApprovalListModelValues(
      {this.type,
      this.iSMCERTREQAPPId,
      this.iSMCERTREQId,
      this.hRMEEmployeeFirstName,
      this.iSMCERTREQCertificateName,
      this.iSMCERTREQRequestDate,
      this.iSMCERTREQAPPApprovedDate,
      this.iSMCERTREQAPPAppRejFlag,
      this.iSMCERTREQFilePath,
      this.hRMEId,
      this.iSMCERTREQAPPRemarks});

  CertificateApprovalListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMCERTREQAPPId = json['ISMCERTREQAPP_Id'];
    iSMCERTREQId = json['ISMCERTREQ_Id'];
    hRMEEmployeeFirstName = json['HRME_EmployeeFirstName'];
    iSMCERTREQCertificateName = json['ISMCERTREQ_CertificateName'];
    iSMCERTREQRequestDate = json['ISMCERTREQ_RequestDate'];
    iSMCERTREQAPPApprovedDate = json['ISMCERTREQAPP_ApprovedDate'];
    iSMCERTREQAPPAppRejFlag = json['ISMCERTREQAPP_AppRejFlag'];
    iSMCERTREQFilePath = json['ISMCERTREQ_FilePath'];
    hRMEId = json['HRME_Id'];
    iSMCERTREQAPPRemarks = json['ISMCERTREQAPP_Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMCERTREQAPP_Id'] = iSMCERTREQAPPId;
    data['ISMCERTREQ_Id'] = iSMCERTREQId;
    data['HRME_EmployeeFirstName'] = hRMEEmployeeFirstName;
    data['ISMCERTREQ_CertificateName'] = iSMCERTREQCertificateName;
    data['ISMCERTREQ_RequestDate'] = iSMCERTREQRequestDate;
    data['ISMCERTREQAPP_ApprovedDate'] = iSMCERTREQAPPApprovedDate;
    data['ISMCERTREQAPP_AppRejFlag'] = iSMCERTREQAPPAppRejFlag;
    data['ISMCERTREQ_FilePath'] = iSMCERTREQFilePath;
    data['HRME_Id'] = hRMEId;
    data['ISMCERTREQAPP_Remarks'] = iSMCERTREQAPPRemarks;
    return data;
  }
}
