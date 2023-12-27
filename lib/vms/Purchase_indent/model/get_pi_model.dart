class GetPiModel {
  String? type;
  List<GetPiModelValues>? values;

  GetPiModel({this.type, this.values});

  GetPiModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetPiModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new GetPiModelValues.fromJson(v));
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
  int? iNVMUOMId;
  String? iNVMUOMUOMName;
  double? iNVTPIPRQty;
  double? iNVTPIApproxAmount;
  double? iNVTPIPIQty;
  String? iNVTPIRemarks;
  double? iNVTPIPIUnitRate;
  bool? iNVMPIAPPRejectFlg;
  double? iNVTPIAPPApprovedQty;
  int? iNVTPIId;
  int? iNVMPRId;

  GetPiModelValues(
      {this.type,
      this.iNVMPIId,
      this.iNVMIId,
      this.iNVMIItemName,
      this.iNVMUOMId,
      this.iNVMUOMUOMName,
      this.iNVTPIPRQty,
      this.iNVTPIApproxAmount,
      this.iNVTPIPIQty,
      this.iNVTPIRemarks,
      this.iNVTPIPIUnitRate,
      this.iNVMPIAPPRejectFlg,
      this.iNVTPIAPPApprovedQty,
      this.iNVTPIId,
      this.iNVMPRId});

 GetPiModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iNVMPIId = json['INVMPI_Id'];
    iNVMIId = json['INVMI_Id'];
    iNVMIItemName = json['INVMI_ItemName'];
    iNVMUOMId = json['INVMUOM_Id'];
    iNVMUOMUOMName = json['INVMUOM_UOMName'];
    iNVTPIPRQty = json['INVTPI_PRQty'];
    iNVTPIApproxAmount = json['INVTPI_ApproxAmount'];
    iNVTPIPIQty = json['INVTPI_PIQty'];
    iNVTPIRemarks = json['INVTPI_Remarks'];
    iNVTPIPIUnitRate = json['INVTPI_PIUnitRate'];
    iNVMPIAPPRejectFlg = json['INVMPIAPP_RejectFlg'];
    iNVTPIAPPApprovedQty = json['INVTPIAPP_ApprovedQty'];
    iNVTPIId = json['INVTPI_Id'];
    iNVMPRId = json['INVMPR_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['INVMPI_Id'] = this.iNVMPIId;
    data['INVMI_Id'] = this.iNVMIId;
    data['INVMI_ItemName'] = this.iNVMIItemName;
    data['INVMUOM_Id'] = this.iNVMUOMId;
    data['INVMUOM_UOMName'] = this.iNVMUOMUOMName;
    data['INVTPI_PRQty'] = this.iNVTPIPRQty;
    data['INVTPI_ApproxAmount'] = this.iNVTPIApproxAmount;
    data['INVTPI_PIQty'] = this.iNVTPIPIQty;
    data['INVTPI_Remarks'] = this.iNVTPIRemarks;
    data['INVTPI_PIUnitRate'] = this.iNVTPIPIUnitRate;
    data['INVMPIAPP_RejectFlg'] = this.iNVMPIAPPRejectFlg;
    data['INVTPIAPP_ApprovedQty'] = this.iNVTPIAPPApprovedQty;
    data['INVTPI_Id'] = this.iNVTPIId;
    data['INVMPR_Id'] = this.iNVMPRId;
    return data;
  }
}
