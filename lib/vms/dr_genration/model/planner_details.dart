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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['asmaY_Id'] = this.asmaYId;
    data['roleId'] = this.roleId;
    data['returnval'] = this.returnval;
    data['plannername'] = this.plannername;
    data['plannerlength'] = this.plannerlength;
    data['dailyreportcount'] = this.dailyreportcount;
    data['dailyreportothersdatecount'] = this.dailyreportothersdatecount;
    data['dailyreportblockedcount'] = this.dailyreportblockedcount;
    data['approvalflag'] = this.approvalflag;
    data['othersdayenable'] = this.othersdayenable;
    return data;
  }
}
