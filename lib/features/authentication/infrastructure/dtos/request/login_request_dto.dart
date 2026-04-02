class LoginRequestDto {

  final String email;
  final String password;

  const LoginRequestDto({
    required this.email,
    required this.password
  });

  factory LoginRequestDto.fromJson(Map<String, dynamic> json){
    return LoginRequestDto(email: json["email"], password: json["password"]);
  }

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password
  };

}