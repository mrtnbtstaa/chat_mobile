import 'package:chat/core/errors/failure.dart';
import 'package:chat/features/chat/chat/infrastructure/dtos/response/chat_response_dto.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IChatRemoteDataSource {
  Future<Either<Failure, List<ChatResponseDto>>> getChats(String userId);
}