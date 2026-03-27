import 'dart:async';

import 'package:chat/core/errors/failure.dart';
import 'package:chat/features/chat/chat/domain/entities/chat_entity.dart';
import 'package:chat/features/chat/chat/domain/repositories/i_chat_repository.dart';
import 'package:chat/features/chat/chat/infrastructure/datasources/remote/i_chat_remote_data_source.dart';
import 'package:fpdart/fpdart.dart';

class ChatRepositoryImpl implements IChatRepository{

  final IChatRemoteDataSource _chatRemoteDataSource;

  ChatRepositoryImpl(this._chatRemoteDataSource);

  @override
  Future<Either<Failure, ChatEntity>> chats() async {

    final result = await _chatRemoteDataSource.getChats();

    return result.fold(
      (failure) => left(failure), 
      (dto) => right(dto.toEntity())
    );

  }
}