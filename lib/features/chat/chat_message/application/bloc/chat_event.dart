part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

final class ConnectToChat extends ChatEvent{}
final class MessageReceived extends ChatEvent{

  final Map<String, dynamic> jsonMessages;
  
  const MessageReceived({required this.jsonMessages});

  @override
  List<Object> get props => [jsonMessages];

}
final class SendMessage extends ChatEvent{
  final String message;
  const SendMessage({required this.message});

  @override
  List<Object> get props => [message];
}

final class LoadMoreMessages extends ChatEvent {}
final class RefreshMessages extends ChatEvent {}
final class MessageTypingChanged extends ChatEvent{
  final String textMessage;
  const MessageTypingChanged(this.textMessage);
}
final class RemoteUserTypingChanged extends ChatEvent{
  final String email;
  final bool isTyping;

  const RemoteUserTypingChanged({
    required this.email,
    required this.isTyping
  });
}
final class SearchEnabled extends ChatEvent{
  const SearchEnabled();
}