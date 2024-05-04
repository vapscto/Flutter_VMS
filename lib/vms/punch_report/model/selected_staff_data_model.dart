class SelectedStaffDataModel {
  List<SelectedActivityDetails1Stf>? selectedActivityDetails1Stf;

  SelectedStaffDataModel({this.selectedActivityDetails1Stf});

  SelectedStaffDataModel.fromJson(Map<String, dynamic> json) {
    if (json['selectedActivityDetails1_stf'] != null) {
      selectedActivityDetails1Stf = <SelectedActivityDetails1Stf>[];
      json['selectedActivityDetails1_stf'].forEach((v) {
        selectedActivityDetails1Stf!
            .add(SelectedActivityDetails1Stf.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (selectedActivityDetails1Stf != null) {
      data['selectedActivityDetails1_stf'] =
          selectedActivityDetails1Stf!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SelectedActivityDetails1Stf {
  int? hrmEId;
  int? mIId;
  int? ivrmrTId;
  int? vmscrTId;
  String? hrmEEmployeeFirstName;
  String? hrmEEmployeeCode;
  String? hrmEPerStreet;
  String? hrmEDOJ;
  int? hrmERelaxtime;
  bool? hrmELeftFlag;
  bool? hrmEExcDR;
  bool? hrmEExcPunch;
  int? ivrmuLId;
  int? logInUserId;
  int? fomsTId;
  int? fomSId;
  int? fohwdTId;

  SelectedActivityDetails1Stf(
      {this.hrmEId,
      this.mIId,
      this.ivrmrTId,
      this.vmscrTId,
      this.hrmEEmployeeFirstName,
      this.hrmEEmployeeCode,
      this.hrmEPerStreet,
      this.hrmEDOJ,
      this.hrmERelaxtime,
      this.hrmELeftFlag,
      this.hrmEExcDR,
      this.hrmEExcPunch,
      this.ivrmuLId,
      this.logInUserId,
      this.fomsTId,
      this.fomSId,
      this.fohwdTId});

  SelectedActivityDetails1Stf.fromJson(Map<String, dynamic> json) {
    hrmEId = json['hrmE_Id'];
    mIId = json['mI_Id'];
    ivrmrTId = json['ivrmrT_Id'];
    vmscrTId = json['vmscrT_Id'];
    hrmEEmployeeFirstName = json['hrmE_EmployeeFirstName'];
    hrmEEmployeeCode = json['hrmE_EmployeeCode'];
    hrmEPerStreet = json['hrmE_PerStreet'];
    hrmEDOJ = json['hrmE_DOJ'];
    hrmERelaxtime = json['hrmE_Relaxtime'];
    hrmELeftFlag = json['hrmE_LeftFlag'];
    hrmEExcDR = json['hrmE_ExcDR'];
    hrmEExcPunch = json['hrmE_ExcPunch'];
    ivrmuLId = json['ivrmuL_Id'];
    logInUserId = json['logInUserId'];
    fomsTId = json['fomsT_Id'];
    fomSId = json['fomS_Id'];
    fohwdTId = json['fohwdT_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hrmE_Id'] = hrmEId;
    data['mI_Id'] = mIId;
    data['ivrmrT_Id'] = ivrmrTId;
    data['vmscrT_Id'] = vmscrTId;
    data['hrmE_EmployeeFirstName'] = hrmEEmployeeFirstName;
    data['hrmE_EmployeeCode'] = hrmEEmployeeCode;
    data['hrmE_PerStreet'] = hrmEPerStreet;
    data['hrmE_DOJ'] = hrmEDOJ;
    data['hrmE_Relaxtime'] = hrmERelaxtime;
    data['hrmE_LeftFlag'] = hrmELeftFlag;
    data['hrmE_ExcDR'] = hrmEExcDR;
    data['hrmE_ExcPunch'] = hrmEExcPunch;
    data['ivrmuL_Id'] = ivrmuLId;
    data['logInUserId'] = logInUserId;
    data['fomsT_Id'] = fomsTId;
    data['fomS_Id'] = fomSId;
    data['fohwdT_Id'] = fohwdTId;
    return data;
  }
}
