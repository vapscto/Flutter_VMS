class AssetsListModel {
  int? mIID;
  Employeedetails? employeedetails;
  String? flag;
  int? hrmEId;
  int? userId;

  AssetsListModel(
      {this.mIID, this.employeedetails, this.flag, this.hrmEId, this.userId});

  AssetsListModel.fromJson(Map<String, dynamic> json) {
    mIID = json['mI_ID'];
    employeedetails = json['employeedetails'] != null
        ? Employeedetails.fromJson(json['employeedetails'])
        : null;
    flag = json['flag'];
    hrmEId = json['hrmE_Id'];
    userId = json['user_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mI_ID'] = mIID;
    if (employeedetails != null) {
      data['employeedetails'] = employeedetails!.toJson();
    }
    data['flag'] = flag;
    data['hrmE_Id'] = hrmEId;
    data['user_Id'] = userId;
    return data;
  }
}

class Employeedetails {
  String? type;
  List<Values>? values;

  Employeedetails({this.type, this.values});

  Employeedetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <Values>[];
      json['\$values'].forEach((v) {
        values!.add(Values.fromJson(v));
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

class Values {
  String? type;
  int? hRMEId;
  String? employeeName;
  String? hRMEPhoto;
  String? hRMDDepartmentName;
  String? hRMDESDesignationName;
  int? iNVMIId;
  String? iNVMIItemName;
  String? iNVAATAssetId;
  String? iNVAATModelNo;
  double? iNVATCOCheckOutQty;
  String? iNVMSStoreName;
  String? iNVMSStoreLocation;
  String? iNVMLOLocationRoomName;
  int? iNVMLOId;
  int? mIId;
  String? mIName;
  int? iNVATCOId;
  String? hRMEEmployeeCode;
  String? iNVMLOLocationRemarks;
  double? iNVTGRNPurchaseRate;

  Values(
      {this.type,
      this.hRMEId,
      this.employeeName,
      this.hRMEPhoto,
      this.hRMDDepartmentName,
      this.hRMDESDesignationName,
      this.iNVMIId,
      this.iNVMIItemName,
      this.iNVAATAssetId,
      this.iNVAATModelNo,
      this.iNVATCOCheckOutQty,
      this.iNVMSStoreName,
      this.iNVMSStoreLocation,
      this.iNVMLOLocationRoomName,
      this.iNVMLOId,
      this.mIId,
      this.mIName,
      this.iNVATCOId,
      this.hRMEEmployeeCode,
      this.iNVMLOLocationRemarks,
      this.iNVTGRNPurchaseRate});

  Values.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    hRMEId = json['HRME_Id'];
    employeeName = json['EmployeeName'];
    hRMEPhoto = json['HRME_Photo'];
    hRMDDepartmentName = json['HRMD_DepartmentName'];
    hRMDESDesignationName = json['HRMDES_DesignationName'];
    iNVMIId = json['INVMI_Id'];
    iNVMIItemName = json['INVMI_ItemName'];
    iNVAATAssetId = json['INVAAT_AssetId'];
    iNVAATModelNo = json['INVAAT_ModelNo'] ?? "";
    iNVATCOCheckOutQty = json['INVATCO_CheckOutQty'] ?? 0;
    iNVMSStoreName = json['INVMS_StoreName'];
    iNVMSStoreLocation = json['INVMS_StoreLocation'];
    iNVMLOLocationRoomName = json['INVMLO_LocationRoomName'];
    iNVMLOId = json['INVMLO_Id'];
    mIId = json['MI_Id'];
    mIName = json['MI_Name'];
    iNVATCOId = json['INVATCO_Id'];
    hRMEEmployeeCode = json['HRME_EmployeeCode'];
    iNVMLOLocationRemarks = json['INVMLO_LocationRemarks'];
    iNVTGRNPurchaseRate = json['INVTGRN_PurchaseRate'] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['HRME_Id'] = hRMEId;
    data['EmployeeName'] = employeeName;
    data['HRME_Photo'] = hRMEPhoto;
    data['HRMD_DepartmentName'] = hRMDDepartmentName;
    data['HRMDES_DesignationName'] = hRMDESDesignationName;
    data['INVMI_Id'] = iNVMIId;
    data['INVMI_ItemName'] = iNVMIItemName;
    data['INVAAT_AssetId'] = iNVAATAssetId;
    data['INVAAT_ModelNo'] = iNVAATModelNo;
    data['INVATCO_CheckOutQty'] = iNVATCOCheckOutQty;
    data['INVMS_StoreName'] = iNVMSStoreName;
    data['INVMS_StoreLocation'] = iNVMSStoreLocation;
    data['INVMLO_LocationRoomName'] = iNVMLOLocationRoomName;
    data['INVMLO_Id'] = iNVMLOId;
    data['MI_Id'] = mIId;
    data['MI_Name'] = mIName;
    data['INVATCO_Id'] = iNVATCOId;
    data['HRME_EmployeeCode'] = hRMEEmployeeCode;
    data['INVMLO_LocationRemarks'] = iNVMLOLocationRemarks;
    data['INVTGRN_PurchaseRate'] = iNVTGRNPurchaseRate;
    return data;
  }
}
