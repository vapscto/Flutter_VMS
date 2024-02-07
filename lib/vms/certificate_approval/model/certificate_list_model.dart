class CertificatelistModel {
  String? type;
  List<CertificatelistModelValues>? values;

  CertificatelistModel({this.type, this.values});

  CertificatelistModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CertificatelistModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CertificatelistModelValues.fromJson(v));
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

class CertificatelistModelValues {
  String? type;
  String? iSMCERTREQId;
  String? iSMCERTREQRequestDate;
  String? iSMCERTREQCertificateName;
  String? iSMCERTREQReceivingMode;
  String? hRMEId;
  String? hRMEEmployeeFirstname;
  String? iSMCERTREQFilePath;

  CertificatelistModelValues(
      {this.type,
      this.iSMCERTREQId,
      this.iSMCERTREQRequestDate,
      this.iSMCERTREQCertificateName,
      this.iSMCERTREQReceivingMode,
      this.hRMEId,
      this.hRMEEmployeeFirstname,
      this.iSMCERTREQFilePath});

  CertificatelistModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMCERTREQId = json['ISMCERTREQ_Id'];
    iSMCERTREQRequestDate = json['ISMCERTREQ_RequestDate'];
    iSMCERTREQCertificateName = json['ISMCERTREQ_CertificateName'];
    iSMCERTREQReceivingMode = json['ISMCERTREQ_ReceivingMode'];
    hRMEId = json['HRME_Id'];
    hRMEEmployeeFirstname = json['HRME_EmployeeFirstname'];
    iSMCERTREQFilePath = json['ISMCERTREQ_FilePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMCERTREQ_Id'] = iSMCERTREQId;
    data['ISMCERTREQ_RequestDate'] = iSMCERTREQRequestDate;
    data['ISMCERTREQ_CertificateName'] = iSMCERTREQCertificateName;
    data['ISMCERTREQ_ReceivingMode'] = iSMCERTREQReceivingMode;
    data['HRME_Id'] = hRMEId;
    data['HRME_EmployeeFirstname'] = hRMEEmployeeFirstname;
    data['ISMCERTREQ_FilePath'] = iSMCERTREQFilePath;
    return data;
  }
}
