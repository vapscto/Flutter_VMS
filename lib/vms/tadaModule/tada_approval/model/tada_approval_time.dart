class TadaApprovalTimeArrayModel {
  String? type;
  List<TadaApprovalTimeArrayModelValues>? values;

  TadaApprovalTimeArrayModel({this.type, this.values});

  TadaApprovalTimeArrayModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TadaApprovalTimeArrayModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TadaApprovalTimeArrayModelValues.fromJson(v));
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

class TadaApprovalTimeArrayModelValues {
  int? vtadaAId;
  int? mIId;
  int? hrmEId;
  String? vtadaAAppliedDate;
  String? vtadaAFromDate;
  String? vtadaAToDate;
  int? vtadaAClientId;
  String? vtadaAToAddress;
  String? vtadaARemarks;
  int? vtadaATotalAppliedAmount;
  int? vtadaATotalSactionedAmount;
  int? vtadaATotalPaidAmount;
  String? vtadaAStatusFlg;
  bool? vtadaAActiveFlg;
  int? vtadaACreatedBy;
  int? vtadaAUpdatedBy;
  String? vtadaACreatedDate;
  String? vtadaAUpdatedDate;
  int? ivrmmcTId;
  String? vtadaADepartureTime;
  String? vtadaAArrivalTime;
  String? vtadaaAClientMultiple;
  List<VmSTADAApplyFilesDMO>? vmSTADAApplyFilesDMO;

  TadaApprovalTimeArrayModelValues(
      {this.vtadaAId,
      this.mIId,
      this.hrmEId,
      this.vtadaAAppliedDate,
      this.vtadaAFromDate,
      this.vtadaAToDate,
      this.vtadaAClientId,
      this.vtadaAToAddress,
      this.vtadaARemarks,
      this.vtadaATotalAppliedAmount,
      this.vtadaATotalSactionedAmount,
      this.vtadaATotalPaidAmount,
      this.vtadaAStatusFlg,
      this.vtadaAActiveFlg,
      this.vtadaACreatedBy,
      this.vtadaAUpdatedBy,
      this.vtadaACreatedDate,
      this.vtadaAUpdatedDate,
      this.ivrmmcTId,
      this.vtadaADepartureTime,
      this.vtadaAArrivalTime,
      this.vtadaaAClientMultiple,
      this.vmSTADAApplyFilesDMO});

