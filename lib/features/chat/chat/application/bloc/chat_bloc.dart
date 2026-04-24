import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../../core/contracts/i_user_storage.dart';
import '../../../../../core/usecases/base_usecase.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/sub_entities/chat_last_message.dart';
import '../../infrastructure/datasources/inbox_ws_client.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  StreamSubscription? _messageInboxSubscription;

  final InboxWsClient _client;
  final BaseUsecase<ChatEntity, Unit> _listChatUseCase;
  final BaseUsecase<ChatEntity, Unit> _listChatUserStatusUseCase;
  final IUserStorage _userStorage;

  ChatBloc({
    required BaseUsecase<ChatEntity, Unit> listChatUseCase,
    required BaseUsecase<ChatEntity, Unit> listChatUserStatusUseCase,
    required InboxWsClient client,
    required IUserStorage userStorage
  }) : _listChatUseCase = listChatUseCase, _listChatUserStatusUseCase = listChatUserStatusUseCase, _client = client, _userStorage = userStorage,
   super(ChatInitial()) {
    on<ConnectToInbox>(_onConnectToInbox);
    on<ChatInboxReceived>(_onChatInboxReceived);
    on<ChatUserStatus>(_onChatUserStatus);
  }

  FutureOr<void> _onConnectToInbox(ConnectToInbox event, Emitter<ChatState> emit) async {
    
    emit(ChatLoading());
    
    try{
      
      final result = await _listChatUseCase(unit);

      // Listen to the incoming stream
      _messageInboxSubscription?.cancel();
      _messageInboxSubscription = _client.messageStream.listen((data){
        add(ChatInboxReceived(json: data));
      });

      final userId = await _userStorage.getUserInfo("user_id");

      await _client.initializeSocketClient(userId.toString());
      return await result.fold(
        (failure) async => emit(ChatError(errorMessage: failure.message ?? "")),
        (entity){
          emit(ChatConnected(chatEntity: entity, chatUserEntity: state.chatUserEntity));
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
          final updatedLastMessage = (room.lastMessage ??  ChatLastMessage(
            messageId: '', text: '', sender: '', lastMessageAt: DateTime.now()
          )).copyWith(text: newText, lastMessageAt: DateTime.now());

          // Finally return the room with the updated last message and unread count
          return room.copyWith(
            lastMessage: updatedLastMessage,
            unreadCount: room.unreadCount + 1
          );

        }
        return room;
      }).toList();

      // Emit the state as Chat Connected
      emit((state as ChatConnected).copyWith(chatEntity: currentEntity?.copyWith(
        results: updatedResults,
        next: currentEntity.next,
        previous: currentEntity.previous
      )));

    }

   

  }

  FutureOr<void> _onChatUserStatus(ChatUserStatus event, Emitter<ChatState> emit) async {

    final result = await _listChatUserStatusUseCase(unit);

    emit(ChatLoading());

    try{

      return await result.fold(
        (failure){
          if(kDebugMode){
            print("Chat failure: ${failure.message}, ${failure.code}");
          }
          emit(ChatError(errorMessage: failure.message ?? ""));
        },
        (entity){
          emit(ChatConnected(chatUserEntity: entity));
        }
      );

    }catch(e){
      emit(ChatError(errorMessage: e.toString()));
    }

  }
}
