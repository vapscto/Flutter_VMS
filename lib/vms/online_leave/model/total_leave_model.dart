class TotalLeaveCountModel {
  String? type;
  List<TotalLeaveCountModelValues>? values;

  TotalLeaveCountModel({this.type, this.values});

  TotalLeaveCountModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TotalLeaveCountModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TotalLeaveCountModelValues.fromJson(v));
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

class TotalLeaveCountModelValues {
  int? hrelSId;
  int? mIId;
  int? hrmEId;
  int? hrmLId;
  int? hrmlYId;
  double? hrelSOBLeaves;
  double? hrelSCreditedLeaves;
  double? hrelSTotalLeaves;
  double? hrelSTransLeaves;
  int? hrelSEncashedLeaves;
  double? hrelSCBLeaves;
  String? createdDate;
  String? updatedDate;
  int? hrelSCreatedBy;
  int? hrelSUpdatedBy;

  TotalLeaveCountModelValues(
      {this.hrelSId,
      this.mIId,
      this.hrmEId,
      this.hrmLId,
      this.hrmlYId,
      this.hrelSOBLeaves,
      this.hrelSCreditedLeaves,
      this.hrelSTotalLeaves,
      this.hrelSTransLeaves,
      this.hrelSEncashedLeaves,
      this.hrelSCBLeaves,
      this.createdDate,
      this.updatedDate,
      this.hrelSCreatedBy,
      this.hrelSUpdatedBy});

  TotalLeaveCountModelValues.fromJson(Map<String, dynamic> json) {
    hrelSId = json['hrelS_Id'];
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    hrmLId = json['hrmL_Id'];
    hrmlYId = json['hrmlY_Id'];
    hrelSOBLeaves = json['hrelS_OBLeaves'];
    hrelSCreditedLeaves = json['hrelS_CreditedLeaves'];
    hrelSTotalLeaves = json['hrelS_TotalLeaves'];
    hrelSTransLeaves = json['hrelS_TransLeaves'];
    hrelSEncashedLeaves = json['hrelS_EncashedLeaves'];
    hrelSCBLeaves = json['hrelS_CBLeaves'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    hrelSCreatedBy = json['hrelS_CreatedBy'];
    hrelSUpdatedBy = json['hrelS_UpdatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hrelS_Id'] = hrelSId;
    data['mI_Id'] = mIId;
    data['hrmE_Id'] = hrmEId;
    data['hrmL_Id'] = hrmLId;
    data['hrmlY_Id'] = hrmlYId;
    data['hrelS_OBLeaves'] = hrelSOBLeaves;
    data['hrelS_CreditedLeaves'] = hrelSCreditedLeaves;
    data['hrelS_TotalLeaves'] = hrelSTotalLeaves;
    data['hrelS_TransLeaves'] = hrelSTransLeaves;
    data['hrelS_EncashedLeaves'] = hrelSEncashedLeaves;
    data['hrelS_CBLeaves'] = hrelSCBLeaves;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['hrelS_CreatedBy'] = hrelSCreatedBy;
    data['hrelS_UpdatedBy'] = hrelSUpdatedBy;
    return data;
  }
}
