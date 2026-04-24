import '../../../../core/errors/email_failure.dart';
import '../../../../core/errors/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

@immutable
class Email extends Equatable {

  final String value;

  // private constructor
  const Email._(this.value);

  static Either<Failure, Email> create(String input){
    if(_isValid(input)) {return right(Email._(input.toLowerCase().trim()));}
    else {return left(const InvalidEmailFailure());}
  }

  factory Email.fromUniqueString(String input){
    if(_isValid(input)){
      return Email._(input);
    }else{
      throw FormatException("Domain Integrity Violation: Server sent malformed email: $input");
    }
  }

  static bool _isValid(String email) => RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{3,}$').hasMatch(email);

  @override
  List<Object?> get props => [value];

}