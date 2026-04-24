import 'package:chat/features/authentication/domain/entities/token_entity.dart';
import 'package:chat/features/authentication/domain/value_objects/email.dart';
import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {

  final String userId;
  final String fullName;
  final Email email;
  final TokenEntity tokens;
  final String? profile;

  const AuthEntity(
    {
      required this.userId,
      required this.fullName,
      required this.email,
      required this.tokens,
      this.profile,
    }
  );

  @override
  List<Object?> get props => [userId, fullName, email, tokens, profile];
  
}