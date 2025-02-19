// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_shift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserShift _$UserShiftFromJson(Map<String, dynamic> json) => UserShift(
      id: (json['id'] as num?)?.toInt(),
      startTime: json['start_time'] == null
          ? null
          : DateTime.parse(json['start_time'] as String),
      endTime: json['end_time'] == null
          ? null
          : DateTime.parse(json['end_time'] as String),
      stationId: (json['station_id'] as num?)?.toInt(),
      stationName: json['station_name'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      userName: json['user_name'] as String?,
      createdByUserId: (json['created_by_user_id'] as num?)?.toInt(),
      createdByUserName: json['created_by_user_name'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      updatedByUserId: (json['updated_by_user_id'] as num?)?.toInt(),
      updatedByUserName: json['updated_by_user_name'] as String?,
      totalWorkingHours: json['total_working_hours'] as String?,
    );

Map<String, dynamic> _$UserShiftToJson(UserShift instance) => <String, dynamic>{
      'id': instance.id,
      'start_time': instance.startTime?.toIso8601String(),
      'end_time': instance.endTime?.toIso8601String(),
      'station_id': instance.stationId,
      'station_name': instance.stationName,
      'user_id': instance.userId,
      'user_name': instance.userName,
      'created_by_user_id': instance.createdByUserId,
      'created_by_user_name': instance.createdByUserName,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'updated_by_user_id': instance.updatedByUserId,
      'updated_by_user_name': instance.updatedByUserName,
      'total_working_hours': instance.totalWorkingHours,
    };
