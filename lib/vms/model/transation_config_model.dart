class TransationConfigModel {
  String? type;
  List<TransationConfigModelValues>? values;

  TransationConfigModel({this.type, this.values});

  TransationConfigModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TransationConfigModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TransationConfigModelValues.fromJson(v));
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

class TransationConfigModelValues {
  int? imNId;
  int? mIId;
  String? imNAutoManualFlag;
  String? imNStartingNo;
  String? imNWidthNumeric;
  String? imNZeroPrefixFlag;
  bool? imNPrefixAcadYearCode;
  String? imNPrefixParticular;
  bool? imNSuffixAcadYearCode;
  String? imNSuffixParticular;
  String? imNRestartNumFlag;
  String? imNFlag;
  String? createdDate;
  String? updatedDate;
  bool? imNSuffixCalYearCode;

  TransationConfigModelValues(
      {this.imNId,
      this.mIId,
      this.imNAutoManualFlag,
      this.imNStartingNo,
      this.imNWidthNumeric,
      this.imNZeroPrefixFlag,
      this.imNPrefixAcadYearCode,
      this.imNPrefixParticular,
      this.imNSuffixAcadYearCode,
      this.imNSuffixParticular,
      this.imNRestartNumFlag,
      this.imNFlag,
      this.createdDate,
      this.updatedDate,
      this.imNSuffixCalYearCode});

  TransationConfigModelValues.fromJson(Map<String, dynamic> json) {
    imNId = json['imN_Id'];
    mIId = json['mI_Id'];
    imNAutoManualFlag = json['imN_AutoManualFlag'];
    imNStartingNo = json['imN_StartingNo'];
    imNWidthNumeric = json['imN_WidthNumeric'];
    imNZeroPrefixFlag = json['imN_ZeroPrefixFlag'];
    imNPrefixAcadYearCode = json['imN_PrefixAcadYearCode'];
    imNPrefixParticular = json['imN_PrefixParticular'];
    imNSuffixAcadYearCode = json['imN_SuffixAcadYearCode'];
    imNSuffixParticular = json['imN_SuffixParticular'];
    imNRestartNumFlag = json['imN_RestartNumFlag'];
    imNFlag = json['imN_Flag'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    imNSuffixCalYearCode = json['imN_SuffixCalYearCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imN_Id'] = imNId;
    data['mI_Id'] = mIId;
    data['imN_AutoManualFlag'] = imNAutoManualFlag;
    data['imN_StartingNo'] = imNStartingNo;
    data['imN_WidthNumeric'] = imNWidthNumeric;
    data['imN_ZeroPrefixFlag'] = imNZeroPrefixFlag;
    data['imN_PrefixAcadYearCode'] = imNPrefixAcadYearCode;
    data['imN_PrefixParticular'] = imNPrefixParticular;
    data['imN_SuffixAcadYearCode'] = imNSuffixAcadYearCode;
    data['imN_SuffixParticular'] = imNSuffixParticular;
    data['imN_RestartNumFlag'] = imNRestartNumFlag;
    data['imN_Flag'] = imNFlag;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['imN_SuffixCalYearCode'] = imNSuffixCalYearCode;
    return data;
  }
}
