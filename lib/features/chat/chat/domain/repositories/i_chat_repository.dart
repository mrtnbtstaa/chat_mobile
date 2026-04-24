import 'dart:async';

import 'package:chat/core/errors/failure.dart';
import 'package:chat/features/chat/chat/domain/entities/chat_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IChatRepository {
  Future<Either<Failure, ChatEntity>> chats();
  Future<Either<Failure, ChatEntity>> getChatStatus();
}