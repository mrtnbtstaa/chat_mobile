class LoginRequestDto {

  final String username;
  final String password;

  const LoginRequestDto({
    required this.username,
    required this.password
  });

  factory LoginRequestDto.fromJson(Map<String, dynamic> json){
    return LoginRequestDto(username: json["username"], password: json["password"]);
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password
  };

}