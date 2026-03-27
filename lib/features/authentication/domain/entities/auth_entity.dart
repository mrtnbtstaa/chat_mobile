import 'package:chat/features/authentication/domain/entities/token_entity.dart';
import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {

  final String userId;
  final String username;
  final String firstname;
  final String lastname;
  final TokenEntity tokens;
  final String? profile;

  const AuthEntity(
    {
      required this.userId,
      required this.username,
      required this.firstname,
      required this.lastname,
      required this.tokens,
      this.profile,
    }
  );

  @override
  List<Object?> get props => [userId, username, firstname, lastname, tokens, profile];
  
}