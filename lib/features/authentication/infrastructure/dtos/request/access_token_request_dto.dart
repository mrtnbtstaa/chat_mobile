class AccessTokenRequestDto {
  final String accessToken;
  const AccessTokenRequestDto(this.accessToken);

  Map<String, dynamic> toJson() => {
    "access_token": accessToken
  };

}