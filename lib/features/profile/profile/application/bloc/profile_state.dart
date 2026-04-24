part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {

  final String? imagePath;
  final String? error;
  final String? imageUrl;

  const ProfileState({this.imagePath, this.error, this.imageUrl});
  
  @override
  List<Object> get props => [?imagePath, ?error, ?imageUrl];
}

final class ProfileInitial extends ProfileState {}

final class ProfileUploaded extends ProfileState{
  const ProfileUploaded({super.imagePath});
}

final class ProfileError extends ProfileState{
  const ProfileError({super.error});
}

final class ProfileSuccess extends ProfileState{
  const ProfileSuccess({super.imageUrl});
}