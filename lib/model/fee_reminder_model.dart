class FeeReminderModel {
  String? type;
  List<FeeReminderModelValues>? values;

  FeeReminderModel({this.type, this.values});

  FeeReminderModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <FeeReminderModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(FeeReminderModelValues.fromJson(v));
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

class FeeReminderModelValues {
  String? type;
  String? tERMNAME;
  int? tobePaid;
  String? dUEDATE;
  int? fINE;

  FeeReminderModelValues(
      {this.type, this.tERMNAME, this.tobePaid, this.dUEDATE, this.fINE});

  FeeReminderModelValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    tERMNAME = json['TERMNAME'];
    tobePaid = json['TobePaid'];
    dUEDATE = json['DUEDATE'];
    fINE = json['FINE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    data['TERMNAME'] = tERMNAME;
    data['TobePaid'] = tobePaid;
    data['DUEDATE'] = dUEDATE;
    data['FINE'] = fINE;
    return data;
  }
}
