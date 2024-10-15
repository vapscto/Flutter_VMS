class VehicleListModel {
  String? type;
  List<VehicleListModelValues>? values;

  VehicleListModel({this.type, this.values});

  VehicleListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <VehicleListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(VehicleListModelValues.fromJson(v));
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

class VehicleListModelValues {
  int? trmVId;
  double? ismdiTQty;
  double? ismdiTAmount;
  double? ismdiTOpeningKM;
  double? ismdiTClosingKM;
  double? ismdiTBalanceDiesel;
  double? ismdiTPreviousReading;
  double? ismdiTCurrentReading;
  int? ismdiTPreparedByUserId;
  int? ismdiTApprovalUserId;
  int? ismdiTReceivedByUserId;
  int? mIId;
  int? mIIdNew;
  int? userId;
  String? trmVVehicleNo;
  bool? duplicate;
  int? ismdiTId;
  int? hrmEId;
  int? roleId;
  double? ismdiTDiffrenceKm;

  VehicleListModelValues(
      {this.trmVId,
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
      this.trmVVehicleNo,
      this.duplicate,
      this.ismdiTId,
      this.hrmEId,
      this.roleId,
      this.ismdiTDiffrenceKm});

  VehicleListModelValues.fromJson(Map<String, dynamic> json) {
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
    trmVVehicleNo = json['trmV_VehicleNo'];
    duplicate = json['duplicate'];
    ismdiTId = json['ismdiT_Id'];
    hrmEId = json['hrmE_Id'];
    roleId = json['roleId'];
    ismdiTDiffrenceKm = json['ismdiT_DiffrenceKm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['trmV_VehicleNo'] = trmVVehicleNo;
    data['duplicate'] = duplicate;
    data['ismdiT_Id'] = ismdiTId;
    data['hrmE_Id'] = hrmEId;
    data['roleId'] = roleId;
    data['ismdiT_DiffrenceKm'] = ismdiTDiffrenceKm;
    return data;
  }
}
