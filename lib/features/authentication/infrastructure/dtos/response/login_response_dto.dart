import 'package:chat/features/authentication/domain/entities/auth_entity.dart';
import 'package:chat/features/authentication/infrastructure/dtos/response/refresh_token_response_dto.dart';

class LoginResponseDto extends AuthEntity {
  
  const LoginResponseDto({
    required super.userId,
    required super.username,
    required super.tokens,
    super.profile,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json){
    return LoginResponseDto(
      userId: json["user_id"],
      username: json["username"],
      tokens: RefreshTokenResponseDto.fromJson(json["tokens"]),
      profile: json["profile"] ?? "",
    );
  }

  AuthEntity toEntity() => this;

}