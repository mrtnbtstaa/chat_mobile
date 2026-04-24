import 'package:chat/core/di/di_exports.dart';

import '../../../../../core/errors/failure.dart';
import '../dtos/response/paginated_group_chat_response_dto.dart';

abstract interface class IGroupMemberRemoteDataSource {

  Future<Either<Failure, PaginatedGroupChatResponseDto>> getMembers(String? cursorUrl);

}