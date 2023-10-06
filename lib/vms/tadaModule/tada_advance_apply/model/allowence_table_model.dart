class AllowenseTableModel {
  String? type;
  List<AllowenseTableModelValues>? values;

  AllowenseTableModel({this.type, this.values});

  AllowenseTableModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <AllowenseTableModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(AllowenseTableModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllowenseTableModelValues {
  int? vtadacMId;
  int? mIId;
  int? hrmdeSId;
  int? ivrmmcTId;
  double? vtadacMFoodAmt;
  double? vtadacMAccommodationAmt;
  double? vtadacMTransportAmt;
  bool? vtadacMActiveFlag;
  String? vtadacMCreatedDate;
  String? vtadacMUpdatedDate;
  int? vtadacMCreatedBy;
  int? vtadacMUpdatedBy;

  AllowenseTableModelValues(
      {this.vtadacMId,
      this.mIId,
      this.hrmdeSId,
      this.ivrmmcTId,
      this.vtadacMFoodAmt,
      this.vtadacMAccommodationAmt,
      this.vtadacMTransportAmt,
      this.vtadacMActiveFlag,
      this.vtadacMCreatedDate,
      this.vtadacMUpdatedDate,
      this.vtadacMCreatedBy,
      this.vtadacMUpdatedBy});

  AllowenseTableModelValues.fromJson(Map<String, dynamic> json) {
    vtadacMId = json['vtadacM_Id'];
    mIId = json['mI_Id'];
    hrmdeSId = json['hrmdeS_Id'];
    ivrmmcTId = json['ivrmmcT_Id'];
    vtadacMFoodAmt = json['vtadacM_FoodAmt'];
    vtadacMAccommodationAmt = json['vtadacM_AccommodationAmt'];
    vtadacMTransportAmt = json['vtadacM_TransportAmt'];
    vtadacMActiveFlag = json['vtadacM_ActiveFlag'];
    vtadacMCreatedDate = json['vtadacM_CreatedDate'];
    vtadacMUpdatedDate = json['vtadacM_UpdatedDate'];
    vtadacMCreatedBy = json['vtadacM_CreatedBy'];
    vtadacMUpdatedBy = json['vtadacM_UpdatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vtadacM_Id'] = vtadacMId;
    data['mI_Id'] = mIId;
    data['hrmdeS_Id'] = hrmdeSId;
    data['ivrmmcT_Id'] = ivrmmcTId;
    data['vtadacM_FoodAmt'] = vtadacMFoodAmt;
    data['vtadacM_AccommodationAmt'] = vtadacMAccommodationAmt;
    data['vtadacM_TransportAmt'] = vtadacMTransportAmt;
    data['vtadacM_ActiveFlag'] = vtadacMActiveFlag;
    data['vtadacM_CreatedDate'] = vtadacMCreatedDate;
    data['vtadacM_UpdatedDate'] = vtadacMUpdatedDate;
    data['vtadacM_CreatedBy'] = vtadacMCreatedBy;
    data['vtadacM_UpdatedBy'] = vtadacMUpdatedBy;
    return data;
  }
}
