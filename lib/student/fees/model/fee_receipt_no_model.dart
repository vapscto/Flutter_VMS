class FeeReceiptNoModel {
  int? amsTId;
  int? mIId;
  int? asmaYId;
  bool? status;
  Recnolist? recnolist;
  int? fyPId;

  FeeReceiptNoModel(
      {this.amsTId,
      this.mIId,
      this.asmaYId,
      this.status,
      this.recnolist,
      this.fyPId});

  FeeReceiptNoModel.fromJson(Map<String, dynamic> json) {
    amsTId = json['amsT_Id'];
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    status = json['status'];
    recnolist = json['recnolist'] != null
        ? Recnolist.fromJson(json['recnolist'])
        : null;
    fyPId = json['fyP_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amsT_Id'] = amsTId;
    data['mI_Id'] = mIId;
    data['asmaY_Id'] = asmaYId;
    data['status'] = status;
    if (recnolist != null) {
      data['recnolist'] = recnolist!.toJson();
    }
    data['fyP_Id'] = fyPId;
    return data;
  }
}

class Recnolist {
  String? type;
  List<ReceiptNoList>? values;

  Recnolist({this.type, this.values});

  Recnolist.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ReceiptNoList>[];
      json['\$values'].forEach((v) {
        values!.add(ReceiptNoList.fromJson(v));
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

class ReceiptNoList {
  int? amsTId;
  int? mIId;
  int? asmaYId;
  bool? status;
  int? fyPId;
  String? fyPReceiptNo;

  ReceiptNoList(
      {this.amsTId,
      this.mIId,
      this.asmaYId,
      this.status,
      this.fyPId,
      this.fyPReceiptNo});

  ReceiptNoList.fromJson(Map<String, dynamic> json) {
    amsTId = json['amsT_Id'];
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    status = json['status'];
    fyPId = json['fyP_Id'];
    fyPReceiptNo = json['fyP_Receipt_No'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amsT_Id'] = amsTId;
    data['mI_Id'] = mIId;
    data['asmaY_Id'] = asmaYId;
    data['status'] = status;
    data['fyP_Id'] = fyPId;
    data['fyP_Receipt_No'] = fyPReceiptNo;
    return data;
  }
}
