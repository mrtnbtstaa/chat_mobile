import 'dart:async';
import 'package:chat/core/di/di_exports.dart';
import 'package:flutter/foundation.dart';

import '../../models/entities/group_member_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/entities/paginated_group_member.dart';


part 'chat_group_event.dart';
part 'chat_group_state.dart';

class ChatGroupBloc extends Bloc<ChatGroupEvent, ChatGroupState> {

  final BaseUsecase<PaginatedGroupMember, String?> _listGroupChatUseCase;

  ChatGroupBloc({required BaseUsecase<PaginatedGroupMember, String?> listGroupChatUseCase}) :
  _listGroupChatUseCase = listGroupChatUseCase,
  super(ChatGroupState()) {
    on<LoadMembers>(_onLoadMembers);
    on<SelectMember>(_onSelectMember);
    on<RemoveMember>(_onRemoveMember);
  }

  FutureOr<void> _onSelectMember(SelectMember event, Emitter<ChatGroupState> emit) {

    // Update the group members 
    final updatedGroupMember = state.groupMembers?.map((group){
      if(group.userId == event.selectedId){
        return group.copyWith(isSelected: event.isSelected);
      }
      return group;
    });

    // Get all the added members
    final addedMembers = updatedGroupMember?.where((m) => m.isSelected).toList();

    emit(state.copyWith(
      groupMembers: updatedGroupMember?.toList(),
      addedGroupMembers: addedMembers
    ));

    // Emit a state with the updated and added group members
  

  }

  FutureOr<void> _onRemoveMember(RemoveMember event, Emitter<ChatGroupState> emit) {

    final addedMemberList = List<GroupMemberEntity>.from(state.addedGroupMembers ?? []);

    // Update the `isSelected` to false
    final updateSelectedMemberList = List<GroupMemberEntity>.from(state.groupMembers ?? []).map((member){
      if(member.userId == event.selectedId){
        return member.copyWith(isSelected: false);
      }
      return member;
    }).toList();

    // Remove member from the list
    addedMemberList.removeWhere((member) => member.userId == event.selectedId);

    emit(state.copyWith(
      addedGroupMembers: addedMemberList,
      groupMembers: updateSelectedMemberList
    ));

   

  }

  FutureOr<void> _onLoadMembers(LoadMembers event, Emitter<ChatGroupState> emit) async {

    print("Executing On Load Members!");

    final resultUseCase = await _listGroupChatUseCase(null);

    return await resultUseCase.fold(
      (failure){
        if(kDebugMode){
          print("Failure: ${failure.message}, ${failure.error}, ${failure.code}, ${failure.statusCode}");
        }
        emit(ChatGroupError());
      },
      (entity){
        
        if(kDebugMode){
          print("On Load members: ${entity.results.length}");
        }

        emit(state.copyWith(
          groupMembers: entity.results,
          addedGroupMembers: state.addedGroupMembers,
          nextCursor: entity.next,
          previousCursor: entity.previous
        ));
        
      } 
    );

  }
}
