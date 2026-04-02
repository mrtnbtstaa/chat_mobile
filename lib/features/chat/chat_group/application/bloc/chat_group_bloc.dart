import 'dart:async';
import '../../../../../core/style/app_images.dart';
import '../../models/entities/group_member_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'chat_group_event.dart';
part 'chat_group_state.dart';

class ChatGroupBloc extends Bloc<ChatGroupEvent, ChatGroupState> {
  ChatGroupBloc() : super(ChatGroupState()) {
    on<LoadMembers>(_onLoadMembers);
    on<SelectMember>(_onSelectMember);
    on<RemoveMember>(_onRemoveMember);
  }

  FutureOr<void> _onSelectMember(SelectMember event, Emitter<ChatGroupState> emit) {

    // Update the group members 
    final updatedGroupMember = state.groupMembers.map((group){
      if(group.id == event.selectedId){
        return group.copyWith(isSelected: event.isSelected);
      }
      return group;
    }).toList();

    // Get all the added members based on the `updatedGroupMember`
    final addedMembers = updatedGroupMember.where((m) => m.isSelected);

    // Emit a state with the updated and added group members
    emit(state.copyWith(
      groupMembers: updatedGroupMember,
      addedGroupMembers: addedMembers.toList()
    ));

  }

  FutureOr<void> _onRemoveMember(RemoveMember event, Emitter<ChatGroupState> emit) {

    final addedMemberList = List<GroupMemberEntity>.from(state.addedGroupMembers);

    // Update the `isSelected` to false
    final updateSelectedMemberList = List<GroupMemberEntity>.from(state.groupMembers).map((member){
      if(member.id == event.selectedId){
        return member.copyWith(isSelected: false);
      }
      return member;
    }).toList();

    // Remove member from the list
    addedMemberList.removeWhere((member) => member.id == event.selectedId);

    // Emit the new updated list
    emit(state.copyWith(
      addedGroupMembers: addedMemberList,
      groupMembers: updateSelectedMemberList
    ));

  }

  FutureOr<void> _onLoadMembers(LoadMembers event, Emitter<ChatGroupState> emit) {
    final List<GroupMemberEntity> list = [
      GroupMemberEntity(
        id: "1",
        fullName: "Arjay Doe",
        profileAvatar: AppImages.profile,
        status: "Online",
      ),
      GroupMemberEntity(
        id: "2",
        fullName: "Jay Doe",
        profileAvatar: AppImages.profile,
        status: "Online",
      ),
      GroupMemberEntity(
        id: "3",
        fullName: "Martin Doe",
        profileAvatar: AppImages.profile,
        status: "Online",
      ),
      GroupMemberEntity(
        id: "4",
        fullName: "John Doe",
        profileAvatar: AppImages.mountain,
        status: "Offline",
      ),
    ];

    list.sort((a,b) => a.fullName.compareTo(b.fullName));

    emit(state.copyWith(groupMembers: list));
  }
}
