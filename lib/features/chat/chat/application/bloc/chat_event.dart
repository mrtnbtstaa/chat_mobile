part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {

  final UserIdParam userIdParam;

  const ChatEvent({required this.userIdParam});

  @override
  List<Object> get props => [userIdParam];
}
