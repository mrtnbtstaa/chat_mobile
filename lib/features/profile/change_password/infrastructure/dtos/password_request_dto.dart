class PasswordRequestDto {

  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const PasswordRequestDto({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword
  });

  Map<String, dynamic> toJson(){
    return {
      "current_password": currentPassword,
      "new_password": newPassword,
      "confirm_password": confirmPassword
    };
  }

}