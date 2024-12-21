// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_otp_request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokenAdapter extends TypeAdapter<Token> {
  @override
  final int typeId = 0;

  @override
  Token read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Token(
      token: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Token obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
