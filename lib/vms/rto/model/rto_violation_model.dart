class RtoViolationModel {
  String? type;
  List<RtoViolationModelValues>? values;

  RtoViolationModel({this.type, this.values});

  RtoViolationModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <RtoViolationModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(RtoViolationModelValues.fromJson(v));
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

class RtoViolationModelValues {
  String? type;
  int? rTOVOBId;
  String? rTOVOBDate;
  bool? rTOVOBActiveFlag;
  bool? rTOVOBAnyViolationFlg;
  double? rTOVOBFineAmount;
  bool? rTOVOBFineAmountPaidFlg;
  String? rTOVOBViolationDescription;
  int? hRMEId;
  String? tRMVVehicleName;
  String? tRMVVehicleNo;
  int? rTOMFPId;
  String? rTOVOBDateTimeOfViolation;
  String? eMPNAME;
  String? applicationuser;
  int? tRMVId;

  RtoViolationModelValues(
      {this.type,
      this.rTOVOBId,
      this.rTOVOBDate,
      this.rTOVOBActiveFlag,
      this.rTOVOBAnyViolationFlg,
      this.rTOVOBFineAmount,
      this.rTOVOBFineAmountPaidFlg,
      this.rTOVOBViolationDescription,
      this.hRMEId,
      this.tRMVVehicleName,
      this.tRMVVehicleNo,
      this.rTOMFPId,
      this.rTOVOBDateTimeOfViolation,
      this.eMPNAME,
      this.applicationuser,
      this.tRMVId});

  RtoViolationModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    rTOVOBId = json['RTOVOB_Id'];
    rTOVOBDate = json['RTOVOB_Date'];
    rTOVOBActiveFlag = json['RTOVOB_ActiveFlag'];
    rTOVOBAnyViolationFlg = json['RTOVOB_AnyViolationFlg'];
    rTOVOBFineAmount = json['RTOVOB_FineAmount'];
    rTOVOBFineAmountPaidFlg = json['RTOVOB_FineAmountPaidFlg'];
    rTOVOBViolationDescription = json['RTOVOB_ViolationDescription'];
    hRMEId = json['HRME_Id'];
    tRMVVehicleName = json['TRMV_VehicleName'];
    tRMVVehicleNo = json['TRMV_VehicleNo'];
    rTOMFPId = json['RTOMFP_Id'];
    rTOVOBDateTimeOfViolation = json['RTOVOB_DateTimeOfViolation'];
    eMPNAME = json['EMPNAME'];
    applicationuser = json['Applicationuser'];
    tRMVId = json['TRMV_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['RTOVOB_Id'] = rTOVOBId;
    data['RTOVOB_Date'] = rTOVOBDate;
    data['RTOVOB_ActiveFlag'] = rTOVOBActiveFlag;
    data['RTOVOB_AnyViolationFlg'] = rTOVOBAnyViolationFlg;
    data['RTOVOB_FineAmount'] = rTOVOBFineAmount;
    data['RTOVOB_FineAmountPaidFlg'] = rTOVOBFineAmountPaidFlg;
    data['RTOVOB_ViolationDescription'] = rTOVOBViolationDescription;
    data['HRME_Id'] = hRMEId;
    data['TRMV_VehicleName'] = tRMVVehicleName;
    data['TRMV_VehicleNo'] = tRMVVehicleNo;
    data['RTOMFP_Id'] = rTOMFPId;
    data['RTOVOB_DateTimeOfViolation'] = rTOVOBDateTimeOfViolation;
    data['EMPNAME'] = eMPNAME;
    data['Applicationuser'] = applicationuser;
    data['TRMV_Id'] = tRMVId;
    return data;
  }
}
