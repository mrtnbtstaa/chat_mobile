import 'package:chat/features/profile/profile/domain/entities/profile_entity.dart';

class UploadProfileResponseDto extends ProfileEntity{
  const UploadProfileResponseDto({required super.profileUrl});

  factory UploadProfileResponseDto.fromJson(Map<String, dynamic> json){
    return UploadProfileResponseDto(
      profileUrl: json["profile"],
    );
  }

  ProfileEntity toEntity() => this;

}