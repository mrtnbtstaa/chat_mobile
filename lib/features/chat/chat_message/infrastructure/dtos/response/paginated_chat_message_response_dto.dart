import 'package:chat/features/chat/chat_message/domain/entities/chat_message_entity.dart';
import 'package:chat/features/chat/chat_message/domain/entities/paginated_messages.dart';

class PaginatedChatMessageResponseDto<T extends ChatMessageEntity> {

  final List<T> results;
  final String? next;
  final String? previous;

  const PaginatedChatMessageResponseDto({
    required this.results,
    this.next,
    this.previous
  });

  PaginatedMessages toEntity(){
    return PaginatedMessages(
      results: results,
      next: next,
      previous: previous
    );
  }

}