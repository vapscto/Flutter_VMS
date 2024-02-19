class NocApprovalChekListModel {
  String? type;
  List<NocApprovalChekListModelValues>? values;

  NocApprovalChekListModel({this.type, this.values});

  NocApprovalChekListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <NocApprovalChekListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(NocApprovalChekListModelValues.fromJson(v));
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

class NocApprovalChekListModelValues {
  String? type;
  int? iSMRESGMCLId;
  String? iSMRESGMCLCheckListName;
  String? remarks;

  NocApprovalChekListModelValues(
      {this.type,
      this.iSMRESGMCLId,
      this.iSMRESGMCLCheckListName,
      this.remarks});

  NocApprovalChekListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMRESGMCLId = json['ISMRESGMCL_Id'];
    iSMRESGMCLCheckListName = json['ISMRESGMCL_CheckListName'];
    remarks = json['Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMRESGMCL_Id'] = iSMRESGMCLId;
    data['ISMRESGMCL_CheckListName'] = iSMRESGMCLCheckListName;
    data['Remarks'] = remarks;
    return data;
  }
}
