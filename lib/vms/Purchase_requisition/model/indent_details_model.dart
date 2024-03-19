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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
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
  Null? iNVTPIRemarks;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['INVMPI_PINo'] = this.iNVMPIPINo;
    data['INVMPI_PIDate'] = this.iNVMPIPIDate;
    data['INVMPI_ApproxTotAmount'] = this.iNVMPIApproxTotAmount;
    data['INVMI_Id'] = this.iNVMIId;
    data['INVMI_ItemName'] = this.iNVMIItemName;
    data['INVTPI_ApproveQty'] = this.iNVTPIApproveQty;
    data['INVTPI_PIQty'] = this.iNVTPIPIQty;
    data['INVTPI_ApproxAmount'] = this.iNVTPIApproxAmount;
    data['INVTPI_Remarks'] = this.iNVTPIRemarks;
    data['INVTPI_RejectFlg'] = this.iNVTPIRejectFlg;
    return data;
  }
}
