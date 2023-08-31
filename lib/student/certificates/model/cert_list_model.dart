class CertificateList {
  String? type;
  List<CertificateListValues>? values;

  CertificateList({this.type, this.values});

  CertificateList.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CertificateListValues>[];
      json['\$values'].forEach((v) {
        values!.add(CertificateListValues.fromJson(v));
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

class CertificateListValues {
  int? acertapPId;
  int? mIId;
  String? acertapPCertificateName;
  String? acertapPCertificateCode;
  bool? acertapPApprovaReqlFlg;
  bool? acertapPOnlineDownloadFlg;
  bool? acertapPActiveFlg;
  String? createdDate;
  int? acertapPCreatedBy;
  int? acertapPUpdatedBy;

  CertificateListValues(
      {this.acertapPId,
      this.mIId,
      this.acertapPCertificateName,
      this.acertapPCertificateCode,
      this.acertapPApprovaReqlFlg,
      this.acertapPOnlineDownloadFlg,
      this.acertapPActiveFlg,
      this.createdDate,
      this.acertapPCreatedBy,
      this.acertapPUpdatedBy});

  CertificateListValues.fromJson(Map<String, dynamic> json) {
    acertapPId = json['acertapP_Id'];
    mIId = json['mI_Id'];
    acertapPCertificateName = json['acertapP_CertificateName'];
    acertapPCertificateCode = json['acertapP_CertificateCode'];
    acertapPApprovaReqlFlg = json['acertapP_ApprovaReqlFlg'];
    acertapPOnlineDownloadFlg = json['acertapP_OnlineDownloadFlg'];
    acertapPActiveFlg = json['acertapP_ActiveFlg'];
    createdDate = json['createdDate'];
    acertapPCreatedBy = json['acertapP_CreatedBy'];
    acertapPUpdatedBy = json['acertapP_UpdatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['acertapP_Id'] = acertapPId;
    data['mI_Id'] = mIId;
    data['acertapP_CertificateName'] = acertapPCertificateName;
    data['acertapP_CertificateCode'] = acertapPCertificateCode;
    data['acertapP_ApprovaReqlFlg'] = acertapPApprovaReqlFlg;
    data['acertapP_OnlineDownloadFlg'] = acertapPOnlineDownloadFlg;
    data['acertapP_ActiveFlg'] = acertapPActiveFlg;
    data['createdDate'] = createdDate;
    data['acertapP_CreatedBy'] = acertapPCreatedBy;
    data['acertapP_UpdatedBy'] = acertapPUpdatedBy;
    return data;
  }
}
