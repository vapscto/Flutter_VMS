class HwCwSectionListModel {
  String? type;
  List<HwCwSectionListModelValue>? values;

  HwCwSectionListModel({this.type, this.values});

  HwCwSectionListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <HwCwSectionListModelValue>[];
      json['\$values'].forEach((v) {
        values!.add(HwCwSectionListModelValue.fromJson(v));
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

class HwCwSectionListModelValue {
  int? asmSId;
  int? mIId;
  String? asmCSectionName;
  String? asmCSectionCode;
  int? asmCOrder;
  int? asmCActiveFlag;
  int? asmCMaxCapacity;
  String? createdDate;
  String? updatedDate;

  HwCwSectionListModelValue(
      {this.asmSId,
      this.mIId,
      this.asmCSectionName,
      this.asmCSectionCode,
      this.asmCOrder,
      this.asmCActiveFlag,
      this.asmCMaxCapacity,
      this.createdDate,
      this.updatedDate});

  HwCwSectionListModelValue.fromJson(Map<String, dynamic> json) {
    asmSId = json['asmS_Id'];
    mIId = json['mI_Id'];
    asmCSectionName = json['asmC_SectionName'];
    asmCSectionCode = json['asmC_SectionCode'];
    asmCOrder = json['asmC_Order'];
    asmCActiveFlag = json['asmC_ActiveFlag'];
    asmCMaxCapacity = json['asmC_MaxCapacity'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['asmS_Id'] = asmSId;
    data['mI_Id'] = mIId;
    data['asmC_SectionName'] = asmCSectionName;
    data['asmC_SectionCode'] = asmCSectionCode;
    data['asmC_Order'] = asmCOrder;
    data['asmC_ActiveFlag'] = asmCActiveFlag;
    data['asmC_MaxCapacity'] = asmCMaxCapacity;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
