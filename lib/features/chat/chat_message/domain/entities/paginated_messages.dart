import 'package:chat/features/chat/chat_message/domain/entities/chat_message_entity.dart';
import 'package:equatable/equatable.dart';

class PaginatedMessages extends Equatable{

  final List<ChatMessageEntity> results;
  final String? next;
  final String? previous;

  const PaginatedMessages({
    required this.results,
    this.next,
    this.previous
  });

  @override
  List<Object?> get props => [results, next, previous];

  factory PaginatedMessages.fromJson(Map<String, dynamic> json){
    return PaginatedMessages(
      results: json["results"],
      next: json["next"],
      previous: json["previous"]
    );
  }

}