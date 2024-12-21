import 'package:hive/hive.dart';
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
@HiveType(typeId: 0)
class Token extends HiveObject {
  @HiveField(0)
  final String? token;

  Token({
    required this.token,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        token: json['token'] as String,
      );

  Map<String, dynamic> toJson() => {
        'token': token,
      };
}
