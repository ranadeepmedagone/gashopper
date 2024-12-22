import 'package:json_annotation/json_annotation.dart';

part "cash_drop.g.dart";

@JsonSerializable()
class CashDrop {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "station_id")
  final int? stationId;

  @JsonKey(name: "amount")
  final int? amount;

  @JsonKey(name: "price_unit_id")
  final int? priceUnitId;

  @JsonKey(name: "description")
  final String? description;

  @JsonKey(name: "created_by_user_id")
  final int? createdByUserId;

  @JsonKey(name: "created_at")
  final String? createdAt;

  @JsonKey(name: "updated_at")
  final String? updatedAt;

  CashDrop({
    this.id,
    this.stationId,
    this.amount,
    this.priceUnitId,
    this.description,
    this.createdByUserId,
    this.createdAt,
    this.updatedAt,
  });

  factory CashDrop.fromJson(Map<String, dynamic> json) {
    return _$CashDropFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CashDropToJson(this);
}
