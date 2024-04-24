class TadaClientSources {
  String? type;
  List<TadaClientSourcesValues>? values;

  TadaClientSources({this.type, this.values});

  TadaClientSources.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    if (json['\$values'] != null) {
      values = <TadaClientSourcesValues>[];
      json['\$values'].forEach((v) {
        values!.add(TadaClientSourcesValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TadaClientSourcesValues {
  String? type;
  String? iSMSMSOSourceName;
  int? closure;
  int? cold;
  int? followUp;
  int? hOT;

  TadaClientSourcesValues(
      {this.type,
      this.iSMSMSOSourceName,
      this.closure,
      this.cold,
      this.followUp,
      this.hOT});

  TadaClientSourcesValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    iSMSMSOSourceName = json['ISMSMSO_SourceName'];
    closure = json['Closure'];
    cold = json['Cold'];
    followUp = json['Follow Up'];
    hOT = json['HOT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ISMSMSO_SourceName'] = iSMSMSOSourceName;
    data['Closure'] = closure;
    data['Cold'] = cold;
    data['Follow Up'] = followUp;
    data['HOT'] = hOT;
    return data;
  }
}
