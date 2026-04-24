import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../../../../core/common/core_transformers.dart';
import '../../../../../core/di/di_exports.dart';
import '../../../../../core/extensions/int_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  
  final WebSockentClient _client;
  final BaseUsecase<Unit, ChatMessageParam> _chatMessageUseCase;
  final BaseUsecase<PaginatedMessages, String?> _chatMessageListUseCase;
  final ChatSocketService _chatSocketService;
  final String _receiverId;

    StreamSubscription? _messageSubscription;

  ChatBloc({
    required WebSockentClient client,
    required String receiverId,
    required BaseUsecase<Unit, ChatMessageParam> chatMessageUsecase,
    required BaseUsecase<PaginatedMessages, String?> chatMessageListUseCase,
    required ChatSocketService chatSocketService
  }) :
  _client = client,
  _receiverId = receiverId,
  _chatMessageUseCase = chatMessageUsecase,
  _chatMessageListUseCase = chatMessageListUseCase,
  _chatSocketService = chatSocketService,
  super(ChatInitial()) {
    on<ConnectToChat>(_onConnectToChat);
    on<MessageReceived>(_onMessageReceived);
    on<SendMessage>(_onSendMessage, transformer: sequential());
    on<LoadMoreMessages>(_onLoadMoreMessages, transformer: droppable());
    on<RefreshMessages>(_onRefreshMessages, transformer: droppable());
    on<MessageTypingChanged>(_onMessageTypingChanged, transformer: CoreTransformers.debounceRestartable(500.milliseconds()));
    on<RemoteUserTypingChanged>(_onRemoteUserTypingChanged);
    on<SearchEnabled>(_onSearchEnabled);
  }

  FutureOr<void> _onConnectToChat(ConnectToChat event, Emitter<ChatState> emit) async {

    emit(ChatLoading(status: SocketStatus.connecting));

    try{
      final listMessageUseCase = await _chatMessageListUseCase(null);

      // Listen to the stream
      _messageSubscription?.cancel();
      _messageSubscription = _client.messageStream.listen((data){
      
      if(data["type"] == "typing"){

        final String? senderId = data["user_id"]?.toString();
        final String senderName = data['email'] ?? "Someone";
        final bool isTyping = data['is_typing'] ?? false;
        // Only trigger the event if its not from the current user
        if(_chatSocketService.isNotMe(senderId)){
          add(RemoteUserTypingChanged(email: senderName, isTyping: isTyping));
        }

      }else{
        add(MessageReceived(jsonMessages: data));
      }
      });

      // Initialize the socket
      await _client.initializeSocketClient(_receiverId);

      return await listMessageUseCase.fold(
        (failure) async => emit(ChatError(status: SocketStatus.offline)),
        (listEntity) async{
          emit(ChatConnected(
            messages: listEntity.results,
            status: SocketStatus.online,
            nextCursor: listEntity.next,
            previousCursor: listEntity.previous
          ));
        }
      );

    }catch(e){
      emit(ChatError(status: SocketStatus.offline));
    }
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel(); // Stop listening when the ChatBloc dies
    return super.close();
  }

  FutureOr<void> _onMessageReceived(MessageReceived event, Emitter<ChatState> emit) {

    if(kDebugMode){
      // print("Raw JSON from server: ${event.jsonMessages}}");
    }

    try{

        if(event.jsonMessages["type"] == "typing") return null;

        final newMessage = ChatMessageEntity.fromJson(event.jsonMessages["data"]);

        // Check if message already exists
        if(state.messages.any((m) => m.messageId == newMessage.messageId)) return null;

        final updatedMessageList = [newMessage, ...state.messages];
        emit((state as ChatConnected).copyWith(messages: updatedMessageList, status: state.status));

      }catch(e){
        if(kDebugMode){
          print("nag ka Error pag nareceived yung mga data: $e");
        }
    }
  }

  FutureOr<void> _onSendMessage(SendMessage event, Emitter<ChatState> emit) async {

    final chatMessageUsecase = await _chatMessageUseCase(ChatMessageParam(content: event.message, recipientId: _receiverId));

    try{
      return await chatMessageUsecase.fold(
        (failure) async{
          if(kDebugMode){
            print("Failure: ${failure.message}, ${failure.error}, ${failure.code}");
          }
          emit(ChatError());
        },
        (entity) async {
          if(kDebugMode){
            print("Entity: $entity");
          }
          emit((state as ChatConnected).copyWith(status: state.status));
        }
      );
    }catch(e){
      if(kDebugMode){
        print("Catch the error: $e");
      }
    }

  }

  FutureOr<void> _onLoadMoreMessages(LoadMoreMessages event, Emitter<ChatState> emit) async {

    final currentState = state;

    // Only load if we are connected and have a next page
    if(currentState is ChatConnected && currentState.nextCursor != null && currentState.nextCursor!.isNotEmpty && !currentState.isLoadingMore){

      emit(currentState.copyWith(isLoadingMore: true));

      final result = await _chatMessageListUseCase(currentState.nextCursor ?? "");

      return await result.fold(
        (failure) => emit(currentState.copyWith(isLoadingMore: false)),
        (paginatedData){

          final allMessages = [
            ...currentState.messages,
            ...paginatedData.results
          ];

          // Create a Set of Ids to track message id uniqueness
          final ids = <String>{};

          // Only keep the messages if its id hasn't been seen yet
          final distinctMessages = allMessages.where((message){
            return ids.add(message.messageId);
          }).toList();

          emit(currentState.copyWith(
            messages: distinctMessages,
            nextCursor: paginatedData.next ?? "",
            isLoadingMore: false
          ));
        }
      );
    }
  }

  FutureOr<void> _onRefreshMessages(RefreshMessages event, Emitter<ChatState> emit) async {
    
    final currentState = state;

    if(currentState is ChatConnected && currentState.previousCursor != null && currentState.previousCursor!.isNotEmpty){

      final result = await _chatMessageListUseCase(currentState.previousCursor ?? "");

      return await result.fold(
        (failure) => emit(currentState.copyWith(isLoadingMore: false)),
        (paginatedData){

          final allMessages = [
            ...paginatedData.results,
            ...currentState.messages
          ];

          // Create a Set of Ids to track message id uniqueness
          final ids = <String>{};

          // Only keep the messages if its id hasn't been seen yet
          final distinctMessages = allMessages.where((message){
            return ids.add(message.messageId);
          }).toList();

          emit(currentState.copyWith(
            messages: distinctMessages,
            previousCursor: paginatedData.previous ?? "",
            isLoadingMore: false
          ));
        }
      );

    }

  }

  FutureOr<void> _onMessageTypingChanged(MessageTypingChanged event, Emitter<ChatState> emit) async {
    
    if(state is! ChatConnected) return;
   
    final currentState = state as ChatConnected;

    // If textMessage is empty, immediately tell server to stop typing
    if(event.textMessage.isEmpty){
      _chatSocketService.sendTypingStatus(false);
      emit(currentState.copyWith(isTyping: false, status: state.status));
      return;
    }

    // if we weren't typing
    if(!currentState.isTyping){
       _chatSocketService.sendTypingStatus(true);
      emit(currentState.copyWith(isTyping: true, status: state.status));
    }

 
    await Future.delayed(2000.milliseconds());

    if(state is ChatConnected && (state as ChatConnected).isTyping){
      _chatSocketService.sendTypingStatus(false);
      emit((state as ChatConnected).copyWith(isTyping: false, status: state.status));
    }

  }

  FutureOr<void> _onRemoteUserTypingChanged(RemoteUserTypingChanged event, Emitter<ChatState> emit) {

    if(state is ChatConnected){
      final currentState = state as ChatConnected;

      emit(currentState.copyWith(typingUsername: event.isTyping ? event.email : null, status: state.status));
    }

  }

  FutureOr<void> _onSearchEnabled(SearchEnabled event, Emitter<ChatState> emit) {
    if(state is ChatConnected){
      final currentState = state as ChatConnected;
      emit(currentState.copyWith(
        isSearchEnable: !state.isSearchEnable
      ));
    }
  }
}
