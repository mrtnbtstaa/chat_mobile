import 'package:fpdart/fpdart.dart';

import '../../../../../../core/constants/api_constant.dart';
import '../../../../../../core/contracts/i_token_storage.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/network/network_client.dart';
import '../../dtos/response/chat_response_dto.dart';
import 'i_chat_remote_data_source.dart';

class ChatRemoteDataSourceImpl extends NetworkClient implements IChatRemoteDataSource{

  final ITokenStorage storage;

  ChatRemoteDataSourceImpl({super.client, required this.storage});

  @override
  Future<Either<Failure, ChatResponseDto>> getChats() async {

    return await get<ChatResponseDto>(
      ApiConstant.listChatApi,
      onSuccess: (json) {
        return ChatResponseDto.fromJson(json);
      },
    );
  }
  

}