part of 'chat_group_bloc.dart';

sealed class ChatGroupEvent extends Equatable {
  const ChatGroupEvent();

  @override
  List<Object> get props => [];
}

final class LoadMembers extends ChatGroupEvent{}

final class SelectMember extends ChatGroupEvent {

  final bool? isSelected;
  final String selectedId;

  const SelectMember({
    this.isSelected = false,
    this.selectedId = ""
  });

  @override
  List<Object> get props => [?isSelected, selectedId];

}
final class RemoveMember extends ChatGroupEvent{

  final String selectedId;

  const RemoveMember({
    this.selectedId = ""
  });

  
  @override
  List<Object> get props => [selectedId];

}