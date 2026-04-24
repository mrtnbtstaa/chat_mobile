import 'package:chat/features/chat/chat_message/domain/entities/chat_message_entity.dart';
import 'package:equatable/equatable.dart';

class PaginatedMessages extends Equatable{

  final String? next;
  final String? previous;
  final List<ChatMessageEntity> results;

  const PaginatedMessages({
    this.next,
    this.previous,
    required this.results
  });

  @override
  List<Object?> get props => [results, next, previous];
}