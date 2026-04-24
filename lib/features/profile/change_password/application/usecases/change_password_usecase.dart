import '../../../../../core/di/di_exports.dart';
import '../../../../../core/errors/failure.dart';
import '../../domain/params/password_param.dart';
import '../../domain/repositories/i_password_repository.dart';

class ChangePasswordUsecase extends BaseUsecase<Unit, PasswordParam>{

  final IPasswordRepository _passwordRepository;

  ChangePasswordUsecase(this._passwordRepository);

  @override
  Future<Either<Failure, Unit>> call(PasswordParam param) async => await _passwordRepository.changePassword(param);

}