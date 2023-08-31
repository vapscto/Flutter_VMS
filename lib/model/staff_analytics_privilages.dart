class StaffAnalyticsPrivilages {
  String? type;
  List<StaffAnalyticsPrivilagesValues>? values;

  StaffAnalyticsPrivilages({this.type, this.values});

  StaffAnalyticsPrivilages.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <StaffAnalyticsPrivilagesValues>[];
      json['\$values'].forEach((v) {
        values!.add(StaffAnalyticsPrivilagesValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    if (values != null) {
      data['$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StaffAnalyticsPrivilagesValues {
  int? amsTId;
  int? smscreditalert;
  bool? smsalrtflag;
  int? roleId;
  bool? isLogged;
  int? amaYActiveFlag;
  int? asmaYOrder;
  int? userId;
  int? rcredit;
  int? ivrMMOId;
  int? asmaYId;
  int? imfYId;
  int? role;
  int? ivrmimPId;
  int? mIID;
  int? pageId;
  bool? ivrmirPAddFlag;
  bool? ivrmirPUpdateFlag;
  bool? ivrmirPDeleteFlag;
  bool? ivrmirPReportFlag;
  bool? ivrmirPSearchFlag;
  bool? ivrmirPProcessFlag;
  String? pagename;
  String? pageicon;
  String? pageurl;
  int? ivrmrmaPId;
  String? cutoffdate;
  String? subscriptionenddate;
  bool? subscriptionFlag;
  String? dob;
  int? mobno;
  bool? payment;
  bool? registration;
  int? empcode;
  int? mIIdforlogin;
  int? paymentNootificationGeneral;
  int? roleTypeId;
  int? empId;
  bool? ivrmumalPAddFlg;
  bool? ivrmumalPUpdateFlg;
  bool? ivrmumalPDeleteFlg;
  int? almsTId;
  int? asmcLId;
  int? asmSId;

  StaffAnalyticsPrivilagesValues(
      {this.amsTId,
      this.smscreditalert,
      this.smsalrtflag,
      this.roleId,
      this.isLogged,
      this.amaYActiveFlag,
      this.asmaYOrder,
      this.userId,
      this.rcredit,
      this.ivrMMOId,
      this.asmaYId,
      this.imfYId,
      this.role,
      this.ivrmimPId,
      this.mIID,
      this.pageId,
      this.ivrmirPAddFlag,
      this.ivrmirPUpdateFlag,
      this.ivrmirPDeleteFlag,
      this.ivrmirPReportFlag,
      this.ivrmirPSearchFlag,
      this.ivrmirPProcessFlag,
      this.pagename,
      this.pageicon,
      this.pageurl,
      this.ivrmrmaPId,
      this.cutoffdate,
      this.subscriptionenddate,
      this.subscriptionFlag,
      this.dob,
      this.mobno,
      this.payment,
      this.registration,
      this.empcode,
      this.mIIdforlogin,
      this.paymentNootificationGeneral,
      this.roleTypeId,
      this.empId,
      this.ivrmumalPAddFlg,
      this.ivrmumalPUpdateFlg,
      this.ivrmumalPDeleteFlg,
      this.almsTId,
      this.asmcLId,
      this.asmSId});

  StaffAnalyticsPrivilagesValues.fromJson(Map<String, dynamic> json) {
    amsTId = json['amsT_Id'];
    smscreditalert = json['smscreditalert'];
    smsalrtflag = json['smsalrtflag'];
    roleId = json['roleId'];
    isLogged = json['isLogged'];
    amaYActiveFlag = json['amaY_ActiveFlag'];
    asmaYOrder = json['asmaY_Order'];
    userId = json['userId'];
    rcredit = json['rcredit'];
    ivrMMOId = json['ivrM_MO_Id'];
    asmaYId = json['asmaY_Id'];
    imfYId = json['imfY_Id'];
    role = json['role'];
    ivrmimPId = json['ivrmimP_Id'];
    mIID = json['mI_ID'];
    pageId = json['pageId'];
    ivrmirPAddFlag = json['ivrmirP_AddFlag'];
    ivrmirPUpdateFlag = json['ivrmirP_UpdateFlag'];
    ivrmirPDeleteFlag = json['ivrmirP_DeleteFlag'];
    ivrmirPReportFlag = json['ivrmirP_ReportFlag'];
    ivrmirPSearchFlag = json['ivrmirP_SearchFlag'];
    ivrmirPProcessFlag = json['ivrmirP_ProcessFlag'];
    pagename = json['pagename'];
    pageicon = json['pageicon'];
    pageurl = json['pageurl'];
    ivrmrmaPId = json['ivrmrmaP_Id'];
    cutoffdate = json['cutoffdate'];
    subscriptionenddate = json['subscriptionenddate'];
    subscriptionFlag = json['subscriptionFlag'];
    dob = json['dob'];
    mobno = json['mobno'];
    payment = json['payment'];
    registration = json['registration'];
    empcode = json['empcode'];
    mIIdforlogin = json['mI_Idforlogin'];
    paymentNootificationGeneral = json['paymentNootificationGeneral'];
    roleTypeId = json['roleTypeId'];
    empId = json['emp_Id'];
    ivrmumalPAddFlg = json['ivrmumalP_AddFlg'];
    ivrmumalPUpdateFlg = json['ivrmumalP_UpdateFlg'];
    ivrmumalPDeleteFlg = json['ivrmumalP_DeleteFlg'];
    almsTId = json['almsT_Id'];
    asmcLId = json['asmcL_Id'];
    asmSId = json['asmS_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amsT_Id'] = amsTId;
    data['smscreditalert'] = smscreditalert;
    data['smsalrtflag'] = smsalrtflag;
    data['roleId'] = roleId;
    data['isLogged'] = isLogged;
    data['amaY_ActiveFlag'] = amaYActiveFlag;
    data['asmaY_Order'] = asmaYOrder;
    data['userId'] = userId;
    data['rcredit'] = rcredit;
    data['ivrM_MO_Id'] = ivrMMOId;
    data['asmaY_Id'] = asmaYId;
    data['imfY_Id'] = imfYId;
    data['role'] = role;
    data['ivrmimP_Id'] = ivrmimPId;
    data['mI_ID'] = mIID;
    data['pageId'] = pageId;
    data['ivrmirP_AddFlag'] = ivrmirPAddFlag;
    data['ivrmirP_UpdateFlag'] = ivrmirPUpdateFlag;
    data['ivrmirP_DeleteFlag'] = ivrmirPDeleteFlag;
    data['ivrmirP_ReportFlag'] = ivrmirPReportFlag;
    data['ivrmirP_SearchFlag'] = ivrmirPSearchFlag;
    data['ivrmirP_ProcessFlag'] = ivrmirPProcessFlag;
    data['pagename'] = pagename;
    data['pageicon'] = pageicon;
    data['pageurl'] = pageurl;
    data['ivrmrmaP_Id'] = ivrmrmaPId;
    data['cutoffdate'] = cutoffdate;
    data['subscriptionenddate'] = subscriptionenddate;
    data['subscriptionFlag'] = subscriptionFlag;
    data['dob'] = dob;
    data['mobno'] = mobno;
    data['payment'] = payment;
    data['registration'] = registration;
    data['empcode'] = empcode;
    data['mI_Idforlogin'] = mIIdforlogin;
    data['paymentNootificationGeneral'] = paymentNootificationGeneral;
    data['roleTypeId'] = roleTypeId;
    data['emp_Id'] = empId;
    data['ivrmumalP_AddFlg'] = ivrmumalPAddFlg;
    data['ivrmumalP_UpdateFlg'] = ivrmumalPUpdateFlg;
    data['ivrmumalP_DeleteFlg'] = ivrmumalPDeleteFlg;
    data['almsT_Id'] = almsTId;
    data['asmcL_Id'] = asmcLId;
    data['asmS_Id'] = asmSId;
    return data;
  }
}
