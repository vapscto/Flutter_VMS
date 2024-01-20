class Getmodule {
  String? type;
  List<GetmoduleValues>? values;

  Getmodule({this.type, this.values});

  Getmodule.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GetmoduleValues>[];
      json['\$values'].forEach((v) {
        values!.add(GetmoduleValues.fromJson(v));
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

class GetmoduleValues {
  bool? returnval;
  bool? roleflag;
  bool? completed;
  bool? pending;
  bool? alreadyCnt;
  int? userId;
  int? ivrmrTId;
  bool? plannerextapproval;
  String? plannerMaxdate;
  int? ismmaCId;
  int? mIId;
  int? miId;
  int? hrmEId;
  int? asmaYId;
  int? hrmDId;
  int? ismmpRId;
  int? ivrmMId;
  String? ivrmMModuleName;
  int? ismmmDId;
  int? ismmmDModuleHeadId;
  int? ismtcRId;
  int? hrmpRId;
  int? ismmtcaTId;
  bool? ismtcRReOpenFlg;
  bool? ismtcRActiveFlg;
  int? ismtcRCreatedBy;
  int? ismtcRUpdatedBy;
  int? ismtcrcLId;
  int? ismmclTId;
  bool? ismtcrcLActiveFlg;
  int? ismtcrcLCreatedBy;
  int? ismtcrcLUpdatedBy;
  int? ismtcraTId;
  bool? ismtcraTActiveFlg;
  int? ismtcraTCreatedBy;
  int? ismtcraTUpdatedBy;
  int? prioritycheck;
  int? ismciMIEList;
  double? effortinhrs;

  GetmoduleValues(
      {this.returnval,
      this.roleflag,
      this.completed,
      this.pending,
      this.alreadyCnt,
      this.userId,
      this.ivrmrTId,
      this.plannerextapproval,
      this.plannerMaxdate,
      this.ismmaCId,
      this.mIId,
      this.miId,
      this.hrmEId,
      this.asmaYId,
      this.hrmDId,
      this.ismmpRId,
      this.ivrmMId,
      this.ivrmMModuleName,
      this.ismmmDId,
      this.ismmmDModuleHeadId,
      this.ismtcRId,
      this.hrmpRId,
      this.ismmtcaTId,
      this.ismtcRReOpenFlg,
      this.ismtcRActiveFlg,
      this.ismtcRCreatedBy,
      this.ismtcRUpdatedBy,
      this.ismtcrcLId,
      this.ismmclTId,
      this.ismtcrcLActiveFlg,
      this.ismtcrcLCreatedBy,
      this.ismtcrcLUpdatedBy,
      this.ismtcraTId,
      this.ismtcraTActiveFlg,
      this.ismtcraTCreatedBy,
      this.ismtcraTUpdatedBy,
      this.prioritycheck,
      this.ismciMIEList,
      this.effortinhrs});

  GetmoduleValues.fromJson(Map<String, dynamic> json) {
    returnval = json['returnval'];
    roleflag = json['roleflag'];
    completed = json['completed'];
    pending = json['pending'];
    alreadyCnt = json['already_cnt'];
    userId = json['userId'];
    ivrmrTId = json['ivrmrT_Id'];
    plannerextapproval = json['plannerextapproval'];
    plannerMaxdate = json['plannerMaxdate'];
    ismmaCId = json['ismmaC_Id'];
    mIId = json['mI_Id'];
    miId = json['miId'];
    hrmEId = json['hrmE_Id'];
    asmaYId = json['asmaY_Id'];
    hrmDId = json['hrmD_Id'];
    ismmpRId = json['ismmpR_Id'];
    ivrmMId = json['ivrmM_Id'];
    ivrmMModuleName = json['ivrmM_ModuleName'];
    ismmmDId = json['ismmmD_Id'];
    ismmmDModuleHeadId = json['ismmmD_ModuleHeadId'];
    ismtcRId = json['ismtcR_Id'];
    hrmpRId = json['hrmpR_Id'];
    ismmtcaTId = json['ismmtcaT_Id'];
    ismtcRReOpenFlg = json['ismtcR_ReOpenFlg'];
    ismtcRActiveFlg = json['ismtcR_ActiveFlg'];
    ismtcRCreatedBy = json['ismtcR_CreatedBy'];
    ismtcRUpdatedBy = json['ismtcR_UpdatedBy'];
    ismtcrcLId = json['ismtcrcL_Id'];
    ismmclTId = json['ismmclT_Id'];
    ismtcrcLActiveFlg = json['ismtcrcL_ActiveFlg'];
    ismtcrcLCreatedBy = json['ismtcrcL_CreatedBy'];
    ismtcrcLUpdatedBy = json['ismtcrcL_UpdatedBy'];
    ismtcraTId = json['ismtcraT_Id'];
    ismtcraTActiveFlg = json['ismtcraT_ActiveFlg'];
    ismtcraTCreatedBy = json['ismtcraT_CreatedBy'];
    ismtcraTUpdatedBy = json['ismtcraT_UpdatedBy'];
    prioritycheck = json['prioritycheck'];
    ismciMIEList = json['ismciM_IEList'];
    effortinhrs = json['effortinhrs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['returnval'] = returnval;
    data['roleflag'] = roleflag;
    data['completed'] = completed;
    data['pending'] = pending;
    data['already_cnt'] = alreadyCnt;
    data['userId'] = userId;
    data['ivrmrT_Id'] = ivrmrTId;
    data['plannerextapproval'] = plannerextapproval;
    data['plannerMaxdate'] = plannerMaxdate;
    data['ismmaC_Id'] = ismmaCId;
    data['mI_Id'] = mIId;
    data['miId'] = miId;
    data['hrmE_Id'] = hrmEId;
    data['asmaY_Id'] = asmaYId;
    data['hrmD_Id'] = hrmDId;
    data['ismmpR_Id'] = ismmpRId;
    data['ivrmM_Id'] = ivrmMId;
    data['ivrmM_ModuleName'] = ivrmMModuleName;
    data['ismmmD_Id'] = ismmmDId;
    data['ismmmD_ModuleHeadId'] = ismmmDModuleHeadId;
    data['ismtcR_Id'] = ismtcRId;
    data['hrmpR_Id'] = hrmpRId;
    data['ismmtcaT_Id'] = ismmtcaTId;
    data['ismtcR_ReOpenFlg'] = ismtcRReOpenFlg;
    data['ismtcR_ActiveFlg'] = ismtcRActiveFlg;
    data['ismtcR_CreatedBy'] = ismtcRCreatedBy;
    data['ismtcR_UpdatedBy'] = ismtcRUpdatedBy;
    data['ismtcrcL_Id'] = ismtcrcLId;
    data['ismmclT_Id'] = ismmclTId;
    data['ismtcrcL_ActiveFlg'] = ismtcrcLActiveFlg;
    data['ismtcrcL_CreatedBy'] = ismtcrcLCreatedBy;
    data['ismtcrcL_UpdatedBy'] = ismtcrcLUpdatedBy;
    data['ismtcraT_Id'] = ismtcraTId;
    data['ismtcraT_ActiveFlg'] = ismtcraTActiveFlg;
    data['ismtcraT_CreatedBy'] = ismtcraTCreatedBy;
    data['ismtcraT_UpdatedBy'] = ismtcraTUpdatedBy;
    data['prioritycheck'] = prioritycheck;
    data['ismciM_IEList'] = ismciMIEList;
    data['effortinhrs'] = effortinhrs;
    return data;
  }
}
