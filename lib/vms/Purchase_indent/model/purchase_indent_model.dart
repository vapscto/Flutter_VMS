class PurchaseIndentModel {
  String? type;
  List<PurchaseIndentModelValues>? values;

  PurchaseIndentModel({this.type, this.values});

  PurchaseIndentModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <PurchaseIndentModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(PurchaseIndentModelValues.fromJson(v));
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

class PurchaseIndentModelValues {
  String? type;
  int? mIId;
  String? mIName;
  int? iNVMPIId;
  String? iNVMPIPINo;
  String? iNVMPIPIDate;
  String? iNVMPIRemarks;
  String? iNVMPIReferenceNo;
  double? iNVMPIApproxTotAmount;
  bool? iNVMPIRejectFlg;
  int? userId;
  int? sanctionLevelNo;
  String? indentCreadBy;
  String? createdDeptName;

  PurchaseIndentModelValues(
      {this.type,
      this.mIId,
      this.mIName,
      this.iNVMPIId,
      this.iNVMPIPINo,
      this.iNVMPIPIDate,
      this.iNVMPIRemarks,
      this.iNVMPIReferenceNo,
      this.iNVMPIApproxTotAmount,
      this.iNVMPIRejectFlg,
      this.userId,
      this.sanctionLevelNo,
      this.indentCreadBy,
      this.createdDeptName});

  PurchaseIndentModelValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    mIId = json['MI_Id'];
    mIName = json['MI_Name'];
    iNVMPIId = json['INVMPI_Id'];
    iNVMPIPINo = json['INVMPI_PINo'];
    iNVMPIPIDate = json['INVMPI_PIDate'];
    iNVMPIRemarks = json['INVMPI_Remarks'];
    iNVMPIReferenceNo = json['INVMPI_ReferenceNo'];
    iNVMPIApproxTotAmount = json['INVMPI_ApproxTotAmount'];
    iNVMPIRejectFlg = json['INVMPI_RejectFlg'];
    userId = json['User_Id'];
    sanctionLevelNo = json['SanctionLevelNo'];
    indentCreadBy = json['IndentCreadBy'];
    createdDeptName = json['CreatedDeptName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    data['MI_Id'] = mIId;
    data['MI_Name'] = mIName;
    data['INVMPI_Id'] = iNVMPIId;
    data['INVMPI_PINo'] = iNVMPIPINo;
    data['INVMPI_PIDate'] = iNVMPIPIDate;
    data['INVMPI_Remarks'] = iNVMPIRemarks;
    data['INVMPI_ReferenceNo'] = iNVMPIReferenceNo;
    data['INVMPI_ApproxTotAmount'] = iNVMPIApproxTotAmount;
    data['INVMPIAPP_RejectFlg'] = iNVMPIRejectFlg;
    //INVMPI_RejectFlg
    data['User_Id'] = userId;
    data['SanctionLevelNo'] = sanctionLevelNo;
    data['IndentCreadBy'] = indentCreadBy;
    data['CreatedDeptName'] = createdDeptName;
    return data;
  }
}
