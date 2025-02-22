import 'package:json_annotation/json_annotation.dart';

part "user_shift.g.dart";

@JsonSerializable()
class UserShift {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "start_time")
  final DateTime? startTime;

  @JsonKey(name: "end_time")
  final DateTime? endTime;

  @JsonKey(name: "station_id")
  final int? stationId;

  @JsonKey(name: "station_name")
  final String? stationName;

  @JsonKey(name: "user_id")
  final int? userId;

  @JsonKey(name: "user_name")
  final String? userName;

  @JsonKey(name: "created_by_user_id")
  final int? createdByUserId;

  @JsonKey(name: "created_by_user_name")
  final String? createdByUserName;

  @JsonKey(name: "created_at")
  final DateTime? createdAt;

  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  @JsonKey(name: "updated_by_user_id")
  final int? updatedByUserId;

  @JsonKey(name: "updated_by_user_name")
  final String? updatedByUserName;

  @JsonKey(name: "total_working_hours")
  final String? totalWorkingHours;

  UserShift({
    this.id,
    this.startTime,
    this.endTime,
    this.stationId,
    this.stationName,
    this.userId,
    this.userName,
    this.createdByUserId,
    this.createdByUserName,
    this.createdAt,
    this.updatedAt,
    this.updatedByUserId,
    this.updatedByUserName,
    this.totalWorkingHours,
  });

  factory UserShift.fromJson(Map<String, dynamic> json) {
    return _$UserShiftFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserShiftToJson(this);
}
