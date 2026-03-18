class RegisterRequestDto {

  final String username;
  final String password;
  final String confirmPassword;
  final String? profile;

  const RegisterRequestDto({
    required this.username,
    required this.password,
    required this.confirmPassword,
    this.profile
  });

  factory RegisterRequestDto.fromJson(Map<String, dynamic> json){
    return RegisterRequestDto(
      username: json["username"],
      password: json["password"],
      confirmPassword: json["confirm_password"],
      profile: json["profile"] ?? ""
    );
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "confirm_password": confirmPassword,
    "profile": profile ?? ""
  };

}