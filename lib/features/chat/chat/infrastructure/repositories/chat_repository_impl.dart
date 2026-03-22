import 'dart:async';

import 'package:chat/core/errors/failure.dart';
import 'package:chat/features/chat/chat/domain/entities/chat_entity.dart';
import 'package:chat/features/chat/chat/domain/repositories/i_chat_repository.dart';
import 'package:chat/features/chat/chat/infrastructure/datasources/remote/i_chat_remote_data_source.dart';
import 'package:fpdart/fpdart.dart';

class ChatRepositoryImpl implements IChatRepository{

  final IChatRemoteDataSource chatRemoteDataSource;

  const ChatRepositoryImpl({
    required this.chatRemoteDataSource
  });

  @override
  Future<Either<Failure, List<ChatEntity>>> chats(String userId) async {

    final result = await chatRemoteDataSource.getChats(userId);

    return result.fold(
      (failure) => left(failure), 
      (map) => right(map.map((m) => m.toEntity()).toList())
    );

  }
}