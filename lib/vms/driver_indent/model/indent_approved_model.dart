class DriverIndentApprovedModel {
  String? type;
  List<DriverIndentApprovedModelValues>? values;

  DriverIndentApprovedModel({this.type, this.values});

  DriverIndentApprovedModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DriverIndentApprovedModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DriverIndentApprovedModelValues.fromJson(v));
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

class DriverIndentApprovedModelValues {
  String? ismdiTDate;
  int? trmVId;
  double? ismdiTQty;
  double? ismdiTAmount;
  double? ismdiTOpeningKM;
  double? ismdiTClosingKM;
  double? ismdiTBalanceDiesel;
  dynamic ismdiTPreviousReading;
  dynamic ismdiTCurrentReading;
  int? ismdiTPreparedByUserId;
  int? ismdiTApprovalUserId;
  int? ismdiTReceivedByUserId;
  int? mIId;
  int? mIIdNew;
  int? userId;
  bool? duplicate;
  int? ismdiTId;
  int? hrmEId;
  String? trmVVehicleName;
  int? roleId;
  String? ismdiTStatus;
  double? ismdiTDiffrenceKm;
  String? ismdiTBillNo;
  String? ismdiTRemarks;

  DriverIndentApprovedModelValues(
      {this.ismdiTDate,
      this.trmVId,
      this.ismdiTQty,
      this.ismdiTAmount,
      this.ismdiTOpeningKM,
      this.ismdiTClosingKM,
      this.ismdiTBalanceDiesel,
      this.ismdiTPreviousReading,
      this.ismdiTCurrentReading,
      this.ismdiTPreparedByUserId,
      this.ismdiTApprovalUserId,
      this.ismdiTReceivedByUserId,
      this.mIId,
      this.mIIdNew,
      this.userId,
      this.duplicate,
      this.ismdiTId,
      this.hrmEId,
      this.trmVVehicleName,
      this.roleId,
      this.ismdiTStatus,
      this.ismdiTDiffrenceKm,
      this.ismdiTBillNo,
      this.ismdiTRemarks});

  DriverIndentApprovedModelValues.fromJson(Map<String, dynamic> json) {
    ismdiTDate = json['ismdiT_Date'];
    trmVId = json['trmV_Id'];
    ismdiTQty = json['ismdiT_Qty'];
    ismdiTAmount = json['ismdiT_Amount'];
    ismdiTOpeningKM = json['ismdiT_OpeningKM'];
    ismdiTClosingKM = json['ismdiT_ClosingKM'];
    ismdiTBalanceDiesel = json['ismdiT_BalanceDiesel'];
    ismdiTPreviousReading = json['ismdiT_PreviousReading'];
    ismdiTCurrentReading = json['ismdiT_CurrentReading'];
    ismdiTPreparedByUserId = json['ismdiT_PreparedByUserId'];
    ismdiTApprovalUserId = json['ismdiT_ApprovalUserId'];
    ismdiTReceivedByUserId = json['ismdiT_ReceivedByUserId'];
    mIId = json['mI_Id'];
    mIIdNew = json['mI_Id_new'];
    userId = json['user_Id'];
    duplicate = json['duplicate'];
    ismdiTId = json['ismdiT_Id'];
    hrmEId = json['hrmE_Id'];
    trmVVehicleName = json['trmV_VehicleName'];
    roleId = json['roleId'];
    ismdiTStatus = json['ismdiT_Status'];
    ismdiTDiffrenceKm = json['ismdiT_DiffrenceKm'];
    ismdiTBillNo = json['ismdiT_BillNo'];
    ismdiTRemarks = json['ismdiT_Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ismdiT_Date'] = ismdiTDate;
    data['trmV_Id'] = trmVId;
    data['ismdiT_Qty'] = ismdiTQty;
    data['ismdiT_Amount'] = ismdiTAmount;
    data['ismdiT_OpeningKM'] = ismdiTOpeningKM;
    data['ismdiT_ClosingKM'] = ismdiTClosingKM;
    data['ismdiT_BalanceDiesel'] = ismdiTBalanceDiesel;
    data['ismdiT_PreviousReading'] = ismdiTPreviousReading;
    data['ismdiT_CurrentReading'] = ismdiTCurrentReading;
    data['ismdiT_PreparedByUserId'] = ismdiTPreparedByUserId;
    data['ismdiT_ApprovalUserId'] = ismdiTApprovalUserId;
    data['ismdiT_ReceivedByUserId'] = ismdiTReceivedByUserId;
    data['mI_Id'] = mIId;
    data['mI_Id_new'] = mIIdNew;
    data['user_Id'] = userId;
    data['duplicate'] = duplicate;
    data['ismdiT_Id'] = ismdiTId;
    data['hrmE_Id'] = hrmEId;
    data['trmV_VehicleName'] = trmVVehicleName;
    data['roleId'] = roleId;
    data['ismdiT_Status'] = ismdiTStatus;
    data['ismdiT_DiffrenceKm'] = ismdiTDiffrenceKm;
    data['ismdiT_BillNo'] = ismdiTBillNo;
    data['ismdiT_Remarks'] = ismdiTRemarks;
    return data;
  }
}
