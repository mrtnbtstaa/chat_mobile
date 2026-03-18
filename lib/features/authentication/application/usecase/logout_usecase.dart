import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../../domain/repositories/i_auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LogoutUsecase implements BaseUsecase<Unit, String>{

  final IAuthRepository authRepository;

  const LogoutUsecase({required this.authRepository});

  @override
  Future<Either<Failure, Unit>> call(String refreshToken) async => await authRepository.logout(refreshToken);

}