 class GeTskClient {
  String? type;
  List<GeTskClientValues>? values;

  GeTskClient({this.type, this.values});

  GeTskClient.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GeTskClientValues>[];
      json['\$values'].forEach((v) {
        values!.add(  GeTskClientValues.fromJson(v));
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

class GeTskClientValues {
  bool? returnval;
  bool? transfer;
  bool? alreadyCnt;
  bool? taskeditable;
  bool? assigntaskeditable;
  int? userId;
  int? hrmdCID;
  int? hrmdCOrder;
  int? ivrmrTId;
  String? localIndianTime;
  int? ismmaCId;
  int? mIId;
  int? asmaYId;
  int? hrmDId;
  int? ismmpRId;
  int? hrmEId;
  int? ivrmMId;
  int? ismmmDId;
  int? ismmmDModuleHeadId;
  int? ismmclTId;
  int? ismciMIEList;
  String? ismmclTClientName;
  int? ismtcRId;
  int? hrmpRId;
  bool? ismtcRReOpenFlg;
  bool? ismtcRActiveFlg;
  int? taskCount;
  int? openCount;
  int? closedCount;
  int? completedCount;
  int? inprogressCount;
  int? ismtcrastOId;
  String? ismtcrastOAssignedDate;
  int? ismtcrastOAssignedBy;
  double? ismtcrastOEffortInHrs;
  bool? ismtcrastOActiveFlg;
  int? ismtcrtrtOId;
  String? ismtcrtrtOTransferredDate;
  int? ismtcrtrtOTransferredBy;
  double? ismtcrtrtOEffortInHrs;
  bool? ismtcrtrtOActiveFlg;
  int? ismtcrtrtOCreatedBy;
  int? ismtcrtrtOUpdatedBy;
  int? ismtcrreSId;
  String? ismtcrreSResponseDate;
  bool? ismtcrreSActiveFlg;
  int? ismtcrreSCreatedBy;
  int? ismtcrreSUpdatedBy;
  double? eachTaskMaxDuration;
  bool? delettask;
  int? byMecount;
  int? toMecount;
  int? mycountonly;
  int? transferMecount;
  int? transferMecountonly;
  int? transferbycount;
  int? hrmETo;

  GeTskClientValues(
      {this.returnval,
      this.transfer,
      this.alreadyCnt,
      this.taskeditable,
      this.assigntaskeditable,
      this.userId,
      this.hrmdCID,
      this.hrmdCOrder,
      this.ivrmrTId,
      this.localIndianTime,
      this.ismmaCId,
      this.mIId,
      this.asmaYId,
      this.hrmDId,
      this.ismmpRId,
      this.hrmEId,
      this.ivrmMId,
      this.ismmmDId,
      this.ismmmDModuleHeadId,
      this.ismmclTId,
      this.ismciMIEList,
      this.ismmclTClientName,
      this.ismtcRId,
      this.hrmpRId,
      this.ismtcRReOpenFlg,
      this.ismtcRActiveFlg,
      this.taskCount,
      this.openCount,
      this.closedCount,
      this.completedCount,
      this.inprogressCount,
      this.ismtcrastOId,
      this.ismtcrastOAssignedDate,
      this.ismtcrastOAssignedBy,
      this.ismtcrastOEffortInHrs,
      this.ismtcrastOActiveFlg,
      this.ismtcrtrtOId,
      this.ismtcrtrtOTransferredDate,
      this.ismtcrtrtOTransferredBy,
      this.ismtcrtrtOEffortInHrs,
      this.ismtcrtrtOActiveFlg,
      this.ismtcrtrtOCreatedBy,
      this.ismtcrtrtOUpdatedBy,
      this.ismtcrreSId,
      this.ismtcrreSResponseDate,
      this.ismtcrreSActiveFlg,
      this.ismtcrreSCreatedBy,
      this.ismtcrreSUpdatedBy,
      this.eachTaskMaxDuration,
      this.delettask,
      this.byMecount,
      this.toMecount,
      this.mycountonly,
      this.transferMecount,
      this.transferMecountonly,
      this.transferbycount,
      this.hrmETo});

  GeTskClientValues.fromJson(Map<String, dynamic> json) {
    returnval = json['returnval'];
    transfer = json['transfer'];
    alreadyCnt = json['already_cnt'];
    taskeditable = json['taskeditable'];
    assigntaskeditable = json['assigntaskeditable'];
    userId = json['userId'];
    hrmdCID = json['hrmdC_ID'];
    hrmdCOrder = json['hrmdC_Order'];
    ivrmrTId = json['ivrmrT_Id'];
    localIndianTime = json['localIndianTime'];
    ismmaCId = json['ismmaC_Id'];
    mIId = json['mI_Id'];
    asmaYId = json['asmaY_Id'];
    hrmDId = json['hrmD_Id'];
    ismmpRId = json['ismmpR_Id'];
    hrmEId = json['hrmE_Id'];
    ivrmMId = json['ivrmM_Id'];
    ismmmDId = json['ismmmD_Id'];
    ismmmDModuleHeadId = json['ismmmD_ModuleHeadId'];
    ismmclTId = json['ismmclT_Id'];
    ismciMIEList = json['ismciM_IEList'];
    ismmclTClientName = json['ismmclT_ClientName'];
    ismtcRId = json['ismtcR_Id'];
    hrmpRId = json['hrmpR_Id'];
    ismtcRReOpenFlg = json['ismtcR_ReOpenFlg'];
    ismtcRActiveFlg = json['ismtcR_ActiveFlg'];
    taskCount = json['taskCount'];
    openCount = json['openCount'];
    closedCount = json['closedCount'];
    completedCount = json['completedCount'];
    inprogressCount = json['inprogressCount'];
    ismtcrastOId = json['ismtcrastO_Id'];
    ismtcrastOAssignedDate = json['ismtcrastO_AssignedDate'];
    ismtcrastOAssignedBy = json['ismtcrastO_AssignedBy'];
    ismtcrastOEffortInHrs = json['ismtcrastO_EffortInHrs'];
    ismtcrastOActiveFlg = json['ismtcrastO_ActiveFlg'];
    ismtcrtrtOId = json['ismtcrtrtO_Id'];
    ismtcrtrtOTransferredDate = json['ismtcrtrtO_TransferredDate'];
    ismtcrtrtOTransferredBy = json['ismtcrtrtO_TransferredBy'];
    ismtcrtrtOEffortInHrs = json['ismtcrtrtO_EffortInHrs'];
    ismtcrtrtOActiveFlg = json['ismtcrtrtO_ActiveFlg'];
    ismtcrtrtOCreatedBy = json['ismtcrtrtO_CreatedBy'];
    ismtcrtrtOUpdatedBy = json['ismtcrtrtO_UpdatedBy'];
    ismtcrreSId = json['ismtcrreS_Id'];
    ismtcrreSResponseDate = json['ismtcrreS_ResponseDate'];
    ismtcrreSActiveFlg = json['ismtcrreS_ActiveFlg'];
    ismtcrreSCreatedBy = json['ismtcrreS_CreatedBy'];
    ismtcrreSUpdatedBy = json['ismtcrreS_UpdatedBy'];
    eachTaskMaxDuration = json['eachTaskMaxDuration'];
    delettask = json['delettask'];
    byMecount = json['byMecount'];
    toMecount = json['toMecount'];
    mycountonly = json['mycountonly'];
    transferMecount = json['transferMecount'];
    transferMecountonly = json['transferMecountonly'];
    transferbycount = json['transferbycount'];
    hrmETo = json['hrmE_To'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['returnval'] = this.returnval;
    data['transfer'] = this.transfer;
    data['already_cnt'] = this.alreadyCnt;
    data['taskeditable'] = this.taskeditable;
    data['assigntaskeditable'] = this.assigntaskeditable;
    data['userId'] = this.userId;
    data['hrmdC_ID'] = this.hrmdCID;
    data['hrmdC_Order'] = this.hrmdCOrder;
    data['ivrmrT_Id'] = this.ivrmrTId;
    data['localIndianTime'] = this.localIndianTime;
    data['ismmaC_Id'] = this.ismmaCId;
    data['mI_Id'] = this.mIId;
    data['asmaY_Id'] = this.asmaYId;
    data['hrmD_Id'] = this.hrmDId;
    data['ismmpR_Id'] = this.ismmpRId;
    data['hrmE_Id'] = this.hrmEId;
    data['ivrmM_Id'] = this.ivrmMId;
    data['ismmmD_Id'] = this.ismmmDId;
    data['ismmmD_ModuleHeadId'] = this.ismmmDModuleHeadId;
    data['ismmclT_Id'] = this.ismmclTId;
    data['ismciM_IEList'] = this.ismciMIEList;
    data['ismmclT_ClientName'] = this.ismmclTClientName;
    data['ismtcR_Id'] = this.ismtcRId;
    data['hrmpR_Id'] = this.hrmpRId;
    data['ismtcR_ReOpenFlg'] = this.ismtcRReOpenFlg;
    data['ismtcR_ActiveFlg'] = this.ismtcRActiveFlg;
    data['taskCount'] = this.taskCount;
    data['openCount'] = this.openCount;
    data['closedCount'] = this.closedCount;
    data['completedCount'] = this.completedCount;
    data['inprogressCount'] = this.inprogressCount;
    data['ismtcrastO_Id'] = this.ismtcrastOId;
    data['ismtcrastO_AssignedDate'] = this.ismtcrastOAssignedDate;
    data['ismtcrastO_AssignedBy'] = this.ismtcrastOAssignedBy;
    data['ismtcrastO_EffortInHrs'] = this.ismtcrastOEffortInHrs;
    data['ismtcrastO_ActiveFlg'] = this.ismtcrastOActiveFlg;
    data['ismtcrtrtO_Id'] = this.ismtcrtrtOId;
    data['ismtcrtrtO_TransferredDate'] = this.ismtcrtrtOTransferredDate;
    data['ismtcrtrtO_TransferredBy'] = this.ismtcrtrtOTransferredBy;
    data['ismtcrtrtO_EffortInHrs'] = this.ismtcrtrtOEffortInHrs;
    data['ismtcrtrtO_ActiveFlg'] = this.ismtcrtrtOActiveFlg;
    data['ismtcrtrtO_CreatedBy'] = this.ismtcrtrtOCreatedBy;
    data['ismtcrtrtO_UpdatedBy'] = this.ismtcrtrtOUpdatedBy;
    data['ismtcrreS_Id'] = this.ismtcrreSId;
    data['ismtcrreS_ResponseDate'] = this.ismtcrreSResponseDate;
    data['ismtcrreS_ActiveFlg'] = this.ismtcrreSActiveFlg;
    data['ismtcrreS_CreatedBy'] = this.ismtcrreSCreatedBy;
    data['ismtcrreS_UpdatedBy'] = this.ismtcrreSUpdatedBy;
    data['eachTaskMaxDuration'] = this.eachTaskMaxDuration;
    data['delettask'] = this.delettask;
    data['byMecount'] = this.byMecount;
    data['toMecount'] = this.toMecount;
    data['mycountonly'] = this.mycountonly;
    data['transferMecount'] = this.transferMecount;
    data['transferMecountonly'] = this.transferMecountonly;
    data['transferbycount'] = this.transferbycount;
    data['hrmE_To'] = this.hrmETo;
    return data;
  }
}


class TaskModuleModel {
  String? type;
  List<TaskModuleModelValues>? values;

  TaskModuleModel({this.type, this.values});

  TaskModuleModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TaskModuleModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new TaskModuleModelValues.fromJson(v));
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

class TaskModuleModelValues {
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
  int? effortinhrs;

  TaskModuleModelValues(
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

  TaskModuleModelValues.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['returnval'] = this.returnval;
    data['roleflag'] = this.roleflag;
    data['completed'] = this.completed;
    data['pending'] = this.pending;
    data['already_cnt'] = this.alreadyCnt;
    data['userId'] = this.userId;
    data['ivrmrT_Id'] = this.ivrmrTId;
    data['plannerextapproval'] = this.plannerextapproval;
    data['plannerMaxdate'] = this.plannerMaxdate;
    data['ismmaC_Id'] = this.ismmaCId;
    data['mI_Id'] = this.mIId;
    data['miId'] = this.miId;
    data['hrmE_Id'] = this.hrmEId;
    data['asmaY_Id'] = this.asmaYId;
    data['hrmD_Id'] = this.hrmDId;
    data['ismmpR_Id'] = this.ismmpRId;
    data['ivrmM_Id'] = this.ivrmMId;
    data['ivrmM_ModuleName'] = this.ivrmMModuleName;
    data['ismmmD_Id'] = this.ismmmDId;
    data['ismmmD_ModuleHeadId'] = this.ismmmDModuleHeadId;
    data['ismtcR_Id'] = this.ismtcRId;
    data['hrmpR_Id'] = this.hrmpRId;
    data['ismmtcaT_Id'] = this.ismmtcaTId;
    data['ismtcR_ReOpenFlg'] = this.ismtcRReOpenFlg;
    data['ismtcR_ActiveFlg'] = this.ismtcRActiveFlg;
    data['ismtcR_CreatedBy'] = this.ismtcRCreatedBy;
    data['ismtcR_UpdatedBy'] = this.ismtcRUpdatedBy;
    data['ismtcrcL_Id'] = this.ismtcrcLId;
    data['ismmclT_Id'] = this.ismmclTId;
    data['ismtcrcL_ActiveFlg'] = this.ismtcrcLActiveFlg;
    data['ismtcrcL_CreatedBy'] = this.ismtcrcLCreatedBy;
    data['ismtcrcL_UpdatedBy'] = this.ismtcrcLUpdatedBy;
    data['ismtcraT_Id'] = this.ismtcraTId;
    data['ismtcraT_ActiveFlg'] = this.ismtcraTActiveFlg;
    data['ismtcraT_CreatedBy'] = this.ismtcraTCreatedBy;
    data['ismtcraT_UpdatedBy'] = this.ismtcraTUpdatedBy;
    data['prioritycheck'] = this.prioritycheck;
    data['ismciM_IEList'] = this.ismciMIEList;
    data['effortinhrs'] = this.effortinhrs;
    return data;
  }
}
