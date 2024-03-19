class PurchaseApprovalModel {
  String? type;
  List<PurchaseApprovalModelValues>? values;

  PurchaseApprovalModel({this.type, this.values});

  PurchaseApprovalModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PurchaseApprovalModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(PurchaseApprovalModelValues.fromJson(v));
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

class PurchaseApprovalModelValues {
  String? type;
dynamic iNVMPIAPPId;
  String? iNVMPIAPPPINo;
  String? iNVMPIAPPPIDate;
dynamic iNVMPIAPPApproxTotAmount;
  String? approvedBy;
  String? iNVMPIAPPRemarks;
  bool? iNVMPIAPPRejectFlg;

  PurchaseApprovalModelValues(
      {this.type,
      this.iNVMPIAPPId,
      this.iNVMPIAPPPINo,
      this.iNVMPIAPPPIDate,
      this.iNVMPIAPPApproxTotAmount,
      this.approvedBy,
      this.iNVMPIAPPRemarks,
      this.iNVMPIAPPRejectFlg});

  PurchaseApprovalModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iNVMPIAPPId = json['INVMPIAPP_Id'];
    iNVMPIAPPPINo = json['INVMPIAPP_PINo'];
    iNVMPIAPPPIDate = json['INVMPIAPP_PIDate'];
    iNVMPIAPPApproxTotAmount = json['INVMPIAPP_ApproxTotAmount'];
    approvedBy = json['ApprovedBy'];
    iNVMPIAPPRemarks = json['INVMPIAPP_Remarks'];
    iNVMPIAPPRejectFlg = json['INVMPIAPP_RejectFlg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['INVMPIAPP_Id'] = this.iNVMPIAPPId;
    data['INVMPIAPP_PINo'] = this.iNVMPIAPPPINo;
    data['INVMPIAPP_PIDate'] = this.iNVMPIAPPPIDate;
    data['INVMPIAPP_ApproxTotAmount'] = this.iNVMPIAPPApproxTotAmount;
    data['ApprovedBy'] = this.approvedBy;
    data['INVMPIAPP_Remarks'] = this.iNVMPIAPPRemarks;
    data['INVMPIAPP_RejectFlg'] = this.iNVMPIAPPRejectFlg;
    return data;
  }
}
