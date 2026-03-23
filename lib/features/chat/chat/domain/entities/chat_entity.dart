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

  @override
  List<Object?> get props => [previous, next, results];

}