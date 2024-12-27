import 'package:json_annotation/json_annotation.dart';

part "fuel_sale.g.dart";

@JsonSerializable()
class FuelSale {
  @JsonKey(name: "fuel_type_id")
  final int? fuelTypeId;

  @JsonKey(name: "added_amount")
  final int? addedAmount;

  @JsonKey(name: "payment_type_id")
  final int? paymentTypeId;

  FuelSale({
    this.fuelTypeId,
    this.addedAmount,
    this.paymentTypeId,
  });

  factory FuelSale.fromJson(Map<String, dynamic> json) {
    return _$FuelSaleFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FuelSaleToJson(this);
}
