import 'package:chat/features/chat/chat_group/models/entities/group_member_entity.dart';
import 'package:equatable/equatable.dart';

class PaginatedGroupMember extends Equatable {

  final String? next;
  final String? previous;
  final List<GroupMemberEntity> results;
  
  const PaginatedGroupMember({
    this.next,
    this.previous,
    required this.results
  });

  @override
  List<Object?> get props => [?next, ?previous, results];

}