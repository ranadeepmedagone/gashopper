import 'package:json_annotation/json_annotation.dart';

part "login_otp_request.g.dart";

@JsonSerializable()
class LoginOTPRequest {
  @JsonKey(name: "reference_number")
  final String? referenceNumber;

  LoginOTPRequest({
    this.referenceNumber,
  });

  factory LoginOTPRequest.fromJson(Map<String, dynamic> json) {
    return _$LoginOTPRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginOTPRequestToJson(this);
}

@JsonSerializable()
class Token {
  @JsonKey(name: "token")
  final String? token;

  Token({
    this.token,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return _$TokenFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
