import 'package:json_annotation/json_annotation.dart';

part "station_request.g.dart";

@JsonSerializable()
class StationRequest {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "station_id")
  final int? stationId;

  @JsonKey(name: "station_name")
  final String? stationName;

  @JsonKey(name: "request_type_id")
  final int? requestTypeId;

  @JsonKey(name: "request_type_name")
  final String? requestTypeName;

  @JsonKey(name: "description")
  final String? description;

  @JsonKey(name: "status_id")
  final int? statusId;

  @JsonKey(name: "status_name")
  final String? statusName;

  @JsonKey(name: "resolution_notes")
  final String? resolutionNotes;

  @JsonKey(name: "resolved_by_user_id")
  final int? resolvedByUserId;

  @JsonKey(name: "resolved_by_user_name")
  final String? resolvedByUserName;

  @JsonKey(name: "resolved_at")
  final String? resolvedAt;

  @JsonKey(name: "created_by_user_id")
  final int? createdByUserId;

  @JsonKey(name: "created_by_user_name")
  final String? createdByUserName;

  @JsonKey(name: "created_at")
  final DateTime? createdAt;

  @JsonKey(name: "attachments")
  final List<Attachment>? attachments;

  StationRequest({
    this.id,
    this.stationId,
    this.stationName,
    this.requestTypeId,
    this.requestTypeName,
    this.description,
    this.statusId,
    this.statusName,
    this.resolutionNotes,
    this.resolvedByUserId,
    this.resolvedByUserName,
    this.resolvedAt,
    this.createdByUserId,
    this.createdByUserName,
    this.createdAt,
    this.attachments,
  });

  factory StationRequest.fromJson(Map<String, dynamic> json) {
    return _$StationRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StationRequestToJson(this);
}

@JsonSerializable()
class Attachment {
  @JsonKey(name: "request_id")
  final int? requestId;

  @JsonKey(name: "media_id")
  final int? mediaId;

  Attachment({
    this.requestId,
    this.mediaId,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return _$AttachmentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}
