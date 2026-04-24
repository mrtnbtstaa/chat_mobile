import 'package:chat/features/chat/chat_group/models/entities/paginated_group_member.dart';

import '../../../../../core/di/di_exports.dart';
import '../../../../../core/errors/failure.dart';
import '../../models/repositories/i_group_member_repository.dart';

class ListGroupChatUsecase extends BaseUsecase<PaginatedGroupMember, String?>{

  final IGroupMemberRepository _groupMemberRepository;

  ListGroupChatUsecase(this._groupMemberRepository);

  @override
  Future<Either<Failure, PaginatedGroupMember>> call(String? param) async => _groupMemberRepository.getMembers(param);

}