  TadaApprovalTimeArrayModelValues.fromJson(Map<String, dynamic> json) {
    vtadaAId = json['vtadaA_Id'];
    mIId = json['mI_Id'];
    hrmEId = json['hrmE_Id'];
    vtadaAAppliedDate = json['vtadaA_AppliedDate'];
    vtadaAFromDate = json['vtadaA_FromDate'];
    vtadaAToDate = json['vtadaA_ToDate'];
    vtadaAClientId = json['vtadaA_ClientId'];
    vtadaAToAddress = json['vtadaA_ToAddress'];
    vtadaARemarks = json['vtadaA_Remarks'];
    vtadaATotalAppliedAmount = json['vtadaA_TotalAppliedAmount'];
    vtadaATotalSactionedAmount = json['vtadaA_TotalSactionedAmount'];
    vtadaATotalPaidAmount = json['vtadaA_TotalPaidAmount'];
    vtadaAStatusFlg = json['vtadaA_StatusFlg'];
    vtadaAActiveFlg = json['vtadaA_ActiveFlg'];
    vtadaACreatedBy = json['vtadaA_CreatedBy'];
    vtadaAUpdatedBy = json['vtadaA_UpdatedBy'];
    vtadaACreatedDate = json['vtadaA_CreatedDate'];
    vtadaAUpdatedDate = json['vtadaA_UpdatedDate'];
    ivrmmcTId = json['ivrmmcT_Id'];
    vtadaADepartureTime = json['vtadaA_DepartureTime'];
    vtadaAArrivalTime = json['vtadaA_ArrivalTime'];
    vtadaaAClientMultiple = json['vtadaaA_ClientMultiple'];
    if (json['vmS_TADAApply_FilesDMO'] != null) {
      vmSTADAApplyFilesDMO = <VmSTADAApplyFilesDMO>[];
      json['vmS_TADAApply_FilesDMO'].forEach((v) {
        vmSTADAApplyFilesDMO!.add(VmSTADAApplyFilesDMO.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vtadaA_Id'] = vtadaAId;
    data['mI_Id'] = mIId;
    data['hrmE_Id'] = hrmEId;
    data['vtadaA_AppliedDate'] = vtadaAAppliedDate;
    data['vtadaA_FromDate'] = vtadaAFromDate;
    data['vtadaA_ToDate'] = vtadaAToDate;
    data['vtadaA_ClientId'] = vtadaAClientId;
    data['vtadaA_ToAddress'] = vtadaAToAddress;
    data['vtadaA_Remarks'] = vtadaARemarks;
    data['vtadaA_TotalAppliedAmount'] = vtadaATotalAppliedAmount;
    data['vtadaA_TotalSactionedAmount'] = vtadaATotalSactionedAmount;
    data['vtadaA_TotalPaidAmount'] = vtadaATotalPaidAmount;
    data['vtadaA_StatusFlg'] = vtadaAStatusFlg;
    data['vtadaA_ActiveFlg'] = vtadaAActiveFlg;
    data['vtadaA_CreatedBy'] = vtadaACreatedBy;
    data['vtadaA_UpdatedBy'] = vtadaAUpdatedBy;
    data['vtadaA_CreatedDate'] = vtadaACreatedDate;
    data['vtadaA_UpdatedDate'] = vtadaAUpdatedDate;
    data['ivrmmcT_Id'] = ivrmmcTId;
    data['vtadaA_DepartureTime'] = vtadaADepartureTime;
    data['vtadaA_ArrivalTime'] = vtadaAArrivalTime;
    data['vtadaaA_ClientMultiple'] = vtadaaAClientMultiple;
    if (vmSTADAApplyFilesDMO != null) {
      data['vmS_TADAApply_FilesDMO'] =
          vmSTADAApplyFilesDMO!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VmSTADAApplyFilesDMO {
  int? vtadaaFId;
  int? vtadaAId;
  String? vtadaaFFileName;
  String? vtadaaFFilePath;
  bool? vtadaaFApprovedFlg;
  String? vtadaaFRemarks;
  String? vtadaaFStatusFlg;
  bool? vtadaaFActiveFlag;

  VmSTADAApplyFilesDMO(
      {this.vtadaaFId,
      this.vtadaAId,
      this.vtadaaFFileName,
      this.vtadaaFFilePath,
      this.vtadaaFApprovedFlg,
      this.vtadaaFRemarks,
      this.vtadaaFStatusFlg,
      this.vtadaaFActiveFlag});

  VmSTADAApplyFilesDMO.fromJson(Map<String, dynamic> json) {
    vtadaaFId = json['vtadaaF_Id'];
    vtadaAId = json['vtadaA_Id'];
    vtadaaFFileName = json['vtadaaF_FileName'];
    vtadaaFFilePath = json['vtadaaF_FilePath'];
    vtadaaFApprovedFlg = json['vtadaaF_ApprovedFlg'];
    vtadaaFRemarks = json['vtadaaF_Remarks'];
    vtadaaFStatusFlg = json['vtadaaF_StatusFlg'];
    vtadaaFActiveFlag = json['vtadaaF_ActiveFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vtadaaF_Id'] = vtadaaFId;
    data['vtadaA_Id'] = vtadaAId;
    data['vtadaaF_FileName'] = vtadaaFFileName;
    data['vtadaaF_FilePath'] = vtadaaFFilePath;
    data['vtadaaF_ApprovedFlg'] = vtadaaFApprovedFlg;
    data['vtadaaF_Remarks'] = vtadaaFRemarks;
    data['vtadaaF_StatusFlg'] = vtadaaFStatusFlg;
    data['vtadaaF_ActiveFlag'] = vtadaaFActiveFlag;
    return data;
  }
}
