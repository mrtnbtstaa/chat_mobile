import 'package:chat/features/authentication/domain/entities/token_entity.dart';

class RefreshTokenResponseDto extends TokenEntity{

  const RefreshTokenResponseDto({
    required super.accessToken,
    required super.refreshToken
  });

  factory RefreshTokenResponseDto.fromJson(Map<String, dynamic> json){
    return RefreshTokenResponseDto(accessToken: json["access_token"], refreshToken: json["refresh_token"]);
  }

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "refresh_token": refreshToken
  };

  TokenEntity toEntity() => this;

}