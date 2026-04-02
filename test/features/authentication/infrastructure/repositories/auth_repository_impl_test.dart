import 'package:chat/features/authentication/application/usecase/register_usecase.dart';
import 'package:chat/features/authentication/domain/entities/auth_entity.dart';
import 'package:chat/features/authentication/domain/entities/token_entity.dart';
import 'package:chat/features/authentication/domain/params/login_param.dart';
import 'package:chat/features/authentication/domain/params/register_param.dart';
import 'package:chat/features/authentication/domain/repositories/i_auth_repository.dart';
import 'package:chat/features/authentication/application/usecase/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements IAuthRepository {}

void main() async {

  late MockUserRepository mockUserRepository;
  late LoginUsecase loginUsecase;
  late RegisterUsecase registerUsecase;

  setUp((){
    mockUserRepository = MockUserRepository();
    loginUsecase = LoginUsecase(authRepository: mockUserRepository);
    registerUsecase = RegisterUsecase(authRepository: mockUserRepository);
  });

  group('AuthRepository Execution', () {
    
    test("Should call login on the repository", () async {
    
      // Arrange
      when(() => mockUserRepository.login(any(), any()))
      .thenAnswer((_) async => Right(AuthEntity(
        userId: "1",
        email: "martin",
        tokens: TokenEntity(accessToken: "access123", refreshToken: "refresh123"),
        profile: "image.png"
      )));

      // Act
      await loginUsecase(LoginParam(email: "tin", password: "123"));

      // Assert
      verify(() => mockUserRepository.login("tin", "123")).called(1);

    });

    test("Should call register on the repository", () async {
    
      // Arrange
      when(() => mockUserRepository.register(any(), any(), any(), any()))
      .thenAnswer((_) async => Right(unit));

      // Act
      await registerUsecase(RegisterParam(
        username: "martin",
        password: "tin",
        confirmPassword: "tin",
        profile: "image.png"
      ));

      // Assert
      verify(() => mockUserRepository.register(
        "martin", "tin", "tin", "image.png"
      )).called(1);

    });

  });

}