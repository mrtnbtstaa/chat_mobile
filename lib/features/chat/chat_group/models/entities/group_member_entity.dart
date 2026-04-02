class GroupMemberEntity {
  final String id;
  final String profileAvatar;
  final String fullName;
  final String status;
  final bool isSelected;

  GroupMemberEntity({
    required this.id,
    required this.profileAvatar,
    required this.fullName,
    required this.status,
    this.isSelected = false,
  });

  GroupMemberEntity copyWith({bool? isSelected}) {
    return GroupMemberEntity(
      id: id,
      profileAvatar: profileAvatar,
      fullName: fullName,
      status: status,
      isSelected: isSelected ?? this.isSelected
    );
  }

}
