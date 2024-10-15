class RtoVehicleModel {
  String? type;
  List<RtoVehicleModelValues>? values;

  RtoVehicleModel({this.type, this.values});

  RtoVehicleModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <RtoVehicleModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(RtoVehicleModelValues.fromJson(v));
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

class RtoVehicleModelValues {
  int? trmVId;
  int? mIId;
  int? trmvTId;
  int? trmfTId;
  String? trmVVehicleName;
  String? trmVVehicleNo;
  String? trmVPurchaseDate;
  String? trmVChassisNo;
  String? trmVEngineNo;
  String? trmVPurchasedFrom;
  double? trmVCost;
  int? trmVCapacity;
  String? trmVVehicleImage;
  bool? trmVActiveFlag;
  String? trmVCompanyName;
  String? trmVAddress;
  String? trmVModel;
  String? trmVOwnersName;
  String? createdDate;
  String? updatedDate;
  String? trmVFuel;
  String? trmVClass;
  String? trmVColor;
  String? trmVBody;
  String? trmVWheelBase;
  String? trmVCC;
  String? trmVRegFCUpToDate;
  String? trmVTaxUpTo;
  String? trmVRegistrationDate;
  String? trmVManufacturer;
  String? trmVManufacturedDate;
  int? trmVNoOfCylinder;
  double? trmVUnladenWeight;
  String? trmVSWDOff;
  String? trmVDesc;

  RtoVehicleModelValues(
      {this.trmVId,
      this.mIId,
      this.trmvTId,
      this.trmfTId,
      this.trmVVehicleName,
      this.trmVVehicleNo,
      this.trmVPurchaseDate,
      this.trmVChassisNo,
      this.trmVEngineNo,
      this.trmVPurchasedFrom,
      this.trmVCost,
      this.trmVCapacity,
      this.trmVVehicleImage,
      this.trmVActiveFlag,
      this.trmVCompanyName,
      this.trmVAddress,
      this.trmVModel,
      this.trmVOwnersName,
      this.createdDate,
      this.updatedDate,
      this.trmVFuel,
      this.trmVClass,
      this.trmVColor,
      this.trmVBody,
      this.trmVWheelBase,
      this.trmVCC,
      this.trmVRegFCUpToDate,
      this.trmVTaxUpTo,
      this.trmVRegistrationDate,
      this.trmVManufacturer,
      this.trmVManufacturedDate,
      this.trmVNoOfCylinder,
      this.trmVUnladenWeight,
      this.trmVSWDOff,
      this.trmVDesc});

  RtoVehicleModelValues.fromJson(Map<String, dynamic> json) {
    trmVId = json['trmV_Id'];
    mIId = json['mI_Id'];
    trmvTId = json['trmvT_Id'];
    trmfTId = json['trmfT_Id'];
    trmVVehicleName = json['trmV_VehicleName'];
    trmVVehicleNo = json['trmV_VehicleNo'];
    trmVPurchaseDate = json['trmV_PurchaseDate'];
    trmVChassisNo = json['trmV_ChassisNo'];
    trmVEngineNo = json['trmV_EngineNo'];
    trmVPurchasedFrom = json['trmV_PurchasedFrom'];
    trmVCost = json['trmV_Cost'];
    trmVCapacity = json['trmV_Capacity'];
    trmVVehicleImage = json['trmV_VehicleImage'];
    trmVActiveFlag = json['trmV_ActiveFlag'];
    trmVCompanyName = json['trmV_CompanyName'];
    trmVAddress = json['trmV_Address'];
    trmVModel = json['trmV_Model'];
    trmVOwnersName = json['trmV_OwnersName'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    trmVFuel = json['trmV_Fuel'];
    trmVClass = json['trmV_Class'];
    trmVColor = json['trmV_Color'];
    trmVBody = json['trmV_Body'];
    trmVWheelBase = json['trmV_WheelBase'];
    trmVCC = json['trmV_CC'];
    trmVRegFCUpToDate = json['trmV_RegFCUpToDate'];
    trmVTaxUpTo = json['trmV_TaxUpTo'];
    trmVRegistrationDate = json['trmV_RegistrationDate'];
    trmVManufacturer = json['trmV_Manufacturer'];
    trmVManufacturedDate = json['trmV_ManufacturedDate'];
    trmVNoOfCylinder = json['trmV_NoOfCylinder'];
    trmVUnladenWeight = json['trmV_UnladenWeight'];
    trmVSWDOff = json['trmV_SWDOff'];
    trmVDesc = json['trmV_Desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trmV_Id'] = trmVId;
    data['mI_Id'] = mIId;
    data['trmvT_Id'] = trmvTId;
    data['trmfT_Id'] = trmfTId;
    data['trmV_VehicleName'] = trmVVehicleName;
    data['trmV_VehicleNo'] = trmVVehicleNo;
    data['trmV_PurchaseDate'] = trmVPurchaseDate;
    data['trmV_ChassisNo'] = trmVChassisNo;
    data['trmV_EngineNo'] = trmVEngineNo;
    data['trmV_PurchasedFrom'] = trmVPurchasedFrom;
    data['trmV_Cost'] = trmVCost;
    data['trmV_Capacity'] = trmVCapacity;
    data['trmV_VehicleImage'] = trmVVehicleImage;
    data['trmV_ActiveFlag'] = trmVActiveFlag;
    data['trmV_CompanyName'] = trmVCompanyName;
    data['trmV_Address'] = trmVAddress;
    data['trmV_Model'] = trmVModel;
    data['trmV_OwnersName'] = trmVOwnersName;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['trmV_Fuel'] = trmVFuel;
    data['trmV_Class'] = trmVClass;
    data['trmV_Color'] = trmVColor;
    data['trmV_Body'] = trmVBody;
    data['trmV_WheelBase'] = trmVWheelBase;
    data['trmV_CC'] = trmVCC;
    data['trmV_RegFCUpToDate'] = trmVRegFCUpToDate;
    data['trmV_TaxUpTo'] = trmVTaxUpTo;
    data['trmV_RegistrationDate'] = trmVRegistrationDate;
    data['trmV_Manufacturer'] = trmVManufacturer;
    data['trmV_ManufacturedDate'] = trmVManufacturedDate;
    data['trmV_NoOfCylinder'] = trmVNoOfCylinder;
    data['trmV_UnladenWeight'] = trmVUnladenWeight;
    data['trmV_SWDOff'] = trmVSWDOff;
    data['trmV_Desc'] = trmVDesc;
    return data;
  }
}
