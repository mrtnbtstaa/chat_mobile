part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {

  final ChatEntity? chatEntity;

  const ChatState({this.chatEntity});
  
  @override
  List<Object> get props => [?chatEntity];
}

final class ChatInitial extends ChatState {}
final class ChatLoading extends ChatState {}
final class ChatConnected extends ChatState{

  const ChatConnected({super.chatEntity});

  ChatConnected copyWith({
    ChatEntity? chatEntity
  }){
    return ChatConnected(chatEntity: chatEntity ?? this.chatEntity);
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
