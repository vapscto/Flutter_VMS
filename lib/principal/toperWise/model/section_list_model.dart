class TopSectonListModel {
  String? type;
  List<TopSectonListModelValues>? values;

  TopSectonListModel({this.type, this.values});

  TopSectonListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TopSectonListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TopSectonListModelValues.fromJson(v));
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

class TopSectonListModelValues {
  int? asmSId;
  int? mIId;
  String? asmCSectionName;
  String? asmCSectionCode;
  int? asmCOrder;
  int? asmCActiveFlag;
  int? asmCMaxCapacity;
  String? createdDate;
  String? updatedDate;

  TopSectonListModelValues(
      {this.asmSId,
      this.mIId,
      this.asmCSectionName,
      this.asmCSectionCode,
      this.asmCOrder,
      this.asmCActiveFlag,
      this.asmCMaxCapacity,
      this.createdDate,
      this.updatedDate});

  TopSectonListModelValues.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asmS_Id'] = this.asmSId;
    data['mI_Id'] = this.mIId;
    data['asmC_SectionName'] = this.asmCSectionName;
    data['asmC_SectionCode'] = this.asmCSectionCode;
    data['asmC_Order'] = this.asmCOrder;
    data['asmC_ActiveFlag'] = this.asmCActiveFlag;
    data['asmC_MaxCapacity'] = this.asmCMaxCapacity;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}
