// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:m_skool_flutter/student/fees/apis/payment_gateway_model.dart';
import 'package:m_skool_flutter/student/fees/model/custom_grp_list.dart';
import 'package:m_skool_flutter/student/fees/model/disable_terms_model.dart';

class InstallmentModel {
  final List<PaymentGatewayDetailsValues> gateway;
  final CustomgGrplistValues grplistValues;
  final List<DisableTermsModelValues> disableTermsModelValues;
  InstallmentModel({
    required this.gateway,
    required this.grplistValues,
    required this.disableTermsModelValues,
  });

  InstallmentModel copyWith({
    CustomgGrplistValues? grplistValues,
    List<PaymentGatewayDetailsValues>? gateway,
    List<DisableTermsModelValues>? disableTermsModelValues,
  }) {
    return InstallmentModel(
      gateway: gateway ?? this.gateway,
      grplistValues: grplistValues ?? this.grplistValues,
      disableTermsModelValues:
          disableTermsModelValues ?? this.disableTermsModelValues,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'grplistValues': grplistValues.toJson(),
      'disableTermsModelValues':
          disableTermsModelValues.map((x) => x.toJson()).toList(),
    };
  }

  factory InstallmentModel.fromMap(Map<String, dynamic> map) {
    return InstallmentModel(
      gateway: List<PaymentGatewayDetailsValues>.from((map['gateWay']
              as List<dynamic>)
          .map<PaymentGatewayDetailsValues>((x) =>
              PaymentGatewayDetailsValues.fromJson(x as Map<String, dynamic>))),
      grplistValues: CustomgGrplistValues.fromJson(
          map['grplistValues'] as Map<String, dynamic>),
      disableTermsModelValues: List<DisableTermsModelValues>.from(
        (map['disableTermsModelValues'] as List<dynamic>)
            .map<DisableTermsModelValues>(
          (x) => DisableTermsModelValues.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory InstallmentModel.fromJson(String source) =>
      InstallmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'InstallmentModel(grplistValues: $grplistValues, disableTermsModelValues: $disableTermsModelValues)';

  @override
  bool operator ==(covariant InstallmentModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.grplistValues == grplistValues &&
        listEquals(other.disableTermsModelValues, disableTermsModelValues);
  }

  @override
  int get hashCode => grplistValues.hashCode ^ disableTermsModelValues.hashCode;
}
