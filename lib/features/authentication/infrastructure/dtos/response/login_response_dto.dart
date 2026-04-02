import 'package:chat/features/authentication/domain/entities/auth_entity.dart';
import 'package:chat/features/authentication/infrastructure/dtos/response/refresh_token_response_dto.dart';

class LoginResponseDto extends AuthEntity {
  
  final bool isOnline;

  const LoginResponseDto({
    required super.userId,
    required super.fullName,
    required super.email,
    required super.tokens,
    required this.isOnline,
    super.profile,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json){
    return LoginResponseDto(
      userId: json["user_id"],
      fullName: json["full_name"],
      email: json["email"],
      tokens: RefreshTokenResponseDto.fromJson(json["tokens"]),
      isOnline: json["is_online"],
      profile: json["profile"] ?? "",
    );
  }

  AuthEntity toEntity() => this;

}