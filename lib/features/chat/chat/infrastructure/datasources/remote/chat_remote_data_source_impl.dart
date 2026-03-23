import 'package:chat/core/constants/api_constant.dart';
import 'package:chat/core/errors/failure.dart';
import 'package:chat/core/network/network_client.dart';
import 'package:chat/features/chat/chat/infrastructure/datasources/remote/i_chat_remote_data_source.dart';
import 'package:chat/features/chat/chat/infrastructure/dtos/response/chat_response_dto.dart';
import 'package:fpdart/fpdart.dart';

class ChatRemoteDataSourceImpl extends NetworkClient implements IChatRemoteDataSource{

  ChatRemoteDataSourceImpl({super.client});

  @override
  Future<Either<Failure, List<ChatResponseDto>>> getChats(String userId) async =>
  await get(
    ApiConstant.listChatApi,
    onSuccess: (json) => (json as List).map((i) => ChatResponseDto.fromJson(i)).toList(),
    id: userId
  );

}