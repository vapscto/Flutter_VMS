class CertificateDropDown {
  String? type;
  List<CertificateDropDownValues>? values;

  CertificateDropDown({this.type, this.values});

  CertificateDropDown.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CertificateDropDownValues>[];
      json['\$values'].forEach((v) {
        values!.add(CertificateDropDownValues.fromJson(v));
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

class CertificateDropDownValues {
  int? amcTId;
  String? amcTCertificateName;
  String? amcTCertificateCode;
  String? amcTDescription;
  bool? amcTActiceFlag;
  String? createdDate;
  String? updatedDate;

  CertificateDropDownValues(
      {this.amcTId,
      this.amcTCertificateName,
      this.amcTCertificateCode,
      this.amcTDescription,
      this.amcTActiceFlag,
      this.createdDate,
      this.updatedDate});

  CertificateDropDownValues.fromJson(Map<String, dynamic> json) {
    amcTId = json['amcT_Id'];
    amcTCertificateName = json['amcT_Certificate_Name'];
    amcTCertificateCode = json['amcT_Certificate_code'];
    amcTDescription = json['amcT_Description'];
    amcTActiceFlag = json['amcT_ActiceFlag'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amcT_Id'] = amcTId;
    data['amcT_Certificate_Name'] = amcTCertificateName;
    data['amcT_Certificate_code'] = amcTCertificateCode;
    data['amcT_Description'] = amcTDescription;
    data['amcT_ActiceFlag'] = amcTActiceFlag;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
