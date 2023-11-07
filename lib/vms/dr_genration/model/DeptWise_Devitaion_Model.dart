class DepartwisedeviationModel {
  String? type;
  List<DepartwisedeviationModelValues>? values;

  DepartwisedeviationModel({this.type, this.values});

  DepartwisedeviationModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DepartwisedeviationModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new DepartwisedeviationModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ismdR_Id'] = this.ismdRId;
    data['mI_Id'] = this.mIId;
    data['hrmD_Id'] = this.hrmDId;
    data['ismdR_Remarks'] = this.ismdRRemarks;
    data['ismdR_ActiveFlag'] = this.ismdRActiveFlag;
    data['ismdR_CreatedBy'] = this.ismdRCreatedBy;
    data['ismdR_UptadedBy'] = this.ismdRUptadedBy;
    data['ismdR_ReasonFlag'] = this.ismdRReasonFlag;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}
