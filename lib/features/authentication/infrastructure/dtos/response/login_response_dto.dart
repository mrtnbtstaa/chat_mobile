import 'package:chat/features/authentication/domain/entities/auth_entity.dart';
import 'package:chat/features/authentication/infrastructure/dtos/response/refresh_token_response_dto.dart';

class LoginResponseDto extends AuthEntity {
  
  final bool isOnline;

  const LoginResponseDto({
    required super.userId,
    required super.username,
    required super.firstname,
    required super.lastname,
    required super.tokens,
    required this.isOnline,
    super.profile,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json){
    return LoginResponseDto(
      userId: json["user_id"],
      username: json["username"],
      firstname: json["first_name"],
      lastname: json["last_name"],
      tokens: RefreshTokenResponseDto.fromJson(json["tokens"]),
      isOnline: json["is_online"],
      profile: json["profile"] ?? "",
    );
  }

  AuthEntity toEntity() => this;

}