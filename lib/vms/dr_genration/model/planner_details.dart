class PlanerDeatails {
  int? userId;
  int? asmaYId;
  int? roleId;
  bool? returnval;
  String? plannername;
  int? plannerlength;
  double? dailyreportcount;
  double? dailyreportothersdatecount;
  double? dailyreportblockedcount;
  bool? approvalflag;
  bool? othersdayenable;

  PlanerDeatails(
      {this.userId,
      this.asmaYId,
      this.roleId,
      this.returnval,
      this.plannername,
      this.plannerlength,
      this.dailyreportcount,
      this.dailyreportothersdatecount,
      this.dailyreportblockedcount,
      this.approvalflag,
      this.othersdayenable});

  PlanerDeatails.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    asmaYId = json['asmaY_Id'];
    roleId = json['roleId'];
    returnval = json['returnval'];
    plannername = json['plannername'];
    plannerlength = json['plannerlength'];
    dailyreportcount = json['dailyreportcount'];
    dailyreportothersdatecount = json['dailyreportothersdatecount'];
    dailyreportblockedcount = json['dailyreportblockedcount'];
    approvalflag = json['approvalflag'];
    othersdayenable = json['othersdayenable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['asmaY_Id'] = asmaYId;
    data['roleId'] = roleId;
    data['returnval'] = returnval;
    data['plannername'] = plannername;
    data['plannerlength'] = plannerlength;
    data['dailyreportcount'] = dailyreportcount;
    data['dailyreportothersdatecount'] = dailyreportothersdatecount;
    data['dailyreportblockedcount'] = dailyreportblockedcount;
    data['approvalflag'] = approvalflag;
    data['othersdayenable'] = othersdayenable;
    return data;
  }
}
