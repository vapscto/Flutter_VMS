class PlannerApproval {
  bool? plannerextapproval;

  PlannerApproval({this.plannerextapproval});

  PlannerApproval.fromJson(Map<String, dynamic> json) {
    plannerextapproval = json['plannerextapproval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plannerextapproval'] = plannerextapproval;
    return data;
  }
}
