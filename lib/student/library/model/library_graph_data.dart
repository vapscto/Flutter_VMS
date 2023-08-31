// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FullLibGraphData {
  final LibraryGraphDataIssued issuedData;
  final LibraryGraphDataRetured returnedData;
  FullLibGraphData({
    required this.issuedData,
    required this.returnedData,
  });

  FullLibGraphData copyWith({
    LibraryGraphDataIssued? issuedData,
    LibraryGraphDataRetured? returnedData,
  }) {
    return FullLibGraphData(
      issuedData: issuedData ?? this.issuedData,
      returnedData: returnedData ?? this.returnedData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'issuedData': issuedData.toMap(),
      'returnedData': returnedData.toMap(),
    };
  }

  factory FullLibGraphData.fromMap(Map<String, dynamic> map) {
    return FullLibGraphData(
      issuedData: LibraryGraphDataIssued.fromMap(
          map['issuedData'] as Map<String, dynamic>),
      returnedData: LibraryGraphDataRetured.fromMap(
          map['returnedData'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory FullLibGraphData.fromJson(String source) =>
      FullLibGraphData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FullLibGraphData(issuedData: $issuedData, returnedData: $returnedData)';

  @override
  bool operator ==(covariant FullLibGraphData other) {
    if (identical(this, other)) return true;

    return other.issuedData == issuedData && other.returnedData == returnedData;
  }

  @override
  int get hashCode => issuedData.hashCode ^ returnedData.hashCode;
}

class LibraryGraphDataIssued {
  final String month;
  final int issued;
  LibraryGraphDataIssued({
    required this.month,
    required this.issued,
  });

  LibraryGraphDataIssued copyWith({
    String? month,
    int? issued,
  }) {
    return LibraryGraphDataIssued(
      month: month ?? this.month,
      issued: issued ?? this.issued,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'month': month,
      'issued': issued,
    };
  }

  factory LibraryGraphDataIssued.fromMap(Map<String, dynamic> map) {
    return LibraryGraphDataIssued(
      month: map['month'] as String,
      issued: map['issued'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LibraryGraphDataIssued.fromJson(String source) =>
      LibraryGraphDataIssued.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LibraryGraphDataIssued(month: $month, issued: $issued)';

  @override
  bool operator ==(covariant LibraryGraphDataIssued other) {
    if (identical(this, other)) return true;

    return other.month == month && other.issued == issued;
  }

  @override
  int get hashCode => month.hashCode ^ issued.hashCode;
}

class LibraryGraphDataRetured {
  final String month;
  final int returned;
  LibraryGraphDataRetured({
    required this.month,
    required this.returned,
  });

  LibraryGraphDataRetured copyWith({
    String? month,
    int? returned,
  }) {
    return LibraryGraphDataRetured(
      month: month ?? this.month,
      returned: returned ?? this.returned,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'month': month,
      'returned': returned,
    };
  }

  factory LibraryGraphDataRetured.fromMap(Map<String, dynamic> map) {
    return LibraryGraphDataRetured(
      month: map['month'] as String,
      returned: map['returned'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LibraryGraphDataRetured.fromJson(String source) =>
      LibraryGraphDataRetured.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LibraryGraphDataRetured(month: $month, returned: $returned)';

  @override
  bool operator ==(covariant LibraryGraphDataRetured other) {
    if (identical(this, other)) return true;

    return other.month == month && other.returned == returned;
  }

  @override
  int get hashCode => month.hashCode ^ returned.hashCode;
}
