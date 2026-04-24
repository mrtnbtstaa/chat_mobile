import 'package:chat/features/chat/chat_group/models/entities/paginated_group_member.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failure.dart';
import '../remote/i_group_member_remote_data_source.dart';
import '../../models/repositories/i_group_member_repository.dart';

class GroupMemberRepositoryImpl implements IGroupMemberRepository{

  final IGroupMemberRemoteDataSource _groupMemberRemoteDataSource;

  GroupMemberRepositoryImpl(this._groupMemberRemoteDataSource);

  @override
  Future<Either<Failure, PaginatedGroupMember>> getMembers(String? cursorUrl) async {

    final result = await _groupMemberRemoteDataSource.getMembers(cursorUrl);

    return result.fold(
      (failure) => left(failure),
      (dto) => right(dto.toEntity())
    );

  }

}