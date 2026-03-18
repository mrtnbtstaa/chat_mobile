import 'package:chat/features/authentication/domain/entities/token_entity.dart';
import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {

  final String userId;
  final String username;
  final TokenEntity tokens;
  final String? profile;

  const AuthEntity(
    {
      required this.userId,
      required this.username,
      required this.tokens,
      this.profile,
    }
  );

  @override
  List<Object?> get props => [userId,username, tokens, profile];
  
}