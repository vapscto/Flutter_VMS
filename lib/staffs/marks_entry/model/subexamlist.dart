class SubExamList {
  String? type;
  List<SubExamListValues>? values;

  SubExamList({this.type, this.values});

  SubExamList.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <SubExamListValues>[];
      json['\$values'].forEach((v) {
        values!.add(SubExamListValues.fromJson(v));
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

class SubExamListValues {
  int? emsEId;
  int? mIId;
  String? emsESubExamName;
  String? emsESubExamCode;
  int? emsESubExamOrder;
  bool? emsEActiveFlag;
  String? createdDate;
  String? updatedDate;

  SubExamListValues(
      {this.emsEId,
      this.mIId,
      this.emsESubExamName,
      this.emsESubExamCode,
      this.emsESubExamOrder,
      this.emsEActiveFlag,
      this.createdDate,
      this.updatedDate});

  SubExamListValues.fromJson(Map<String, dynamic> json) {
    emsEId = json['emsE_Id'];
    mIId = json['mI_Id'];
    emsESubExamName = json['emsE_SubExamName'];
    emsESubExamCode = json['emsE_SubExamCode'];
    emsESubExamOrder = json['emsE_SubExamOrder'];
    emsEActiveFlag = json['emsE_ActiveFlag'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emsE_Id'] = emsEId;
    data['mI_Id'] = mIId;
    data['emsE_SubExamName'] = emsESubExamName;
    data['emsE_SubExamCode'] = emsESubExamCode;
    data['emsE_SubExamOrder'] = emsESubExamOrder;
    data['emsE_ActiveFlag'] = emsEActiveFlag;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
