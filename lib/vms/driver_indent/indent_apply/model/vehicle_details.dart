class VehicleDetails {
  String? type;
  List<VehicleDetailsValues>? values;

  VehicleDetails({this.type, this.values});

  VehicleDetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <VehicleDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(VehicleDetailsValues.fromJson(v));
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

class VehicleDetailsValues {
  int? ismdiTId;
  int? mIId;
  String? ismdiTDate;
  int? trmVId;
  String? ismdiTBillNo;
  double? ismdiTQty;
  double? ismdiTAmount;
  String? ismdiTRemarks;
  double? ismdiTOpeningKM;
  double? ismdiTClosingKM;
  double? ismdiTBalanceDiesel;
  double? ismdiTPreviousReading;
  double? ismdiTCurrentReading;
  String? createdDate;
  String? updatedDate;

  VehicleDetailsValues(
      {this.ismdiTId,
      this.mIId,
      this.ismdiTDate,
      this.trmVId,
      this.ismdiTBillNo,
      this.ismdiTQty,
      this.ismdiTAmount,
      this.ismdiTRemarks,
      this.ismdiTOpeningKM,
      this.ismdiTClosingKM,
      this.ismdiTBalanceDiesel,
      this.ismdiTPreviousReading,
      this.ismdiTCurrentReading,
      this.createdDate,
      this.updatedDate});

  VehicleDetailsValues.fromJson(Map<String, dynamic> json) {
    ismdiTId = json['ismdiT_Id'];
    mIId = json['mI_Id'];
    ismdiTDate = json['ismdiT_Date'];
    trmVId = json['trmV_Id'];
    ismdiTBillNo = json['ismdiT_BillNo'];
    ismdiTQty = json['ismdiT_Qty'];
    ismdiTAmount = json['ismdiT_Amount'];
    ismdiTRemarks = json['ismdiT_Remarks'];
    ismdiTOpeningKM = json['ismdiT_OpeningKM'];
    ismdiTClosingKM = json['ismdiT_ClosingKM'];
    ismdiTBalanceDiesel = json['ismdiT_BalanceDiesel'];
    ismdiTPreviousReading = json['ismdiT_PreviousReading'];
    ismdiTCurrentReading = json['ismdiT_CurrentReading'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ismdiT_Id'] = ismdiTId;
    data['mI_Id'] = mIId;
    data['ismdiT_Date'] = ismdiTDate;
    data['trmV_Id'] = trmVId;
    data['ismdiT_BillNo'] = ismdiTBillNo;
    data['ismdiT_Qty'] = ismdiTQty;
    data['ismdiT_Amount'] = ismdiTAmount;
    data['ismdiT_Remarks'] = ismdiTRemarks;
    data['ismdiT_OpeningKM'] = ismdiTOpeningKM;
    data['ismdiT_ClosingKM'] = ismdiTClosingKM;
    data['ismdiT_BalanceDiesel'] = ismdiTBalanceDiesel;
    data['ismdiT_PreviousReading'] = ismdiTPreviousReading;
    data['ismdiT_CurrentReading'] = ismdiTCurrentReading;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
