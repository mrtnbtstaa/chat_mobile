
import 'package:chat/features/authentication/domain/params/access_token_param.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/base_usecase.dart';
import '../../domain/repositories/i_auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class VerifyTokenUsecase implements BaseUsecase<Unit, AccessTokenParam>{

  final IAuthRepository authRepository;

  const VerifyTokenUsecase({required this.authRepository});

  @override
  Future<Either<Failure, Unit>> call(AccessTokenParam param) async => await authRepository.verifyToken(param.accessToken);

}