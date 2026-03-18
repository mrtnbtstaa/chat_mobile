import 'package:chat/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class BaseUsecase<T, P> {
  Future<Either<Failure,T>> call(P param);
}