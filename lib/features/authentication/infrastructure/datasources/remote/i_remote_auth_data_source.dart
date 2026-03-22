import '../../../../../core/errors/failure.dart';
import '../../dtos/request/refresh_token_request_dto.dart';
import '../../dtos/request/login_request_dto.dart';
import '../../dtos/request/verify_token_request_dto.dart';
import '../../dtos/response/login_response_dto.dart';
import '../../dtos/response/refresh_token_response_dto.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IRemoteAuthDataSource {
  Future<Either<Failure, LoginResponseDto>> login(LoginRequestDto loginRequestDto);
  Future<Either<Failure, Unit>> register(Map<String, dynamic> data);
  Future<Either<Failure, Unit>> logout(Map<String, dynamic> data);
  Future<Either<Failure, RefreshTokenResponseDto>> refresh(RefreshTokenRequestDto refreshTokenDto);
  Future<Either<Failure, Unit>> verify(VerifyTokenRequestDto verifyTokenDto);
}