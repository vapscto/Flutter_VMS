// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:m_skool_flutter/student/certificates/model/cert_list_model.dart';

class CertListAsca {
  final int ascaId;
  final CertificateList certificateList;
  CertListAsca({
    required this.ascaId,
    required this.certificateList,
  });

  CertListAsca copyWith({
    int? ascaId,
    CertificateList? certificateList,
  }) {
    return CertListAsca(
      ascaId: ascaId ?? this.ascaId,
      certificateList: certificateList ?? this.certificateList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ascaId': ascaId,
      'certificateList': certificateList.toJson(),
    };
  }

  factory CertListAsca.fromMap(Map<String, dynamic> map) {
    return CertListAsca(
      ascaId: map['ascaId'] as int,
      certificateList: CertificateList.fromJson(
          map['certificateList'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CertListAsca.fromJson(String source) =>
      CertListAsca.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CertListAsca(ascaId: $ascaId, certificateList: $certificateList)';

  @override
  bool operator ==(covariant CertListAsca other) {
    if (identical(this, other)) return true;

    return other.ascaId == ascaId && other.certificateList == certificateList;
  }

  @override
  int get hashCode => ascaId.hashCode ^ certificateList.hashCode;
}
