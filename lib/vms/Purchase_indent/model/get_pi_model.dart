class GetPiModel {
  String? type;
  List<GetPiModelValues>? values;

  GetPiModel({this.type, this.values});

  GetPiModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetPiModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(GetPiModelValues.fromJson(v));
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

class GetPiModelValues {
  String? type;
  int? iNVMPIId;
  int? iNVMIId;
  String? iNVMIItemName;
  String? mIName;
  int? iNVMUOMId;
  String? iNVMUOMUOMName;
  double? iNVTPIPRQty;
  double? iNVTPIApproxAmount;
  double? iNVTPIPIQty;
  double? iNVTPIAPPApprovedQty;
  String? iNVTPIRemarks;
  double? iNVTPIPIUnitRate;
  int? iNVTPIId;
  int? iNVMPRId;

  GetPiModelValues(
      {this.type,
      this.iNVMPIId,
      this.iNVMIId,
      this.iNVMIItemName,
      this.mIName,
      this.iNVMUOMId,
      this.iNVMUOMUOMName,
      this.iNVTPIPRQty,
      this.iNVTPIApproxAmount,
      this.iNVTPIPIQty,
      this.iNVTPIAPPApprovedQty,
      this.iNVTPIRemarks,
      this.iNVTPIPIUnitRate,
      this.iNVTPIId,
      this.iNVMPRId});

  GetPiModelValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    iNVMPIId = json['INVMPI_Id'];
    iNVMIId = json['INVMI_Id'];
    iNVMIItemName = json['INVMI_ItemName'];
     mIName = json['MI_Name'];
    iNVMUOMId = json['INVMUOM_Id'];
    iNVMUOMUOMName = json['INVMUOM_UOMName'];
    iNVTPIPRQty = json['INVTPI_PRQty'];
    iNVTPIApproxAmount = json['INVTPI_ApproxAmount'];
    iNVTPIPIQty = json['INVTPI_PIQty'];
    iNVTPIAPPApprovedQty = json['INVTPIAPP_ApprovedQty'];
    iNVTPIRemarks = json['INVTPI_Remarks'];
    iNVTPIPIUnitRate = json['INVTPI_PIUnitRate'];
    iNVTPIId = json['INVTPI_Id'];
    iNVMPRId = json['INVMPR_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    data['INVMPI_Id'] = this.iNVMPIId;
    data['INVMI_Id'] = this.iNVMIId;
    data['INVMI_ItemName'] = this.iNVMIItemName;
    data['MI_Name'] = this.mIName;
    data['INVMUOM_Id'] = this.iNVMUOMId;
    data['INVMUOM_UOMName'] = this.iNVMUOMUOMName;
    data['INVTPI_PRQty'] = this.iNVTPIPRQty;
    data['INVTPI_ApproxAmount'] = this.iNVTPIApproxAmount;
    data['INVTPI_PIQty'] = this.iNVTPIPIQty;
    data['INVTPIAPP_ApprovedQty'] = this.iNVTPIAPPApprovedQty;
    data['INVTPI_Remarks'] = this.iNVTPIRemarks;
    data['INVTPI_PIUnitRate'] = this.iNVTPIPIUnitRate;
    data['INVTPI_Id'] = this.iNVTPIId;
    data['INVMPR_Id'] = this.iNVMPRId;
    return data;
  }
}
