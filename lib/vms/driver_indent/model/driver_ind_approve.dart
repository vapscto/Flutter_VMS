class DriverloadModel {
  String? type;
  List<DriverloadModelValues>? values;

  DriverloadModel({this.type, this.values});

  DriverloadModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DriverloadModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DriverloadModelValues.fromJson(v));
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

class DriverloadModelValues {
  String? type;
  int? iSMDITId;
  String? iSMDITDate;
  int? tRMVId;
  String? tRMVVehicleName;
  String? tRMVVehicleNo;
  dynamic iSMDITBillNo;
  double? iSMDITQty;
  double? iSMDITAmount;
  dynamic iSMDITRemark;
  int? iSMDITPreparedByUserId;
  double? iSMDITOpeningKM;
  double? iSMDITClosingKM;
  double? totalKM;
  String? hRMEEmployeeFirstName;

  DriverloadModelValues(
      {this.type,
      this.iSMDITId,
      this.iSMDITDate,
      this.tRMVId,
      this.tRMVVehicleName,
      this.tRMVVehicleNo,
      this.iSMDITBillNo,
      this.iSMDITQty,
      this.iSMDITAmount,
      this.iSMDITRemark,
      this.iSMDITPreparedByUserId,
      this.iSMDITOpeningKM,
      this.iSMDITClosingKM,
      this.totalKM,
      this.hRMEEmployeeFirstName});

  DriverloadModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMDITId = json['ISMDIT_Id'];
    iSMDITDate = json['ISMDIT_Date'];
    tRMVId = json['TRMV_Id'];
    tRMVVehicleName = json['TRMV_VehicleName'];
    tRMVVehicleNo = json['TRMV_VehicleNo'];
    iSMDITBillNo = json['ISMDIT_BillNo'];
    iSMDITQty = json['ISMDIT_Qty'];
    iSMDITAmount = json['ISMDIT_Amount'];
    iSMDITRemark = json['ISMDIT_Remark'];
    iSMDITPreparedByUserId = json['ISMDIT_PreparedByUserId'];
    iSMDITOpeningKM = json['ISMDIT_OpeningKM'];
    iSMDITClosingKM = json['ISMDIT_ClosingKM'];
    totalKM = json['TotalKM'];
    hRMEEmployeeFirstName = json['HRME_EmployeeFirstName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMDIT_Id'] = iSMDITId;
    data['ISMDIT_Date'] = iSMDITDate;
    data['TRMV_Id'] = tRMVId;
    data['TRMV_VehicleName'] = tRMVVehicleName;
    data['TRMV_VehicleNo'] = tRMVVehicleNo;
    data['ISMDIT_BillNo'] = iSMDITBillNo;
    data['ISMDIT_Qty'] = iSMDITQty;
    data['ISMDIT_Amount'] = iSMDITAmount;
    data['ISMDIT_Remark'] = iSMDITRemark;
    data['ISMDIT_PreparedByUserId'] = iSMDITPreparedByUserId;
    data['ISMDIT_OpeningKM'] = iSMDITOpeningKM;
    data['ISMDIT_ClosingKM'] = iSMDITClosingKM;
    data['TotalKM'] = totalKM;
    data['HRME_EmployeeFirstName'] = hRMEEmployeeFirstName;
    return data;
  }
}
