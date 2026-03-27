class VerifyTokenResponseDto {

  final String status;

  VerifyTokenResponseDto({
    required this.status
  });


  factory VerifyTokenResponseDto.fromJson(Map<String, dynamic> json){
    return VerifyTokenResponseDto(status: json["status"]);
  }

  Map<String, dynamic> toJson() => {
    "status": status
  };

}