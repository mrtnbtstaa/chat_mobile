class RegisterParam {

  final String username;
  final String password;
  final String confirmPassword;
  final String? profile;

  const RegisterParam({
    required this.username,
    required this.password,
    required this.confirmPassword,
    this.profile
  });

}