part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {

  final ChatEntity? chatEntity;
  final ChatEntity? chatUserEntity;

  const ChatState({this.chatEntity, this.chatUserEntity});
  
  @override
  List<Object> get props => [?chatEntity, ?chatUserEntity];
}

final class ChatInitial extends ChatState {}
final class ChatLoading extends ChatState {}
final class ChatConnected extends ChatState{

  const ChatConnected({super.chatEntity, super.chatUserEntity});

  ChatConnected copyWith({
    ChatEntity? chatEntity,
    ChatEntity? chatUserEntity
  }){
    return ChatConnected(
      chatEntity: chatEntity ?? this.chatEntity,
      chatUserEntity: chatUserEntity ?? this.chatUserEntity
    );
  }

}
final class ChatError extends ChatState {

  final String errorMessage;

  const ChatError({
    required this.errorMessage
  });

  @override
  List<Object> get props => [errorMessage];

}

