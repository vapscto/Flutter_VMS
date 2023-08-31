class AcademicYearList {
  String? type;
  List<AcademicYearListValues>? values;

  AcademicYearList({this.type, this.values});

  AcademicYearList.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <AcademicYearListValues>[];
      json['\$values'].forEach((v) {
        values!.add(new AcademicYearListValues.fromJson(v));
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

class AcademicYearListValues {
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
  String? asmaYTransportSDate;
  String? asmaYTransportEDate;
  int? asmaYCreatedBy;
  int? asmaYUpdatedBy;
  String? asmaYAcademicYearCode;
  String? asmaYRegularFeeFDate;
  String? asmaYRegularFeeTDate;
  String? createdDate;
  String? updatedDate;
  String? asmaYReferenceDate;

  AcademicYearListValues(
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
      this.asmaYTransportSDate,
      this.asmaYTransportEDate,
      this.asmaYCreatedBy,
      this.asmaYUpdatedBy,
      this.asmaYAcademicYearCode,
      this.asmaYRegularFeeFDate,
      this.asmaYRegularFeeTDate,
      this.createdDate,
      this.updatedDate,
      this.asmaYReferenceDate});

  AcademicYearListValues.fromJson(Map<String, dynamic> json) {
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
    asmaYTransportSDate = json['asmaY_TransportSDate'];
    asmaYTransportEDate = json['asmaY_TransportEDate'];
    asmaYCreatedBy = json['asmaY_CreatedBy'];
    asmaYUpdatedBy = json['asmaY_UpdatedBy'];
    asmaYAcademicYearCode = json['asmaY_AcademicYearCode'];
    asmaYRegularFeeFDate = json['asmaY_RegularFeeFDate'];
    asmaYRegularFeeTDate = json['asmaY_RegularFeeTDate'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    asmaYReferenceDate = json['asmaY_ReferenceDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asmaY_Id'] = this.asmaYId;
    data['mI_Id'] = this.mIId;
    data['asmaY_Year'] = this.asmaYYear;
    data['asmaY_From_Date'] = this.asmaYFromDate;
    data['asmaY_To_Date'] = this.asmaYToDate;
    data['asmaY_PreAdm_F_Date'] = this.asmaYPreAdmFDate;
    data['asmaY_PreAdm_T_Date'] = this.asmaYPreAdmTDate;
    data['asmaY_Order'] = this.asmaYOrder;
    data['asmaY_ActiveFlag'] = this.asmaYActiveFlag;
    data['asmaY_Cut_Of_Date'] = this.asmaYCutOfDate;
    data['asmaY_Pre_ActiveFlag'] = this.asmaYPreActiveFlag;
    data['is_Active'] = this.isActive;
    data['asmaY_ReggularFlg'] = this.asmaYReggularFlg;
    data['asmaY_NewFlg'] = this.asmaYNewFlg;
    data['asmaY_NewAdmissionFlg'] = this.asmaYNewAdmissionFlg;
    data['asmaY_TransportSDate'] = this.asmaYTransportSDate;
    data['asmaY_TransportEDate'] = this.asmaYTransportEDate;
    data['asmaY_CreatedBy'] = this.asmaYCreatedBy;
    data['asmaY_UpdatedBy'] = this.asmaYUpdatedBy;
    data['asmaY_AcademicYearCode'] = this.asmaYAcademicYearCode;
    data['asmaY_RegularFeeFDate'] = this.asmaYRegularFeeFDate;
    data['asmaY_RegularFeeTDate'] = this.asmaYRegularFeeTDate;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['asmaY_ReferenceDate'] = this.asmaYReferenceDate;
    return data;
  }
}
