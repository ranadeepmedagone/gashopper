// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expenses _$ExpensesFromJson(Map<String, dynamic> json) => Expenses(
      id: (json['id'] as num?)?.toInt(),
      stationId: (json['station_id'] as num?)?.toInt(),
      stationName: json['station_name'] as String?,
      description: json['description'] as String?,
      addedAmount: (json['added_amount'] as num?)?.toInt(),
      paymentTypeId: (json['payment_type_id'] as num?)?.toInt(),
      paymentName: json['payment_name'] as String?,
      createdByUserId: (json['created_by_user_id'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      createdByUserName: json['created_by_user_name'] as String?,
      updatedByUserId: (json['updated_by_user_id'] as num?)?.toInt(),
      updatedByUserName: json['updated_by_user_name'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ExpensesToJson(Expenses instance) => <String, dynamic>{
      'id': instance.id,
      'station_id': instance.stationId,
      'station_name': instance.stationName,
      'description': instance.description,
      'added_amount': instance.addedAmount,
      'payment_type_id': instance.paymentTypeId,
      'payment_name': instance.paymentName,
      'created_by_user_id': instance.createdByUserId,
      'created_at': instance.createdAt?.toIso8601String(),
      'created_by_user_name': instance.createdByUserName,
      'updated_by_user_id': instance.updatedByUserId,
      'updated_by_user_name': instance.updatedByUserName,
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
