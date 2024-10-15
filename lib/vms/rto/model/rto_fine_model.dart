class RtoFineModel {
  String? type;
  List<RtoFineModelValues>? values;

  RtoFineModel({this.type, this.values});

  RtoFineModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <RtoFineModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(RtoFineModelValues.fromJson(v));
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

class RtoFineModelValues {
  int? rtomfPId;
  String? rtomfPFineParameterName;
  double? rtomfPFineAmount;
  int? rtomfPMaxViolationPermitted;
  String? rtomfPParameterDescription;
  bool? rtomfPActiveFlag;
  String? rtomfPCreatedDate;
  String? rtomfPUpdatedDate;
  int? rtomfPCreatedBy;
  int? rtomfPUpdatedBy;

  RtoFineModelValues(
      {this.rtomfPId,
      this.rtomfPFineParameterName,
      this.rtomfPFineAmount,
      this.rtomfPMaxViolationPermitted,
      this.rtomfPParameterDescription,
      this.rtomfPActiveFlag,
      this.rtomfPCreatedDate,
      this.rtomfPUpdatedDate,
      this.rtomfPCreatedBy,
      this.rtomfPUpdatedBy});

  RtoFineModelValues.fromJson(Map<String, dynamic> json) {
    rtomfPId = json['rtomfP_Id'];
    rtomfPFineParameterName = json['rtomfP_FineParameterName'];
    rtomfPFineAmount = json['rtomfP_FineAmount'];
    rtomfPMaxViolationPermitted = json['rtomfP_MaxViolationPermitted'];
    rtomfPParameterDescription = json['rtomfP_ParameterDescription'];
    rtomfPActiveFlag = json['rtomfP_ActiveFlag'];
    rtomfPCreatedDate = json['rtomfP_CreatedDate'];
    rtomfPUpdatedDate = json['rtomfP_UpdatedDate'];
    rtomfPCreatedBy = json['rtomfP_CreatedBy'];
    rtomfPUpdatedBy = json['rtomfP_UpdatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rtomfP_Id'] = rtomfPId;
    data['rtomfP_FineParameterName'] = rtomfPFineParameterName;
    data['rtomfP_FineAmount'] = rtomfPFineAmount;
    data['rtomfP_MaxViolationPermitted'] = rtomfPMaxViolationPermitted;
    data['rtomfP_ParameterDescription'] = rtomfPParameterDescription;
    data['rtomfP_ActiveFlag'] = rtomfPActiveFlag;
    data['rtomfP_CreatedDate'] = rtomfPCreatedDate;
    data['rtomfP_UpdatedDate'] = rtomfPUpdatedDate;
    data['rtomfP_CreatedBy'] = rtomfPCreatedBy;
    data['rtomfP_UpdatedBy'] = rtomfPUpdatedBy;
    return data;
  }
}
