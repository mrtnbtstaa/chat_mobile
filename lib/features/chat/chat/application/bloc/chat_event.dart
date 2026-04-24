part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}


final class ConnectToInbox extends ChatEvent{
  const ConnectToInbox();
}

final class ChatInboxReceived extends ChatEvent{
  final Map<String, dynamic> json;
  const ChatInboxReceived({required this.json});
  @override
  List<Object> get props => [json];
}

final class ChatUserStatus extends ChatEvent{
  const ChatUserStatus();
}
