import 'dart:async';

import 'package:chat/core/usecases/base_usecase.dart';
import 'package:chat/features/chat/chat/domain/entities/chat_entity.dart';
import 'package:chat/features/chat/chat/domain/params/user_id_param.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final BaseUsecase<List<ChatEntity>, UserIdParam> _listChatUseCase;
  ChatBloc({required BaseUsecase<List<ChatEntity>, UserIdParam> listChatUseCase}) : _listChatUseCase = listChatUseCase, super(ChatInitial()) {
    on<ChatEvent>(_chatEvent);
  }

  FutureOr<void> _chatEvent(ChatEvent event, Emitter<ChatState> emit) async {

    emit(ChatLoading());

    final result = await _listChatUseCase(event.userIdParam);

    return result.fold(
      (failure) async => emit(ChatError(errorMessage: failure.message)),
      (entity) => emit(ChatSuccess())
    );

  }
}
