// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_drop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashDrop _$CashDropFromJson(Map<String, dynamic> json) => CashDrop(
      id: (json['id'] as num?)?.toInt(),
      stationId: (json['station_id'] as num?)?.toInt(),
      amount: (json['amount'] as num?)?.toInt(),
      priceUnitId: (json['price_unit_id'] as num?)?.toInt(),
      description: json['description'] as String?,
      createdByUserId: (json['created_by_user_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$CashDropToJson(CashDrop instance) => <String, dynamic>{
      'id': instance.id,
      'station_id': instance.stationId,
      'amount': instance.amount,
      'price_unit_id': instance.priceUnitId,
      'description': instance.description,
      'created_by_user_id': instance.createdByUserId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
