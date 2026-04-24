import 'package:equatable/equatable.dart';

class GroupMemberEntity extends Equatable {
  final String userId;
  final String? profileAvatar;
  final String fullName;
  final bool isOnline;
  final bool isSelected;

  const GroupMemberEntity({
    required this.userId,
    required this.profileAvatar,
    required this.fullName,
    required this.isOnline,
    this.isSelected = false,
  });

  GroupMemberEntity copyWith({bool? isSelected}) {
    return GroupMemberEntity(
      userId: userId,
      profileAvatar: profileAvatar,
      fullName: fullName,
      isOnline: isOnline,
      isSelected: isSelected ?? this.isSelected
    );
  }
  
  @override
  List<Object?> get props => [userId, profileAvatar, fullName, isOnline, isSelected];
}
