class TourPlanFileDmo {
  String? type;
  List<TourPlanFileDmoValues>? values;

  TourPlanFileDmo({this.type, this.values});

  TourPlanFileDmo.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <TourPlanFileDmoValues>[];
      json['\$values'].forEach((v) {
        values!.add(TourPlanFileDmoValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TourPlanFileDmoValues {
  String? type;
  int? iLRTID;
  int? iERID;
  String? iLRTFileName;
  String? iLRTFiledesc;
  String? iLRTFilePath;
  bool? iLRTApprovedFlg;
  String? iLRTRemarks;
  String? iLRTStatusFlg;
  bool? iLRTActiveFlag;
  int? iLRTCreatedby;
  String? iLRTCreatedDate;
  int? iLRTUpdateby;
  String? iLRTUpdateDate;
  String? iLRTVerifieRemarks;
  double? iLRTCost;
  int? iERCID;

  TourPlanFileDmoValues(
      {this.type,
      this.iLRTID,
      this.iERID,
      this.iLRTFileName,
      this.iLRTFiledesc,
      this.iLRTFilePath,
      this.iLRTApprovedFlg,
      this.iLRTRemarks,
      this.iLRTStatusFlg,
      this.iLRTActiveFlag,
      this.iLRTCreatedby,
      this.iLRTCreatedDate,
      this.iLRTUpdateby,
      this.iLRTUpdateDate,
      this.iLRTVerifieRemarks,
      this.iLRTCost,
      this.iERCID});

  TourPlanFileDmoValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iLRTID = json['ILRT_ID'];
    iERID = json['IER_ID'];
    iLRTFileName = json['ILRT_FileName'];
    iLRTFiledesc = json['ILRT_Filedesc'];
    iLRTFilePath = json['ILRT_FilePath'];
    iLRTApprovedFlg = json['ILRT_ApprovedFlg'];
    iLRTRemarks = json['ILRT_Remarks'];
    iLRTStatusFlg = json['ILRT_StatusFlg'];
    iLRTActiveFlag = json['ILRT_ActiveFlag'];
    iLRTCreatedby = json['ILRT_Createdby'];
    iLRTCreatedDate = json['ILRT_CreatedDate'];
    iLRTUpdateby = json['ILRT_Updateby'];
    iLRTUpdateDate = json['ILRT_UpdateDate'];
    iLRTVerifieRemarks = json['ILRT_VerifieRemarks'];
    iLRTCost = json['ILRT_Cost'];
    iERCID = json['IERC_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ILRT_ID'] = iLRTID;
    data['IER_ID'] = iERID;
    data['ILRT_FileName'] = iLRTFileName;
    data['ILRT_Filedesc'] = iLRTFiledesc;
    data['ILRT_FilePath'] = iLRTFilePath;
    data['ILRT_ApprovedFlg'] = iLRTApprovedFlg;
    data['ILRT_Remarks'] = iLRTRemarks;
    data['ILRT_StatusFlg'] = iLRTStatusFlg;
    data['ILRT_ActiveFlag'] = iLRTActiveFlag;
    data['ILRT_Createdby'] = iLRTCreatedby;
    data['ILRT_CreatedDate'] = iLRTCreatedDate;
    data['ILRT_Updateby'] = iLRTUpdateby;
    data['ILRT_UpdateDate'] = iLRTUpdateDate;
    data['ILRT_VerifieRemarks'] = iLRTVerifieRemarks;
    data['ILRT_Cost'] = iLRTCost;
    data['IERC_ID'] = iERCID;
    return data;
  }
}
