part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {

  const RegisterState({
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.imagePath = ""
  });

  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final String imagePath;
  
  @override
  List<Object> get props => [isPasswordVisible, isConfirmPasswordVisible];
}

final class RegisterInitial extends RegisterState {
  const RegisterInitial({super.isPasswordVisible, super.isConfirmPasswordVisible, super.imagePath});
}

final class RegisterLoading extends RegisterState{
  const RegisterLoading({super.isPasswordVisible, super.isConfirmPasswordVisible, super.imagePath});
}

final class RegisterSuccess extends RegisterState{
  const RegisterSuccess({super.isPasswordVisible, super.isConfirmPasswordVisible, super.imagePath});
}

final class RegisterPickedImage extends RegisterState{
  const RegisterPickedImage({super.isPasswordVisible, super.isConfirmPasswordVisible, super.imagePath});
}

final class RegisterError extends RegisterState{
  const RegisterError({required this.errorMessage, super.isPasswordVisible, super.isConfirmPasswordVisible, super.imagePath});
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage, ...super.props];
}
