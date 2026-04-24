import '../../../../../core/usecases/base_usecase.dart';
import '../../domain/repositories/i_profile_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failure.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/params/profile_param.dart';

class UploadProfileUsecase extends BaseUsecase<ProfileEntity, ProfileParam>{

  final IProfileRepository _profileRepository;

  UploadProfileUsecase(this._profileRepository);

  @override
  Future<Either<Failure, ProfileEntity>> call(ProfileParam param) async => await _profileRepository.upload(param.profile);

}