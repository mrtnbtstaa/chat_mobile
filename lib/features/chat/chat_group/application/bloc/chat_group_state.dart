part of 'chat_group_bloc.dart';

final class ChatGroupState extends Equatable {

  final List<GroupMemberEntity>? groupMembers;
  final List<GroupMemberEntity>? addedGroupMembers;
  final bool isLoadingMore;
  final String? nextCursor;
  final String? previousCursor;

  const ChatGroupState({
    this.groupMembers,
    this.addedGroupMembers,
    this.isLoadingMore = false,
    this.nextCursor,
    this.previousCursor
  });


  ChatGroupState copyWith({
    List<GroupMemberEntity>? groupMembers,
    List<GroupMemberEntity>? addedGroupMembers,
    bool? isLoadingMore,
    String? nextCursor,
    String? previousCursor
  }){
    return ChatGroupState(
      groupMembers: groupMembers ?? this.groupMembers,
      addedGroupMembers: addedGroupMembers ?? this.addedGroupMembers,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      nextCursor: nextCursor ?? this.nextCursor,
      previousCursor: previousCursor ?? this.previousCursor
    );
  }

 
  @override
  List<Object> get props => [?groupMembers, ?addedGroupMembers, isLoadingMore, ?nextCursor, ?previousCursor];
}


final class ChatGroupError extends ChatGroupState{}


