// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_inputs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppInputs _$AppInputsFromJson(Map<String, dynamic> json) => AppInputs(
      fuelTypes: (json['fuel_types'] as List<dynamic>?)
          ?.map((e) => IdNameRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      requestTypes: (json['request_types'] as List<dynamic>?)
          ?.map((e) => IdNameRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      requestStatuses: (json['request_statuses'] as List<dynamic>?)
          ?.map((e) => IdNameRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymenTypes: (json['payment_types'] as List<dynamic>?)
          ?.map((e) => IdNameRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppInputsToJson(AppInputs instance) => <String, dynamic>{
      'fuel_types': instance.fuelTypes,
      'request_types': instance.requestTypes,
      'request_statuses': instance.requestStatuses,
      'payment_types': instance.paymenTypes,
    };

IdNameRecord _$IdNameRecordFromJson(Map<String, dynamic> json) => IdNameRecord(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$IdNameRecordToJson(IdNameRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
