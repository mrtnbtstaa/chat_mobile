import 'package:chat/core/errors/server_failure.dart';
import 'package:chat/features/authentication/application/usecase/register_usecase.dart';
import 'package:chat/features/authentication/domain/params/register_param.dart';
import 'package:chat/features/authentication/domain/repositories/i_auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository{}


void main(){
  late MockAuthRepository mockAuthRepository;
  late RegisterUsecase registerUsecase;

  setUp((){
    mockAuthRepository = MockAuthRepository();
    registerUsecase = RegisterUsecase(authRepository: mockAuthRepository);
  });

  group("Register Usecase Execution", (){

    const tRegisterParam = RegisterParam(username: "martin", password: "martin", confirmPassword: "martin", profile: "image.png");

    test('Should return Unit from the repository when register is successful', () async {
    
      // Arrange
      when(() => mockAuthRepository.register(any(), any(), any(), any()))
      .thenAnswer((_) async => Right(unit));

      // Act
      final result = await registerUsecase(tRegisterParam);

      // Assert
      expect(result, const Right(unit));

      // Verify if the repository was actually called with the right data
      verify(() => mockAuthRepository.register("martin", "martin", "martin", "image.png")).called(1);
      verifyNoMoreInteractions(mockAuthRepository);

    });


    test('Should return a Failure when the register repository call is unsuccessful', () async {

      // Arrange
      when(() => mockAuthRepository.register(any(), any(), any(), any()))
      .thenAnswer((_) async => left(ServerFailure(message: "Something went wrong while registering", statusCode: 400)));

      // Act
      final result = await registerUsecase(tRegisterParam);

      // Assert
      expect(result, left(ServerFailure(message: "Something went wrong while registering", statusCode: 400)));

      verify(() => mockAuthRepository.register(any(), any(), any(), any())).called(1);
    });

  });

}