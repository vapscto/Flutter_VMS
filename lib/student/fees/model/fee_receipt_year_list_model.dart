class FeeReceiptYearListModel {
  int? amsTId;
  int? mIId;
  int? asmaYId;
  bool? status;
  Yearlist? yearlist;

  FeeReceiptYearListModel(
      {this.amsTId, this.mIId, this.asmaYId, this.status, this.yearlist});

  FeeReceiptYearListModel.fromJson(Map<String, dynamic> json) {
    amsTId = json['amsT_Id'];
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    status = json['status'];
    yearlist =
        json['yearlist'] != null ? Yearlist.fromJson(json['yearlist']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amsT_Id'] = amsTId;
    data['mI_Id'] = mIId;
    data['asmaY_Id'] = asmaYId;
    data['status'] = status;
    if (yearlist != null) {
      data['yearlist'] = yearlist!.toJson();
    }
    return data;
  }
}

class Yearlist {
  String? type;
  List<YearlistValues>? values;

  Yearlist({this.type, this.values});

  Yearlist.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <YearlistValues>[];
      json['\$values'].forEach((v) {
        values!.add(YearlistValues.fromJson(v));
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

class YearlistValues {
  int? asmaYId;
  int? mIId;
  String? asmaYYear;
  String? asmaYFromDate;
  String? asmaYToDate;
  String? asmaYPreAdmFDate;
  String? asmaYPreAdmTDate;
  int? asmaYOrder;
  int? asmaYActiveFlag;
  String? asmaYCutOfDate;
  int? asmaYPreActiveFlag;
  bool? isActive;
  bool? asmaYReggularFlg;
  bool? asmaYNewFlg;
  bool? asmaYNewAdmissionFlg;
  int? asmaYCreatedBy;
  int? asmaYUpdatedBy;
  String? asmaYAcademicYearCode;
  String? asmaYRegularFeeFDate;
  String? asmaYRegularFeeTDate;
  String? createdDate;
  String? updatedDate;
  String? asmaYTransportSDate;
  String? asmaYTransportEDate;
  String? asmaYReferenceDate;
  String? asmaYAdvanceFeeDate;
  String? asmaYArrearFeeDate;

  YearlistValues(
      {this.asmaYId,
      this.mIId,
      this.asmaYYear,
      this.asmaYFromDate,
      this.asmaYToDate,
      this.asmaYPreAdmFDate,
      this.asmaYPreAdmTDate,
      this.asmaYOrder,
      this.asmaYActiveFlag,
      this.asmaYCutOfDate,
      this.asmaYPreActiveFlag,
      this.isActive,
      this.asmaYReggularFlg,
      this.asmaYNewFlg,
      this.asmaYNewAdmissionFlg,
      this.asmaYCreatedBy,
      this.asmaYUpdatedBy,
      this.asmaYAcademicYearCode,
      this.asmaYRegularFeeFDate,
      this.asmaYRegularFeeTDate,
      this.createdDate,
      this.updatedDate,
      this.asmaYTransportSDate,
      this.asmaYTransportEDate,
      this.asmaYReferenceDate,
      this.asmaYAdvanceFeeDate,
      this.asmaYArrearFeeDate});

  YearlistValues.fromJson(Map<String, dynamic> json) {
    asmaYId = json['asmaY_Id'];
    mIId = json['mI_Id'];
    asmaYYear = json['asmaY_Year'];
    asmaYFromDate = json['asmaY_From_Date'];
    asmaYToDate = json['asmaY_To_Date'];
    asmaYPreAdmFDate = json['asmaY_PreAdm_F_Date'];
    asmaYPreAdmTDate = json['asmaY_PreAdm_T_Date'];
    asmaYOrder = json['asmaY_Order'];
    asmaYActiveFlag = json['asmaY_ActiveFlag'];
    asmaYCutOfDate = json['asmaY_Cut_Of_Date'];
    asmaYPreActiveFlag = json['asmaY_Pre_ActiveFlag'];
    isActive = json['is_Active'];
    asmaYReggularFlg = json['asmaY_ReggularFlg'];
    asmaYNewFlg = json['asmaY_NewFlg'];
    asmaYNewAdmissionFlg = json['asmaY_NewAdmissionFlg'];
    asmaYCreatedBy = json['asmaY_CreatedBy'];
    asmaYUpdatedBy = json['asmaY_UpdatedBy'];
    asmaYAcademicYearCode = json['asmaY_AcademicYearCode'];
    asmaYRegularFeeFDate = json['asmaY_RegularFeeFDate'];
    asmaYRegularFeeTDate = json['asmaY_RegularFeeTDate'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    asmaYTransportSDate = json['asmaY_TransportSDate'];
    asmaYTransportEDate = json['asmaY_TransportEDate'];
    asmaYReferenceDate = json['asmaY_ReferenceDate'];
    asmaYAdvanceFeeDate = json['asmaY_AdvanceFeeDate'];
    asmaYArrearFeeDate = json['asmaY_ArrearFeeDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['asmaY_Id'] = asmaYId;
    data['mI_Id'] = mIId;
    data['asmaY_Year'] = asmaYYear;
    data['asmaY_From_Date'] = asmaYFromDate;
    data['asmaY_To_Date'] = asmaYToDate;
    data['asmaY_PreAdm_F_Date'] = asmaYPreAdmFDate;
    data['asmaY_PreAdm_T_Date'] = asmaYPreAdmTDate;
    data['asmaY_Order'] = asmaYOrder;
    data['asmaY_ActiveFlag'] = asmaYActiveFlag;
    data['asmaY_Cut_Of_Date'] = asmaYCutOfDate;
    data['asmaY_Pre_ActiveFlag'] = asmaYPreActiveFlag;
    data['is_Active'] = isActive;
    data['asmaY_ReggularFlg'] = asmaYReggularFlg;
    data['asmaY_NewFlg'] = asmaYNewFlg;
    data['asmaY_NewAdmissionFlg'] = asmaYNewAdmissionFlg;
    data['asmaY_CreatedBy'] = asmaYCreatedBy;
    data['asmaY_UpdatedBy'] = asmaYUpdatedBy;
    data['asmaY_AcademicYearCode'] = asmaYAcademicYearCode;
    data['asmaY_RegularFeeFDate'] = asmaYRegularFeeFDate;
    data['asmaY_RegularFeeTDate'] = asmaYRegularFeeTDate;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['asmaY_TransportSDate'] = asmaYTransportSDate;
    data['asmaY_TransportEDate'] = asmaYTransportEDate;
    data['asmaY_ReferenceDate'] = asmaYReferenceDate;
    data['asmaY_AdvanceFeeDate'] = asmaYAdvanceFeeDate;
    data['asmaY_ArrearFeeDate'] = asmaYArrearFeeDate;
    return data;
  }
}
