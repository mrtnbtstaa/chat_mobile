class LogoutRequestDto {
  final String refreshToken;
  const LogoutRequestDto({required this.refreshToken});

  factory LogoutRequestDto.fromJson(Map<String, dynamic> json) => LogoutRequestDto(refreshToken: json["refresh_token"]);

  Map<String, dynamic> toJson() => {
    "refresh": refreshToken
  };
  
}