part of 'chat_group_bloc.dart';

class ChatGroupState extends Equatable {

  final List<GroupMemberEntity> groupMembers;
  final List<GroupMemberEntity> addedGroupMembers;

  const ChatGroupState({
    this.groupMembers = const [],
    this.addedGroupMembers = const []
  });


  ChatGroupState copyWith({
    List<GroupMemberEntity>? groupMembers,
    List<GroupMemberEntity>? addedGroupMembers
  }){
    return ChatGroupState(
      groupMembers: groupMembers ?? this.groupMembers,
      addedGroupMembers: addedGroupMembers ?? this.addedGroupMembers
    );
  }
  
  @override
  List<Object> get props => [groupMembers, addedGroupMembers];
}



