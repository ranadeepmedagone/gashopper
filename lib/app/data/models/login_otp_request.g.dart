// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginOTPRequest _$LoginOTPRequestFromJson(Map<String, dynamic> json) =>
    LoginOTPRequest(
      referenceNumber: json['reference_number'] as String?,
    );

Map<String, dynamic> _$LoginOTPRequestToJson(LoginOTPRequest instance) =>
    <String, dynamic>{
      'reference_number': instance.referenceNumber,
    };

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      token: json['token'] as String?,
    );

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'token': instance.token,
    };
