import 'package:chat/core/errors/failure.dart';
import 'package:chat/features/profile/profile/domain/entities/profile_entity.dart';
import 'package:chat/features/profile/profile/domain/value_objects/profile.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IProfileRepository {
  Future<Either<Failure, ProfileEntity>> upload(Profile profile);
}