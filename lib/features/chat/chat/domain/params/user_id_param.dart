class UserIdParam {
  final String userId;
  const UserIdParam({
    required this.userId
  });

  Map<String, dynamic> toJson() => {
    "user_id": userId
  };

}