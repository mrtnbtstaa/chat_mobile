import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable{

  // final String userId;
  final String profileUrl;

  const ProfileEntity({
    // required this.userId,
    required this.profileUrl
  });

  @override
  List<Object?> get props => [profileUrl];

}