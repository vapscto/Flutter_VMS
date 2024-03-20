class IndentDetailsModel {
  String? type;
  List<IndentDetailsModelValues>? values;

  IndentDetailsModel({this.type, this.values});

  IndentDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <IndentDetailsModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(IndentDetailsModelValues.fromJson(v));
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

class IndentDetailsModelValues {
  String? type;
  String? iNVMPIPINo;
  String? iNVMPIPIDate;
  dynamic iNVMPIApproxTotAmount;
  dynamic iNVMIId;
  String? iNVMIItemName;
  dynamic iNVTPIApproveQty;
  dynamic iNVTPIPIQty;
  dynamic iNVTPIApproxAmount;
  dynamic iNVTPIRemarks;
  bool? iNVTPIRejectFlg;

  IndentDetailsModelValues(
      {this.type,
      this.iNVMPIPINo,
      this.iNVMPIPIDate,
      this.iNVMPIApproxTotAmount,
      this.iNVMIId,
      this.iNVMIItemName,
      this.iNVTPIApproveQty,
      this.iNVTPIPIQty,
      this.iNVTPIApproxAmount,
      this.iNVTPIRemarks,
      this.iNVTPIRejectFlg});

  IndentDetailsModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iNVMPIPINo = json['INVMPI_PINo'];
    iNVMPIPIDate = json['INVMPI_PIDate'];
    iNVMPIApproxTotAmount = json['INVMPI_ApproxTotAmount'];
    iNVMIId = json['INVMI_Id'];
    iNVMIItemName = json['INVMI_ItemName'];
    iNVTPIApproveQty = json['INVTPI_ApproveQty'];
    iNVTPIPIQty = json['INVTPI_PIQty'];
    iNVTPIApproxAmount = json['INVTPI_ApproxAmount'];
    iNVTPIRemarks = json['INVTPI_Remarks'];
    iNVTPIRejectFlg = json['INVTPI_RejectFlg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['INVMPI_PINo'] = iNVMPIPINo;
    data['INVMPI_PIDate'] = iNVMPIPIDate;
    data['INVMPI_ApproxTotAmount'] = iNVMPIApproxTotAmount;
    data['INVMI_Id'] = iNVMIId;
    data['INVMI_ItemName'] = iNVMIItemName;
    data['INVTPI_ApproveQty'] = iNVTPIApproveQty;
    data['INVTPI_PIQty'] = iNVTPIPIQty;
    data['INVTPI_ApproxAmount'] = iNVTPIApproxAmount;
    data['INVTPI_Remarks'] = iNVTPIRemarks;
    data['INVTPI_RejectFlg'] = iNVTPIRejectFlg;
    return data;
  }
}
