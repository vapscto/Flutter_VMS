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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['INVMPIAPP_Id'] = iNVMPIAPPId;
    data['INVMPIAPP_PINo'] = iNVMPIAPPPINo;
    data['INVMPIAPP_PIDate'] = iNVMPIAPPPIDate;
    data['INVMPIAPP_ApproxTotAmount'] = iNVMPIAPPApproxTotAmount;
    data['ApprovedBy'] = approvedBy;
    data['INVMPIAPP_Remarks'] = iNVMPIAPPRemarks;
    data['INVMPIAPP_RejectFlg'] = iNVMPIAPPRejectFlg;
    return data;
  }
}
