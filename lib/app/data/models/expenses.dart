import 'package:json_annotation/json_annotation.dart';

part "expenses.g.dart";

@JsonSerializable()
class Expenses {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "station_id")
  final int? stationId;

  @JsonKey(name: "station_name")
  final String? stationName;

  @JsonKey(name: "description")
  final String? description;

  @JsonKey(name: "added_amount")
  final int? addedAmount;

  @JsonKey(name: "payment_type_id")
  final int? paymentTypeId;

  @JsonKey(name: "payment_name")
  final String? paymentName;

  @JsonKey(name: "created_by_user_id")
  final int? createdByUserId;

  @JsonKey(name: "created_at")
  final DateTime? createdAt;

  @JsonKey(name: "created_by_user_name")
  final String? createdByUserName;

  @JsonKey(name: "updated_by_user_id")
  final int? updatedByUserId;

  @JsonKey(name: "updated_by_user_name")
  final String? updatedByUserName;

  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  Expenses({
    this.id,
    this.stationId,
    this.stationName,
    this.description,
    this.addedAmount,
    this.paymentTypeId,
    this.paymentName,
    this.createdByUserId,
    this.createdAt,
    this.createdByUserName,
    this.updatedByUserId,
    this.updatedByUserName,
    this.updatedAt,
  });

  factory Expenses.fromJson(Map<String, dynamic> json) {
    return _$ExpensesFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ExpensesToJson(this);
}
