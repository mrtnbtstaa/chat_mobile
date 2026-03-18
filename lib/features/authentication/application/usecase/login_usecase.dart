import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/params/login_param.dart';
import '../../domain/repositories/i_auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LoginUsecase implements BaseUsecase<AuthEntity, LoginParam>{

  final IAuthRepository authRepository;

  const LoginUsecase({required this.authRepository});

  @override
  Future<Either<Failure, AuthEntity>> call(LoginParam param) async => await authRepository.login(param.username, param.password);

}