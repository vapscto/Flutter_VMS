class NocAppliedListModel {
  String? type;
  List<NocAppliedListModelValues>? values;

  NocAppliedListModel({this.type, this.values});

  NocAppliedListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <NocAppliedListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(NocAppliedListModelValues.fromJson(v));
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

class NocAppliedListModelValues {
  String? type;
  String? iSMCERTREQId;
  String? iSMCERTREQRequestDate;
  String? hRMEId;
  String? hRMEEmployeeFirstname;
  String? iSMCERTREQFilePath;

  NocAppliedListModelValues(
      {this.type,
      this.iSMCERTREQId,
      this.iSMCERTREQRequestDate,
      this.hRMEId,
      this.hRMEEmployeeFirstname,
      this.iSMCERTREQFilePath});

  NocAppliedListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMCERTREQId = json['ISMCERTREQ_Id'];
    iSMCERTREQRequestDate = json['ISMCERTREQ_RequestDate'];
    hRMEId = json['HRME_Id'];
    hRMEEmployeeFirstname = json['HRME_EmployeeFirstname'];
    iSMCERTREQFilePath = json['ISMCERTREQ_FilePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMCERTREQ_Id'] = iSMCERTREQId;
    data['ISMCERTREQ_RequestDate'] = iSMCERTREQRequestDate;
    data['HRME_Id'] = hRMEId;
    data['HRME_EmployeeFirstname'] = hRMEEmployeeFirstname;
    data['ISMCERTREQ_FilePath'] = iSMCERTREQFilePath;
    return data;
  }
}
