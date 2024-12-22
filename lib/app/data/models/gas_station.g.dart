// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gas_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GasStation _$GasStationFromJson(Map<String, dynamic> json) => GasStation(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      address: json['address'] as String?,
      contactNumber: (json['contact_number'] as num?)?.toInt(),
      operatingHours: (json['operating_hours'] as num?)?.toInt(),
      createdByUserId: (json['created_by_user_id'] as num?)?.toInt(),
      createdByUserName: json['created_by_user_name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$GasStationToJson(GasStation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'contact_number': instance.contactNumber,
      'operating_hours': instance.operatingHours,
      'created_by_user_id': instance.createdByUserId,
      'created_by_user_name': instance.createdByUserName,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
