class VerifyTokenRequestDto {

  final String accessToken;

  const VerifyTokenRequestDto({
    required this.accessToken
  });

  Map<String, dynamic> toJson() => {
    "token": accessToken
  };

}