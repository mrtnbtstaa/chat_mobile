import 'package:fpdart/fpdart.dart';
import '../../../../../core/constants/api_constant.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/network/network_client.dart';
import '../dtos/response/paginated_group_chat_response_dto.dart';
import 'i_group_member_remote_data_source.dart';

class GroupMemberRemoteDataSourceImpl extends NetworkClient implements IGroupMemberRemoteDataSource{

  GroupMemberRemoteDataSourceImpl({super.client});

  @override
  Future<Either<Failure, PaginatedGroupChatResponseDto>> getMembers(String? cursorUrl) async{
    final urlPath = (cursorUrl != null && cursorUrl.isNotEmpty) ? cursorUrl : ApiConstant.listGroupChatApi;
    return await get<PaginatedGroupChatResponseDto>(
      urlPath,
      onSuccess: (json) => PaginatedGroupChatResponseDto.fromJson(json)
    );
  }
 
}