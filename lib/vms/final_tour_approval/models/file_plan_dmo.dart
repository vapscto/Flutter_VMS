class TourPlanFileDmo {
  String? type;
  List<TourPlanFileDmoValues>? values;

  TourPlanFileDmo({this.type, this.values});

  TourPlanFileDmo.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <TourPlanFileDmoValues>[];
      json['\$values'].forEach((v) {
        values!.add(new TourPlanFileDmoValues.fromJson(v));
      });
    }
  } 

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    if (this.values != null) {
      data['\$values'] = this.values!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['ILRT_ID'] = this.iLRTID;
    data['IER_ID'] = this.iERID;
    data['ILRT_FileName'] = this.iLRTFileName;
    data['ILRT_Filedesc'] = this.iLRTFiledesc;
    data['ILRT_FilePath'] = this.iLRTFilePath;
    data['ILRT_ApprovedFlg'] = this.iLRTApprovedFlg;
    data['ILRT_Remarks'] = this.iLRTRemarks;
    data['ILRT_StatusFlg'] = this.iLRTStatusFlg;
    data['ILRT_ActiveFlag'] = this.iLRTActiveFlag;
    data['ILRT_Createdby'] = this.iLRTCreatedby;
    data['ILRT_CreatedDate'] = this.iLRTCreatedDate;
    data['ILRT_Updateby'] = this.iLRTUpdateby;
    data['ILRT_UpdateDate'] = this.iLRTUpdateDate;
    data['ILRT_VerifieRemarks'] = this.iLRTVerifieRemarks;
    data['ILRT_Cost'] = this.iLRTCost;
    data['IERC_ID'] = this.iERCID;
    return data;
  }
}
