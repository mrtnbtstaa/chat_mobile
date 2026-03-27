part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {

  final List<ChatMessageEntity> messages;
  final SocketStatus status; 
  final String? nextCursor;
  final String? previousCursor;
  final bool isLoadingMore;
  final bool isTyping;
  final String textMessage;
  final String? typingUsername;

  const ChatState({
    this.messages = const [],
    this.status = SocketStatus.offline,
    this.nextCursor,
    this.previousCursor,
    this.isLoadingMore = false,
    this.isTyping = false,
    this.textMessage = "",
    this.typingUsername
  });
  
  @override
  List<Object> get props => [messages, status, ?nextCursor, ?previousCursor, isLoadingMore, isTyping, textMessage, ?typingUsername];
}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {
  const ChatLoading({super.status});
  @override
  List<Object> get props => [status];
}

class ChatConnected extends ChatState {

  const ChatConnected({
    super.messages,
    super.status,
    super.nextCursor,
    super.previousCursor,
    super.isLoadingMore,
    super.isTyping,
    super.textMessage,
    super.typingUsername
  });

  ChatConnected copyWith({
    List<ChatMessageEntity>? messages,
    String? nextCursor,
    String? previousCursor,
    SocketStatus? status,
    bool? isLoadingMore,
    bool? isTyping,
    String? textMessage,
    String? typingUsername
  }) {
    return ChatConnected(
      messages: messages ?? this.messages,
      nextCursor: nextCursor ?? this.nextCursor,
      previousCursor: previousCursor ?? this.nextCursor,
      status: status ?? this.status,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isTyping: isTyping ?? this.isTyping,
      textMessage: textMessage ?? this.textMessage,
      typingUsername: typingUsername
    );
  }
}

final class ChatError extends ChatState{
  
  const ChatError({super.status});
  
  @override
  List<Object> get props => [status];
}
