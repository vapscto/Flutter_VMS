class StaffGalleryClassListModel {
  String? type;
  List<StaffGalleryClassListModelValues>? values;

  StaffGalleryClassListModel({this.type, this.values});

  StaffGalleryClassListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <StaffGalleryClassListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new StaffGalleryClassListModelValues.fromJson(v));
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

class StaffGalleryClassListModelValues {
  int? mIId;
  int? asmaYId;
  int? userId;
  bool? returnval;
  int? amsTId;
  int? asmcLId;
  String? asmcLClassName;
  int? asmcLOrder;
  int? asmSId;
  int? asmCOrder;
  int? igAId;
  int? igaId;
  String? igADate;
  int? igACreatedBy;
  int? igAUpdatedBy;
  bool? igAActiveFlag;
  bool? igACommonGalleryFlg;
  int? igaPId;
  bool? igaPCoverPhotoFlag;
  bool? igaPActiveFlag;
  int? igacLId;
  bool? igacLActiveFlag;
  int? igacLCreatedBy;
  int? igacLUpdatedBy;
  int? ivrmrTId;
  int? month;

  StaffGalleryClassListModelValues(
      {this.mIId,
      this.asmaYId,
      this.userId,
      this.returnval,
      this.amsTId,
      this.asmcLId,
      this.asmcLClassName,
      this.asmcLOrder,
      this.asmSId,
      this.asmCOrder,
      this.igAId,
      this.igaId,
      this.igADate,
      this.igACreatedBy,
      this.igAUpdatedBy,
      this.igAActiveFlag,
      this.igACommonGalleryFlg,
      this.igaPId,
      this.igaPCoverPhotoFlag,
      this.igaPActiveFlag,
      this.igacLId,
      this.igacLActiveFlag,
      this.igacLCreatedBy,
      this.igacLUpdatedBy,
      this.ivrmrTId,
      this.month});

  StaffGalleryClassListModelValues.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    userId = json['userId'];
    returnval = json['returnval'];
    amsTId = json['amsT_Id'];
    asmcLId = json['asmcL_Id'];
    asmcLClassName = json['asmcL_ClassName'];
    asmcLOrder = json['asmcL_Order'];
    asmSId = json['asmS_Id'];
    asmCOrder = json['asmC_Order'];
    igAId = json['igA_Id'];
    igaId = json['igaId'];
    igADate = json['igA_Date'];
    igACreatedBy = json['igA_CreatedBy'];
    igAUpdatedBy = json['igA_UpdatedBy'];
    igAActiveFlag = json['igA_ActiveFlag'];
    igACommonGalleryFlg = json['igA_CommonGalleryFlg'];
    igaPId = json['igaP_Id'];
    igaPCoverPhotoFlag = json['igaP_CoverPhotoFlag'];
    igaPActiveFlag = json['igaP_ActiveFlag'];
    igacLId = json['igacL_Id'];
    igacLActiveFlag = json['igacL_ActiveFlag'];
    igacLCreatedBy = json['igacL_CreatedBy'];
    igacLUpdatedBy = json['igacL_UpdatedBy'];
    ivrmrTId = json['ivrmrT_Id'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mI_Id'] = this.mIId;
    data['asmaY_Id'] = this.asmaYId;
    data['userId'] = this.userId;
    data['returnval'] = this.returnval;
    data['amsT_Id'] = this.amsTId;
    data['asmcL_Id'] = this.asmcLId;
    data['asmcL_ClassName'] = this.asmcLClassName;
    data['asmcL_Order'] = this.asmcLOrder;
    data['asmS_Id'] = this.asmSId;
    data['asmC_Order'] = this.asmCOrder;
    data['igA_Id'] = this.igAId;
    data['igaId'] = this.igaId;
    data['igA_Date'] = this.igADate;
    data['igA_CreatedBy'] = this.igACreatedBy;
    data['igA_UpdatedBy'] = this.igAUpdatedBy;
    data['igA_ActiveFlag'] = this.igAActiveFlag;
    data['igA_CommonGalleryFlg'] = this.igACommonGalleryFlg;
    data['igaP_Id'] = this.igaPId;
    data['igaP_CoverPhotoFlag'] = this.igaPCoverPhotoFlag;
    data['igaP_ActiveFlag'] = this.igaPActiveFlag;
    data['igacL_Id'] = this.igacLId;
    data['igacL_ActiveFlag'] = this.igacLActiveFlag;
    data['igacL_CreatedBy'] = this.igacLCreatedBy;
    data['igacL_UpdatedBy'] = this.igacLUpdatedBy;
    data['ivrmrT_Id'] = this.ivrmrTId;
    data['month'] = this.month;
    return data;
  }
}
