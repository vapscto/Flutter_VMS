class CertificateDocumentModel {
  String? type;
  List<CertificateDocumentModelValues>? values;

  CertificateDocumentModel({this.type, this.values});

  CertificateDocumentModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CertificateDocumentModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CertificateDocumentModelValues.fromJson(v));
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

class CertificateDocumentModelValues {
  int? hrmedSId;
  int? mIId;
  int? hrmEId;
  String? hrmedSDocumentName;
  String? hrmedSDocumentImageName;
  bool? hrmedSReturnFlg;
  String? hrmedSDucumentDescription;
  int? hrmedSUpdatedBy;
  int? hrmedSCreatedBy;
  String? createdDate;
  String? updatedDate;

  CertificateDocumentModelValues(
      {this.hrmedSId,
      this.mIId,
      this.hrmEId,
      this.hrmedSDocumentName,
      this.hrmedSDocumentImageName,
      this.hrmedSReturnFlg,
      this.hrmedSDucumentDescription,
      this.hrmedSUpdatedBy,
      this.hrmedSCreatedBy,
      this.createdDate,
      this.updatedDate});

  CertificateDocumentModelValues.fromJson(Map<String, dynamic> json) {
    hrmedSId = json['hrmedS_Id'];
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    hrmedSDocumentName = json['hrmedS_DocumentName'];
    hrmedSDocumentImageName = json['hrmedS_DocumentImageName'];
    hrmedSReturnFlg = json['hrmedS_ReturnFlg'];
    hrmedSDucumentDescription = json['hrmedS_DucumentDescription'];
    hrmedSUpdatedBy = json['hrmedS_UpdatedBy'];
    hrmedSCreatedBy = json['hrmedS_CreatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hrmedS_Id'] = hrmedSId;
    data['mI_Id'] = mIId;
    data['hrmE_Id'] = hrmEId;
    data['hrmedS_DocumentName'] = hrmedSDocumentName;
    data['hrmedS_DocumentImageName'] = hrmedSDocumentImageName;
    data['hrmedS_ReturnFlg'] = hrmedSReturnFlg;
    data['hrmedS_DucumentDescription'] = hrmedSDucumentDescription;
    data['hrmedS_UpdatedBy'] = hrmedSUpdatedBy;
    data['hrmedS_CreatedBy'] = hrmedSCreatedBy;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
