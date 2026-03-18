import 'package:chat/core/errors/failure.dart';
import 'package:chat/core/usecases/base_usecase.dart';
import 'package:chat/features/authentication/domain/params/register_param.dart';
import 'package:chat/features/authentication/domain/repositories/i_auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class RegisterUsecase implements BaseUsecase<Unit, RegisterParam> {

  final IAuthRepository authRepository;

  const RegisterUsecase({required this.authRepository});

  @override
  Future<Either<Failure, Unit>> call(RegisterParam param) async{
    final result = await authRepository.register(param.username, param.password, param.confirmPassword, param.profile);
    return result.fold(
      (failure) => Left(failure),
      (_) => Right(unit)
    );
  }
}