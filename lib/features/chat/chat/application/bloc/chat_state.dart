part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();
  
  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}
final class ChatLoading extends ChatState {}
final class ChatSuccess extends ChatState {
  const ChatSuccess();
}
final class ChatError extends ChatState {

  final String errorMessage;

  const ChatError({
    required this.errorMessage
  });

  @override
  List<Object> get props => [errorMessage];

}
