import 'package:json_annotation/json_annotation.dart';

part "gas_station.g.dart";

@JsonSerializable()
class GasStation {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "latitude")
  final double? latitude;

  @JsonKey(name: "longitude")
  final double? longitude;

  @JsonKey(name: "address")
  final String? address;

  @JsonKey(name: "contact_number")
  final int? contactNumber;

  @JsonKey(name: "operating_hours")
  final int? operatingHours;

  @JsonKey(name: "created_by_user_id")
  final int? createdByUserId;

  @JsonKey(name: "created_by_user_name")
  final String? createdByUserName;

  @JsonKey(name: "created_at")
  final String? createdAt;

  @JsonKey(name: "updated_at")
  final String? updatedAt;

  GasStation({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.address,
    this.contactNumber,
    this.operatingHours,
    this.createdByUserId,
    this.createdByUserName,
    this.createdAt,
    this.updatedAt,
  });

  factory GasStation.fromJson(Map<String, dynamic> json) {
    return _$GasStationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GasStationToJson(this);
}
