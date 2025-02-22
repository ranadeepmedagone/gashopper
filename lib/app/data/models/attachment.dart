import 'package:json_annotation/json_annotation.dart';

part "attachment.g.dart";

@JsonSerializable()
class Attachments {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "file_name")
  final String? fileName;

  @JsonKey(name: "original_file_name")
  final String? originalFileName;

  @JsonKey(name: "file_path")
  final String? filePath;

  @JsonKey(name: "content_type")
  final String? contentType;

  @JsonKey(name: "file_size")
  final int? fileSize;

  @JsonKey(name: "upload_at")
  final DateTime? uploadAt;

  @JsonKey(name: "uploaded_by_user_id")
  final int? uploadedByUserId;

  @JsonKey(name: "uploaded_by_user_name")
  final String? uploadedByUserName;

  Attachments({
    this.id,
    this.fileName,
    this.originalFileName,
    this.filePath,
    this.contentType,
    this.fileSize,
    this.uploadAt,
    this.uploadedByUserId,
    this.uploadedByUserName,
  });

  factory Attachments.fromJson(Map<String, dynamic> json) {
    return _$AttachmentsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AttachmentsToJson(this);
}
