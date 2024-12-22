import 'package:json_annotation/json_annotation.dart';

part "app_inputs.g.dart";

@JsonSerializable()
class AppInputs {
  @JsonKey(name: "fuel_types")
  final List<IdNameRecord>? fuelTypes;

  @JsonKey(name: "request_types")
  final List<IdNameRecord>? requestTypes;

  @JsonKey(name: "request_statuses")
  final List<IdNameRecord>? requestStatuses;

  @JsonKey(name: "payment_types")
  final List<IdNameRecord>? paymenTypes;

  AppInputs({
    this.fuelTypes,
    this.requestTypes,
    this.requestStatuses,
    this.paymenTypes,
  });

  factory AppInputs.fromJson(Map<String, dynamic> json) {
    return _$AppInputsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AppInputsToJson(this);
}

@JsonSerializable()
class IdNameRecord {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name")
  final String? name;

  IdNameRecord({
    this.id,
    this.name,
  });

  factory IdNameRecord.fromJson(Map<String, dynamic> json) {
    return _$IdNameRecordFromJson(json);
  }

  Map<String, dynamic> toJson() => _$IdNameRecordToJson(this);
}
