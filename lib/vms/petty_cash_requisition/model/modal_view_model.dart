class ModalViewPcReqModel {
  String? type;
  List<ModalViewPcReqModelValues>? values;

  ModalViewPcReqModel({this.type, this.values});

  ModalViewPcReqModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ModalViewPcReqModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(new ModalViewPcReqModelValues.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$type'] = this.type;
    data['FirstApproval_remark'] = this.firstApprovalRemark;
    data['First_ApprovalAmount'] = this.firstApprovalAmount;
    data['first_approval_date'] = this.firstApprovalDate;
    data['SecondApproval_remark'] = this.secondApprovalRemark;
    data['Second_ApprovalAmount'] = this.secondApprovalAmount;
    data['second_approval_date'] = this.secondApprovalDate;
    data['First_Approvalperson'] = this.firstApprovalperson;
    data['Second_Approvalperson'] = this.secondApprovalperson;
    return data;
  }
}
