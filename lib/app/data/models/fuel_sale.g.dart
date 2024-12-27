// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FuelSale _$FuelSaleFromJson(Map<String, dynamic> json) => FuelSale(
      fuelTypeId: (json['fuel_type_id'] as num?)?.toInt(),
      addedAmount: (json['added_amount'] as num?)?.toInt(),
      paymentTypeId: (json['payment_type_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FuelSaleToJson(FuelSale instance) => <String, dynamic>{
      'fuel_type_id': instance.fuelTypeId,
      'added_amount': instance.addedAmount,
      'payment_type_id': instance.paymentTypeId,
    };
