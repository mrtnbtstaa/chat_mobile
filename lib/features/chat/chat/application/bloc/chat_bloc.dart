import 'dart:async';

import 'package:chat/core/contracts/i_user_storage.dart';
import 'package:chat/core/extensions/datetime_extension.dart';
import 'package:chat/core/extensions/int_extension.dart';
import 'package:chat/core/usecases/base_usecase.dart';
import 'package:chat/features/chat/chat/domain/entities/chat_entity.dart';
import 'package:chat/features/chat/chat/domain/entities/sub_entities/chat_last_message.dart';
import 'package:chat/features/chat/chat/infrastructure/datasources/inbox_ws_client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  StreamSubscription? _messageInboxSubscription;

  final InboxWsClient _client;
  final BaseUsecase<ChatEntity, Unit> _listChatUseCase;
  final IUserStorage _userStorage;

  ChatBloc({
    required BaseUsecase<ChatEntity, Unit> listChatUseCase,
    required InboxWsClient client,
    required IUserStorage userStorage
  }) : _listChatUseCase = listChatUseCase, _client = client, _userStorage = userStorage,
   super(ChatInitial()) {
    on<ConnectToInbox>(_onConnectToInbox);
    on<ChatInboxReceived>(_onChatInboxReceived);
  }

  FutureOr<void> _onConnectToInbox(ConnectToInbox event, Emitter<ChatState> emit) async {
    
    emit(ChatLoading());

    try{
      
      await Future.delayed(2.seconds());

      final result = await _listChatUseCase(unit);

      
      // Listen to the incoming stream
      _messageInboxSubscription?.cancel();
      _messageInboxSubscription = _client.messageStream.listen((data){
        print(data);
        add(ChatInboxReceived(json: data));
      });

      final userId = await _userStorage.getUserInfo("user_id");

      await _client.initializeSocketClient(userId.toString());
      return await result.fold(
        (failure) async {
          print("Chat Error: ${failure.message}, ${failure.error}, ${failure.code}, ${failure.statusCode}");
          emit(ChatError(errorMessage: failure.message));
        },
        (entity){
          return emit(ChatConnected(chatEntity: entity));
        }
      );

    }catch(e){
      emit(ChatError(errorMessage: e.toString()));
    }

    

  }

  FutureOr<void> _onChatInboxReceived(ChatInboxReceived event, Emitter<ChatState> emit) async {

    if(kDebugMode){
      print("Incoming data: ${event.json}");
    }

    if(state is ChatConnected){

      final currentEntity = (state as ChatConnected).chatEntity;

      final chatId = event.json["message"]["chat_id"];
      final newText = event.json["message"]["last_message"];

      final updatedResults = state.chatEntity?.results.map((room){
        // Check if they are the same room id
        if(room.id == chatId){

          // Update the last message to the newtext received from the ws
          final updatedLastMessage = (room.lastMessage ?? const ChatLastMessage(
            messageId: '', text: '', sender: '', lastMessageAt: ''
          )).copyWith(text: newText, lastMessageAt: DateTime.now().formattedTime());

          // Finally return the room with the updated last message and unread count
          return room.copyWith(
            lastMessage: updatedLastMessage,
            unreadCount: room.unreadCount + 1
          );

        }
        return room;
      }).toList();

      
      // updatedResults?.sort((a, b){
      //   final dateA = a.lastMessage?.lastMessageAt ?? a.createdAt.toIso8601String();
      //   final dateB = b.lastMessage?.lastMessageAt ?? b.createdAt.toIso8601String();
      //   return dateB.compareTo(dateA);
      // });

      // Emit the state as Chat Connected
      emit((state as ChatConnected).copyWith(chatEntity: currentEntity?.copyWith(
        results: updatedResults,
        next: currentEntity.next,
        previous: currentEntity.previous
      )));

    }

   

  }
}
