class ModalViewPcReqModel {
  String? type;
  List<ModalViewPcReqModelValues>? values;

  ModalViewPcReqModel({this.type, this.values});

  ModalViewPcReqModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ModalViewPcReqModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ModalViewPcReqModelValues.fromJson(v));
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

class ModalViewPcReqModelValues {
  String? type;
  String? firstApprovalRemark;
  double? firstApprovalAmount;
  String? firstApprovalDate;
  String? secondApprovalRemark;
  double? secondApprovalAmount;
  String? secondApprovalDate;
  String? firstApprovalperson;
  String? secondApprovalperson;

  ModalViewPcReqModelValues(
      {this.type,
      this.firstApprovalRemark,
      this.firstApprovalAmount,
      this.firstApprovalDate,
      this.secondApprovalRemark,
      this.secondApprovalAmount,
      this.secondApprovalDate,
      this.firstApprovalperson,
      this.secondApprovalperson});

  ModalViewPcReqModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    firstApprovalRemark = json['FirstApproval_remark'];
    firstApprovalAmount = json['First_ApprovalAmount'];
    firstApprovalDate = json['first_approval_date'];
    secondApprovalRemark = json['SecondApproval_remark'];
    secondApprovalAmount = json['Second_ApprovalAmount'];
    secondApprovalDate = json['second_approval_date'];
    firstApprovalperson = json['First_Approvalperson'];
    secondApprovalperson = json['Second_Approvalperson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['FirstApproval_remark'] = firstApprovalRemark;
    data['First_ApprovalAmount'] = firstApprovalAmount;
    data['first_approval_date'] = firstApprovalDate;
    data['SecondApproval_remark'] = secondApprovalRemark;
    data['Second_ApprovalAmount'] = secondApprovalAmount;
    data['second_approval_date'] = secondApprovalDate;
    data['First_Approvalperson'] = firstApprovalperson;
    data['Second_Approvalperson'] = secondApprovalperson;
    return data;
  }
}
