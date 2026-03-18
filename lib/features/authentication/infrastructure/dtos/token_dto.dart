import 'package:chat/features/authentication/domain/entities/token_entity.dart';

class TokenDto extends TokenEntity{

  const TokenDto({
    required super.accessToken,
    required super.refreshToken
  });

  factory TokenDto.fromJson(Map<String, dynamic> json){
    return TokenDto(accessToken: json["access_token"], refreshToken: json["refresh_token"]);
  }

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "refresh_token": refreshToken
  };

  TokenEntity toEntity() => this;

}