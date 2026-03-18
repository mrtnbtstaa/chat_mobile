import 'package:chat/core/errors/failure.dart';
import 'package:chat/core/usecases/base_usecase.dart';
import 'package:chat/features/authentication/domain/entities/token_entity.dart';
import 'package:chat/features/authentication/domain/params/refresh_token_param.dart';
import 'package:chat/features/authentication/domain/repositories/i_auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class RefreshTokenUsecase implements BaseUsecase<TokenEntity, RefreshTokenParam>{

  final IAuthRepository authRepository;

  const RefreshTokenUsecase({
    required this.authRepository
  });

  @override
  Future<Either<Failure, TokenEntity>> call(RefreshTokenParam param) async => await authRepository.refreshToken(param.refreshToken);

}