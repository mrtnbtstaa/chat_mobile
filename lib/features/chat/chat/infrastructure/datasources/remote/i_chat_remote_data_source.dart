import 'package:chat/core/errors/failure.dart';
import 'package:chat/features/chat/chat/infrastructure/dtos/response/chat_response_dto.dart';
import 'package:fpdart/fpdart.dart';

import '../../dtos/response/chat_user_status_response_dto.dart';

abstract interface class IChatRemoteDataSource {
  Future<Either<Failure, ChatResponseDto>> getChats();
  Future<Either<Failure, ChatUserStatusResponseDto>> getChatStatus();
}