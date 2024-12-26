// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationRequest _$StationRequestFromJson(Map<String, dynamic> json) =>
    StationRequest(
      id: (json['id'] as num?)?.toInt(),
      stationId: (json['station_id'] as num?)?.toInt(),
      stationName: json['station_name'] as String?,
      requestTypeId: (json['request_type_id'] as num?)?.toInt(),
      requestTypeName: json['request_type_name'] as String?,
      description: json['description'] as String?,
      statusId: (json['status_id'] as num?)?.toInt(),
      statusName: json['status_name'] as String?,
      resolutionNotes: json['resolution_notes'] as String?,
      resolvedByUserId: (json['resolved_by_user_id'] as num?)?.toInt(),
      resolvedByUserName: json['resolved_by_user_name'] as String?,
      resolvedAt: json['resolved_at'] as String?,
      createdByUserId: (json['created_by_user_id'] as num?)?.toInt(),
      createdByUserName: json['created_by_user_name'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StationRequestToJson(StationRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'station_id': instance.stationId,
      'station_name': instance.stationName,
      'request_type_id': instance.requestTypeId,
      'request_type_name': instance.requestTypeName,
      'description': instance.description,
      'status_id': instance.statusId,
      'status_name': instance.statusName,
      'resolution_notes': instance.resolutionNotes,
      'resolved_by_user_id': instance.resolvedByUserId,
      'resolved_by_user_name': instance.resolvedByUserName,
      'resolved_at': instance.resolvedAt,
      'created_by_user_id': instance.createdByUserId,
      'created_by_user_name': instance.createdByUserName,
      'created_at': instance.createdAt?.toIso8601String(),
      'attachments': instance.attachments,
    };

Attachment _$AttachmentFromJson(Map<String, dynamic> json) => Attachment(
      requestId: (json['request_id'] as num?)?.toInt(),
      mediaId: (json['media_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AttachmentToJson(Attachment instance) =>
    <String, dynamic>{
      'request_id': instance.requestId,
      'media_id': instance.mediaId,
    };
