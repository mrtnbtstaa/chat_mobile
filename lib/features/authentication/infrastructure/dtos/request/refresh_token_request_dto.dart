class RefreshTokenRequestDto {
  final String accessToken;
  const RefreshTokenRequestDto(this.accessToken);

  Map<String, dynamic> toJson() => {
    "refresh": accessToken
  };

}