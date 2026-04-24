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
  final bool isSearchEnable;

  const ChatState({
    this.messages = const [],
    this.status = SocketStatus.offline,
    this.nextCursor,
    this.previousCursor,
    this.isLoadingMore = false,
    this.isTyping = false,
    this.textMessage = "",
    this.typingUsername,
    this.isSearchEnable = false
  });
  
  @override
  List<Object> get props => [messages, status, ?nextCursor, ?previousCursor, isLoadingMore, isTyping, textMessage, ?typingUsername, isSearchEnable];
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
    super.typingUsername,
    super.isSearchEnable
  });

  ChatConnected copyWith({
    List<ChatMessageEntity>? messages,
    String? nextCursor,
    String? previousCursor,
    SocketStatus? status,
    bool? isLoadingMore,
    bool? isTyping,
    String? textMessage,
    String? typingUsername,
    bool? isSearchEnable
  }) {
    return ChatConnected(
      messages: messages ?? this.messages,
      nextCursor: nextCursor ?? this.nextCursor,
      previousCursor: previousCursor ?? this.nextCursor,
      status: status ?? this.status,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isTyping: isTyping ?? this.isTyping,
      textMessage: textMessage ?? this.textMessage,
      typingUsername: typingUsername,
      isSearchEnable: isSearchEnable ?? this.isSearchEnable
    );
  }
}

final class ChatError extends ChatState{
  
  const ChatError({super.status});
  
  @override
  List<Object> get props => [status];
}
