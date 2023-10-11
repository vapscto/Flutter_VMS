class TotalEffortData {
  String? type;
  List<TotalEffortDataValues>? values;

  TotalEffortData({this.type, this.values});

  TotalEffortData.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TotalEffortDataValues>[];
      json['\$values'].forEach((v) {
        values!.add(TotalEffortDataValues.fromJson(v));
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

class TotalEffortDataValues {
  String? type;
  double? nOOFDAYS;
  double? wORKINGHOURS;
  String? dayName;
  String? pDates;

  TotalEffortDataValues(
      {this.type, this.nOOFDAYS, this.wORKINGHOURS, this.dayName, this.pDates});

  TotalEffortDataValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    nOOFDAYS = json['NOOFDAYS'];
    wORKINGHOURS = json['WORKINGHOURS'];
    dayName = json['DayName'];
    pDates = json['PDates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    data['NOOFDAYS'] = nOOFDAYS;
    data['WORKINGHOURS'] = wORKINGHOURS;
    data['DayName'] = dayName;
    data['PDates'] = pDates;
    return data;
  }
}
