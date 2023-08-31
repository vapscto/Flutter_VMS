class LibraryGraph {
  String? type;
  List<LibraryGraphValues>? values;

  LibraryGraph({this.type, this.values});

  LibraryGraph.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <LibraryGraphValues>[];
      json['\$values'].forEach((v) {
        values!.add(LibraryGraphValues.fromJson(v));
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

class LibraryGraphValues {
  String? type;
  String? mONTHNAME;
  int? iSSUEDCOUNT;
  int? rETURNCOUNT;

  LibraryGraphValues(
      {this.type, this.mONTHNAME, this.iSSUEDCOUNT, this.rETURNCOUNT});

  LibraryGraphValues.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    mONTHNAME = json['MONTHNAME'];
    iSSUEDCOUNT = json['ISSUEDCOUNT'];
    rETURNCOUNT = json['RETURNCOUNT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    data['MONTHNAME'] = mONTHNAME;
    data['ISSUEDCOUNT'] = iSSUEDCOUNT;
    data['RETURNCOUNT'] = rETURNCOUNT;
    return data;
  }
}
