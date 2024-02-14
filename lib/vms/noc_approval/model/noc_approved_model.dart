class NocApprovedModel {
  String? type;
  List<NocApprovedModelValues>? values;

  NocApprovedModel({this.type, this.values});

  NocApprovedModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <NocApprovedModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(NocApprovedModelValues.fromJson(v));
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

class NocApprovedModelValues {
  String? type;
  int? iSMCERTREQAPPId;
  int? iSMCERTREQId;
  String? hRMEEmployeeFirstName;
  int? hRMEId;
  String? iSMCERTREQAPPRemarks;
  String? iSMCERTREQRequestDate;
  String? iSMRESGAccRejDate;
  String? iSMCERTREQAPPAppRejFlag;
  String? iSMCERTREQFilePath;
  String? iSMRESGABDate;

  NocApprovedModelValues(
      {this.type,
      this.iSMCERTREQAPPId,
      this.iSMCERTREQId,
      this.hRMEEmployeeFirstName,
      this.hRMEId,
      this.iSMCERTREQAPPRemarks,
      this.iSMCERTREQRequestDate,
      this.iSMRESGAccRejDate,
      this.iSMCERTREQAPPAppRejFlag,
      this.iSMCERTREQFilePath,
      this.iSMRESGABDate});

  NocApprovedModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMCERTREQAPPId = json['ISMCERTREQAPP_Id'];
    iSMCERTREQId = json['ISMCERTREQ_Id'];
    hRMEEmployeeFirstName = json['HRME_EmployeeFirstName'];
    hRMEId = json['HRME_Id'];
    iSMCERTREQAPPRemarks = json['ISMCERTREQAPP_Remarks'];
    iSMCERTREQRequestDate = json['ISMCERTREQ_RequestDate'];
    iSMRESGAccRejDate = json['ISMRESG_AccRejDate'];
    iSMCERTREQAPPAppRejFlag = json['ISMCERTREQAPP_AppRejFlag'];
    iSMCERTREQFilePath = json['ISMCERTREQ_FilePath'];
    iSMRESGABDate = json['ISMRESGAB_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMCERTREQAPP_Id'] = iSMCERTREQAPPId;
    data['ISMCERTREQ_Id'] = iSMCERTREQId;
    data['HRME_EmployeeFirstName'] = hRMEEmployeeFirstName;
    data['HRME_Id'] = hRMEId;
    data['ISMCERTREQAPP_Remarks'] = iSMCERTREQAPPRemarks;
    data['ISMCERTREQ_RequestDate'] = iSMCERTREQRequestDate;
    data['ISMRESG_AccRejDate'] = iSMRESGAccRejDate;
    data['ISMCERTREQAPP_AppRejFlag'] = iSMCERTREQAPPAppRejFlag;
    data['ISMCERTREQ_FilePath'] = iSMCERTREQFilePath;
    data['ISMRESGAB_Date'] = iSMRESGABDate;
    return data;
  }
}
