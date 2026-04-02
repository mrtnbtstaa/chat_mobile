import 'package:chat/core/errors/server_failure.dart';
import 'package:chat/features/authentication/domain/entities/auth_entity.dart';
import 'package:chat/features/authentication/domain/entities/token_entity.dart';
import 'package:chat/features/authentication/domain/params/login_param.dart';
import 'package:chat/features/authentication/domain/repositories/i_auth_repository.dart';
import 'package:chat/features/authentication/application/usecase/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository{}

void main() async {

  late MockAuthRepository mockAuthRepository;
  late LoginUsecase loginUsecase;

  setUp((){
    mockAuthRepository = MockAuthRepository();
    loginUsecase = LoginUsecase(authRepository: mockAuthRepository);
  });

  group("Login Usecase Execution", (){

    
  const tLoginParam = LoginParam(email: "tin", password: "123");
  const tAuthEntity = AuthEntity(
    userId: "1",
    email: "martin",
    tokens: TokenEntity(accessToken: "access123", refreshToken: "refresh123"),
    profile: "image.png"
  );

    test("Should return AuthEntity from the repository when login is successful", () async {

      // Arrange
      when(() => mockAuthRepository.login(any(), any()))
      .thenAnswer((_) async => Right(tAuthEntity));

      // Act
      final result = await loginUsecase(tLoginParam);

      // Assert
      expect(result, const Right(tAuthEntity));

      // Verify if the repository was actually called with the right data
      verify(() => mockAuthRepository.login("tin", "123")).called(1);
      verifyNoMoreInteractions(mockAuthRepository);

    });

    test('Should return a Failure when the repository call is unsuccessful', () async {

      // Arrange
      when(() => mockAuthRepository.login(any(), any()))
      .thenAnswer((_) async => Left(ServerFailure(message: "Invalid Credentials", statusCode: 401)));

      // Act
      final result = await loginUsecase(tLoginParam);

      // Assert
      expect(result, Left(ServerFailure(message: 'Invalid Credentials', statusCode: 401)));

      verify(() => mockAuthRepository.login(any(), any())).called(1);

    });

  }); 

} 