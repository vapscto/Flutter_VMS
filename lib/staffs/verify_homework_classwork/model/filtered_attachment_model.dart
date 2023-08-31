// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class FilteredAttachment {
  final int amstId;
  final List<Map<String, dynamic>> attachments;
  FilteredAttachment({
    required this.amstId,
    required this.attachments,
  });

  FilteredAttachment copyWith({
    int? amstId,
    List<Map<String, dynamic>>? attachments,
  }) {
    return FilteredAttachment(
      amstId: amstId ?? this.amstId,
      attachments: attachments ?? this.attachments,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amstId': amstId,
      'attachments': attachments,
    };
  }

  factory FilteredAttachment.fromMap(Map<String, dynamic> map) {
    return FilteredAttachment(
      amstId: map['amstId'] as int,
      attachments: List<Map<String, dynamic>>.from(
        (map['attachments'] as List<Map<String, dynamic>>)
            .map<Map<String, dynamic>>(
          (x) => x,
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FilteredAttachment.fromJson(String source) =>
      FilteredAttachment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FilteredAttachment(amstId: $amstId, attachments: $attachments)';

  @override
  bool operator ==(covariant FilteredAttachment other) {
    if (identical(this, other)) return true;

    return other.amstId == amstId && listEquals(other.attachments, attachments);
  }

  @override
  int get hashCode => amstId.hashCode ^ attachments.hashCode;
}
