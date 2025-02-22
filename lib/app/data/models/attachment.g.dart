// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attachments _$AttachmentsFromJson(Map<String, dynamic> json) => Attachments(
      id: (json['id'] as num?)?.toInt(),
      fileName: json['file_name'] as String?,
      originalFileName: json['original_file_name'] as String?,
      filePath: json['file_path'] as String?,
      contentType: json['content_type'] as String?,
      fileSize: (json['file_size'] as num?)?.toInt(),
      uploadAt: json['upload_at'] == null
          ? null
          : DateTime.parse(json['upload_at'] as String),
      uploadedByUserId: (json['uploaded_by_user_id'] as num?)?.toInt(),
      uploadedByUserName: json['uploaded_by_user_name'] as String?,
    );

Map<String, dynamic> _$AttachmentsToJson(Attachments instance) =>
    <String, dynamic>{
      'id': instance.id,
      'file_name': instance.fileName,
      'original_file_name': instance.originalFileName,
      'file_path': instance.filePath,
      'content_type': instance.contentType,
      'file_size': instance.fileSize,
      'upload_at': instance.uploadAt?.toIso8601String(),
      'uploaded_by_user_id': instance.uploadedByUserId,
      'uploaded_by_user_name': instance.uploadedByUserName,
    };
