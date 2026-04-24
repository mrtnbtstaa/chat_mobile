import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failure.dart';
import '../../domain/params/password_param.dart';
import '../../domain/repositories/i_password_repository.dart';
import '../datasources/i_password_remote_data_source.dart';
import '../dtos/password_request_dto.dart';

class PasswordRepositoryImpl implements IPasswordRepository{

  final IPasswordRemoteDataSource _passwordRemoteDataSource;

  const PasswordRepositoryImpl(this._passwordRemoteDataSource);

  @override
  Future<Either<Failure, Unit>> changePassword(PasswordParam param) async {
    
    // Create request DTO
    final passwordDTO = PasswordRequestDto(
      currentPassword: param.currentPassword,
      newPassword: param.newPassword,
      confirmPassword: param.confirmPassword
    );

    // Call the change password datasource
    final result = await _passwordRemoteDataSource.changePassword(passwordDTO);

    return await result.fold(
      (failure) => left(failure), 
      (_) => right(unit)
    );

  }
}