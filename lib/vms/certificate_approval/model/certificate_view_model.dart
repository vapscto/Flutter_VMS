class PreviousApprovedViewModel {
  String? type;
  List<PreviousApprovedViewModelValues>? values;

  PreviousApprovedViewModel({this.type, this.values});

  PreviousApprovedViewModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PreviousApprovedViewModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(PreviousApprovedViewModelValues.fromJson(v));
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

class PreviousApprovedViewModelValues {
  int? hrpaoNId;
  int? hrpAId;
  int? ivrmuLId;
  int? hrpaoNSanctionLevelNo;
  bool? hrpaoNFinalFlg;
  String? createdDate;
  String? updatedDate;

  PreviousApprovedViewModelValues(
      {this.hrpaoNId,
      this.hrpAId,
      this.ivrmuLId,
      this.hrpaoNSanctionLevelNo,
      this.hrpaoNFinalFlg,
      this.createdDate,
      this.updatedDate});

  PreviousApprovedViewModelValues.fromJson(Map<String, dynamic> json) {
    hrpaoNId = json['hrpaoN_Id'];
    hrpAId = json['hrpA_Id'];
    ivrmuLId = json['ivrmuL_Id'];
    hrpaoNSanctionLevelNo = json['hrpaoN_SanctionLevelNo'];
    hrpaoNFinalFlg = json['hrpaoN_FinalFlg'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hrpaoN_Id'] = hrpaoNId;
    data['hrpA_Id'] = hrpAId;
    data['ivrmuL_Id'] = ivrmuLId;
    data['hrpaoN_SanctionLevelNo'] = hrpaoNSanctionLevelNo;
    data['hrpaoN_FinalFlg'] = hrpaoNFinalFlg;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
