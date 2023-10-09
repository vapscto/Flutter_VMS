class GpsResult {
  String? formatted;

  GpsResult({this.formatted});

  GpsResult.fromJson(Map<String, dynamic> json) {
    formatted = json['formatted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formatted'] = this.formatted;
    return data;
  }
}