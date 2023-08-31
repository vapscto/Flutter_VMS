class ManagerSectionModel {
  String? type;
  List<ManagerSectionModelValues>? values;

  ManagerSectionModel({this.type, this.values});

  ManagerSectionModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ManagerSectionModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ManagerSectionModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    if (values != null) {
      data['$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ManagerSectionModelValues {
  int? asmSId;
  int? mIId;
  String? asmCSectionName;
  String? asmCSectionCode;
  int? asmCOrder;
  int? asmCMaxCapacity;
  bool? status;
  int? asmaYId;
  int? asmcLId;

  ManagerSectionModelValues(
      {this.asmSId,
      this.mIId,
      this.asmCSectionName,
      this.asmCSectionCode,
      this.asmCOrder,
      this.asmCMaxCapacity,
      this.status,
      this.asmaYId,
      this.asmcLId});

  ManagerSectionModelValues.fromJson(Map<String, dynamic> json) {
    asmSId = json['asmS_Id'];
    mIId = json['mI_Id'];
    asmCSectionName = json['asmC_SectionName'];
    asmCSectionCode = json['asmC_SectionCode'];
    asmCOrder = json['asmC_Order'];
    asmCMaxCapacity = json['asmC_MaxCapacity'];
    status = json['status'];
    asmaYId = json['asmaY_Id'];
    asmcLId = json['asmcL_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['asmS_Id'] = asmSId;
    data['mI_Id'] = mIId;
    data['asmC_SectionName'] = asmCSectionName;
    data['asmC_SectionCode'] = asmCSectionCode;
    data['asmC_Order'] = asmCOrder;
    data['asmC_MaxCapacity'] = asmCMaxCapacity;
    data['status'] = status;
    data['asmaY_Id'] = asmaYId;
    data['asmcL_Id'] = asmcLId;
    return data;
  }
}
