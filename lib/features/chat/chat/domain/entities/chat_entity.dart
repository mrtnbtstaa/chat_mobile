import 'package:chat/features/chat/chat/domain/entities/sub_entities/chat_result_entity.dart';
import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable{

  final String? previous;
  final String? next;
  final List<ChatResultEntity> results;

  const ChatEntity({
    this.previous,
    this.next,
    required this.results
  });


  ChatEntity copyWith({
    String? previous,
    String? next,
    List<ChatResultEntity>? results,
  }) {
    return ChatEntity(
      previous: previous ?? this.previous,
      next: next ?? this.next,
      results: results ?? this.results,
    );
  }

  @override
  List<Object?> get props => [previous, next, results];

}