class DepartwisedeviationModel {
  String? type;
  List<DepartwisedeviationModelValues>? values;

  DepartwisedeviationModel({this.type, this.values});

  DepartwisedeviationModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DepartwisedeviationModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DepartwisedeviationModelValues.fromJson(v));
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

class DepartwisedeviationModelValues {
  int? ismdRId;
  int? mIId;
  int? hrmDId;
  String? ismdRRemarks;
  bool? ismdRActiveFlag;
  int? ismdRCreatedBy;
  int? ismdRUptadedBy;
  bool? ismdRReasonFlag;
  String? createdDate;
  String? updatedDate;

  DepartwisedeviationModelValues(
      {this.ismdRId,
      this.mIId,
      this.hrmDId,
      this.ismdRRemarks,
      this.ismdRActiveFlag,
      this.ismdRCreatedBy,
      this.ismdRUptadedBy,
      this.ismdRReasonFlag,
      this.createdDate,
      this.updatedDate});

  DepartwisedeviationModelValues.fromJson(Map<String, dynamic> json) {
    ismdRId = json['ismdR_Id'];
    mIId = json['mI_Id'];
    hrmDId = json['hrmD_Id'];
    ismdRRemarks = json['ismdR_Remarks'];
    ismdRActiveFlag = json['ismdR_ActiveFlag'];
    ismdRCreatedBy = json['ismdR_CreatedBy'];
    ismdRUptadedBy = json['ismdR_UptadedBy'];
    ismdRReasonFlag = json['ismdR_ReasonFlag'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ismdR_Id'] = ismdRId;
    data['mI_Id'] = mIId;
    data['hrmD_Id'] = hrmDId;
    data['ismdR_Remarks'] = ismdRRemarks;
    data['ismdR_ActiveFlag'] = ismdRActiveFlag;
    data['ismdR_CreatedBy'] = ismdRCreatedBy;
    data['ismdR_UptadedBy'] = ismdRUptadedBy;
    data['ismdR_ReasonFlag'] = ismdRReasonFlag;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
