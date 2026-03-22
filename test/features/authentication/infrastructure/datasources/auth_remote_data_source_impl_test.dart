import 'dart:convert';

import 'package:chat/core/errors/server_failure.dart';
import 'package:chat/core/interceptors/auth_interceptor.dart';
import 'package:chat/core/services/session_manager.dart';
import 'package:chat/features/authentication/infrastructure/datasources/local/auth_local_data_source_impl.dart';
import 'package:chat/features/authentication/infrastructure/datasources/remote/auth_remote_data_source_impl.dart';
import 'package:chat/features/authentication/infrastructure/datasources/remote/i_remote_auth_data_source.dart';
import 'package:chat/features/authentication/infrastructure/dtos/request/login_request_dto.dart';
import 'package:chat/features/authentication/infrastructure/dtos/request/refresh_token_request_dto.dart';
import 'package:chat/features/authentication/infrastructure/dtos/response/login_response_dto.dart';
import 'package:chat/features/authentication/infrastructure/dtos/request/logout_request_dto.dart';
import 'package:chat/features/authentication/infrastructure/dtos/response/refresh_token_response_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

class MockHttpClient extends Mock implements http.Client {}
class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage{}
class MockBaseResponse extends Fake implements BaseResponse{}
class MockAuthRemoteDataSource extends Mock implements IRemoteAuthDataSource{}
class FakeUri extends Fake implements Uri {}
class MockSessionManager extends Mock implements SessionManager{}
class MockRetry extends Mock{
  Future<http.Response> call();
}

class TestInterceptor extends AuthInterceptor{
  TestInterceptor(super.flutterSecureStorage, super.sessionManager, {required this.refreshResult});

  final bool refreshResult;

  @override
  Future<bool> _tryRefreshToken() async => refreshResult;
}


void main() async {

  final tLoginRequest = {"username": "tin", "password": "123"};
  final tRegisterRequest = {
    "username": "tin",
    "password": "123",
    "confirm_password": "123",
    "profile": ""
  };
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late AuthLocalDataSourceImpl localDataSourceImpl;
  late MockFlutterSecureStorage mockFlutterSecureStorage;
  late MockHttpClient mockHttpClient;
  late MockSessionManager mockSessionManager;
  late AuthInterceptor authInterceptor;
  late SessionManager sessionManager;

  setUpAll((){
    registerFallbackValue(FakeUri());
  });

  setUp((){
    mockHttpClient = MockHttpClient();
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(client: mockHttpClient);
    localDataSourceImpl = AuthLocalDataSourceImpl(flutterSecureStorage: mockFlutterSecureStorage);
    sessionManager = SessionManager(localDataSourceImpl);
    authInterceptor = AuthInterceptor(mockFlutterSecureStorage, sessionManager);
    mockSessionManager = MockSessionManager();
  });

  group("AuthRemoteDataSource Execution", (){

    test("Should return LoginResponseDTO when the response is 200", () async {

      final successfulResponse = jsonEncode({
        "user_id": "1",
        "username": "tin",
        "tokens": {
          "access_token": "token",
          "refresh_token": "ref",
        },
        "profile": "image.png"
      });

      // Arrange
      when(() => mockHttpClient.post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers')
      ))
      .thenAnswer((_) async => http.Response(successfulResponse, 200));

      // Act
      final result = await authRemoteDataSourceImpl.login(LoginRequestDto(username: "tin", password: "123"));

      // Assert
      expect(result.isRight(), true);

      result.fold(
        (failure) => fail("Should not return a failure"),
        (dto) => expect(dto, isA<LoginResponseDto>())
      );

      verify(() => mockHttpClient.post(any(), body: any(named: 'body'), headers: any(named: 'headers'))).called(1);

    });


    test("Should return a Failure when the response code is 401 (Unauthorized)", () async {
      // Arrange
      when(() => mockHttpClient.post(any(), body: any(named: 'body'), headers: any(named: "headers")))
      .thenAnswer((_) async => http.Response(jsonEncode({
        "message": "Unauthorized"
      }), 401));

      // Act
      final result = await authRemoteDataSourceImpl.login(LoginRequestDto(username: "tin", password: "123"));

      //Assert
      expect(result.isLeft(), true);

      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (dto) => fail("Should not return a LoginResponseDto")
      );

    });

    test("Should return Unit when the response is 201", () async {

      final successfulResponse = jsonEncode({
        "message": "Account successfully created"
      });

      // Arrange
      when(() => mockHttpClient.post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers')
      ))
      .thenAnswer((_) async => http.Response(successfulResponse, 201));

      try{
        // Act
        final result = await authRemoteDataSourceImpl.register(tRegisterRequest);

        // Assert
        expect(result.isRight(), true);

        result.fold(
          (failure) => fail('Test failed with: ${failure.message} (Status: ${failure.statusCode})'),
          (unit) => expect(unit, isA<Unit>())
        );

      }catch(e){
        if(kDebugMode){
          print("Caught error in test: $e");
        }
      }

      verify(() => mockHttpClient.post(any(), body: any(named: 'body'), headers: any(named: 'headers'))).called(1);

    });

    test("Should return a ServerFailure with username error when the response is 400", () async {

      final errorResponse = jsonEncode({
        "message": "Username was already taken"
      });

      // Arrange
      when(() => mockHttpClient.post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers')
      ))
      .thenAnswer((_) async => http.Response(errorResponse, 400));

      try{
        // Act
        final result = await authRemoteDataSourceImpl.register(tRegisterRequest);

        // Assert
        expect(result.isLeft(), true);

        result.fold(
          (failure) {
            expect(failure.message, "Username was already taken");
            expect(failure.statusCode, 400);
            expect(failure, isA<ServerFailure>());
          },
          (unit) => fail("Expected a failure due to username taken")
        );

      }catch(e){
        //
      }

      verify(() => mockHttpClient.post(any(), body: any(named: 'body'), headers: any(named: 'headers'))).called(1);

    });

    test('Should return a Unit when the logout response is 200', () async {

      const tLogoutRequest = LogoutRequestDto(refreshToken: "refreshKey");

      // Arrange
      when(() => mockHttpClient.post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers')
      )).thenAnswer((_) async => http.Response(jsonEncode({
        "message": "Successfully logged out"
      }), 200));

      try{
        // Act
        final result = await authRemoteDataSourceImpl.logout(tLogoutRequest.toJson());


        return result.fold(
          (failure) => fail("Should not return failure: ${failure.message}, ${failure.statusCode}"), 
          (unit){
            expect(unit, isA<Unit>());
          }
        );

        
      }catch(e){
        //
      }

      verify(() => mockHttpClient.post(any(), body: any(named: 'body'), headers: any(named: 'headers'))).called(1);
    });

    test('Should return a ServerFailure with refresh token error when the response is 400', () async {

      const tLogoutRequest = LogoutRequestDto(refreshToken: "refreshKey");

      // Arrange
      when(() => mockHttpClient.post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers')
      )).thenAnswer((_) async => http.Response(jsonEncode({
        "message": "Something went wrong when trying to logout"
      }), 400));

      try{
        // Act
        final result = await authRemoteDataSourceImpl.logout(tLogoutRequest.toJson());

        // Assert
        expect(result.isLeft(), true);

        return result.fold(
          (failure){
            expect(failure.message, "Something went wrong when trying to logout");
            expect(failure.statusCode, 400);
            expect(failure, isA<ServerFailure>());
          },
          (_) => fail("Expected a failure due to refresh token error")
        );

      }catch(e){
        //
      }

      verify(() => mockHttpClient.post(any(), body: any(named: 'body'), headers: any(named: 'headers'))).called(1);
   
    });

    test('Should not be able to login if no X-Access-Token passed from the header', () async {

        final successfulResponse = jsonEncode({
          "user_id": "1",
          "username": "tin",
          "tokens": {
            "access_token": "token",
            "refresh_token": "ref",
          },
          "profile": "image.png"
        });

        // Arrange
        when(() => mockHttpClient.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers')
        ))
        .thenAnswer((_) async => http.Response(successfulResponse, 200));

        // Act
        final result = await authRemoteDataSourceImpl.login(LoginRequestDto(username: "123", password: "123"));

        // Assert
        expect(result.isRight(), true);

        result.fold(
          (failure) => fail("Should not return a failure"),
          (dto) => expect(dto, isA<LoginResponseDto>())
        );

        verify(() => mockHttpClient.post(any(), body: any(named: 'body'), headers: any(named: 'headers'))).called(1);

      });

    test('Verify the added X-ACCESS-TOKEN header when token exists', () async {

      const tAcessToken = "access_token";
      // Arrange
      when(() => mockFlutterSecureStorage.read(key: 'access_token'))
      .thenAnswer((_) async => tAcessToken);

      final request = Request('GET', Uri.parse("https://api.com"));

      // Act
      final result = await authInterceptor.interceptRequest(request: request);

      // Assert
      expect(result.headers["X-ACCESS-TOKEN"], tAcessToken);
    });

    test('Should throw exception when access token is missing', () {

      // Arrange
      when(() => mockFlutterSecureStorage.read(key: 'access_token'))
      .thenAnswer((_) async => null);

      try{
        // Act & Assert
        expect(
          () => authInterceptor.interceptRequest(request: Request('GET', Uri.parse('https://api.com'))),
          throwsA(isA<Exception>())
        );
      }catch(e){
        if(kDebugMode){
          print("Caught an error $e");
        }
      }

    });

    test('Should call logout when response status is 401', () async {

      // Arrange
      final response = Response('Unauthorized', 401);

      when(() => mockFlutterSecureStorage.deleteAll())
      .thenAnswer((_) async => {});

      // Act
      await authInterceptor.interceptResponse(response: response);

      //Arrange
      verify(() => mockFlutterSecureStorage.deleteAll()).called(1);
  
    });

    test('Should set status to unauthenticated if no token found in FlutterSecureStorage', () async {

      // Arrange
      when(() => mockFlutterSecureStorage.read(key: 'access_token'))
      .thenAnswer((_) async => null);

      // Act
      await sessionManager.initialize();

      // Assert
      expect(sessionManager.value, AuthStatus.unauthenticated);


    });

    test('Should set status to authenticated if token found in FlutterSecureStorage', () async {

      const tAccess = "access_token";

      // Arrange
      when(() => mockFlutterSecureStorage.read(key: 'access_token'))
      .thenAnswer((_) async => tAccess);

      // Act
      await sessionManager.initialize();

      // Assert
      expect(sessionManager.value, AuthStatus.authenticated);

    });


    test('returns response if statusCode is not 401', () async {
      
      // Arrange
      final response = http.Response("ok", 200);

      final interceptor = TestInterceptor(
        mockFlutterSecureStorage,
        mockSessionManager,
        refreshResult: false
      );

      // Act
      final result = await authInterceptor.interceptResponse(response: response);

      // Assert
      expect(result.statusCode, 200);

      verifyNever(() => mockFlutterSecureStorage.deleteAll());
      verifyNever(() => mockSessionManager.logout());
   
    });

    test('401 + refresh token -> retries and return new response', () async {
      
      // Arrange
      final response = Response("Unauthorized", 401);
      final retryResponse = Response("ok", 200);
      final tTokenDTO = RefreshTokenResponseDto(accessToken: 'new_access_token', refreshToken: 'new_refresh_token');

      final mockRetry = MockRetry();

      when(() => mockRetry.call())
      .thenAnswer((_) async => retryResponse);

      when(() => mockFlutterSecureStorage.read(key: any(named: 'key')))
      .thenAnswer((_) async => 'old_refresh_token');

      when(() => mockFlutterSecureStorage.write(key: any(named: 'key'), value: any(named: 'value')))
      .thenAnswer((_) async => Future.value());

      when(() => mockAuthRemoteDataSource.refresh(any()))
      .thenAnswer((_) async => Right(tTokenDTO));

      final interceptor = TestInterceptor(
        mockFlutterSecureStorage,
        mockSessionManager,
        refreshResult: true
      );

      // Act
      final result = await interceptor.interceptResponse(response: response);


      // Assert
      expect(result.statusCode, 200);

      verify(() => mockAuthRemoteDataSource.refresh(RefreshTokenRequestDto("old_refresh_token"))).called(1);
      verify(() => mockFlutterSecureStorage.write(key: 'access_token', value: 'new_access_token')).called(1);
      verify(() => mockRetry.call()).called(1);

      verifyNever(() => mockSessionManager.logout());
      verifyNever(() => mockFlutterSecureStorage.deleteAll());
    
    });

    test('401 + refresh fail -> logout and clear storage', () async {
      
      // Arrange
      when(() => mockFlutterSecureStorage.deleteAll())
      .thenAnswer((_) async {});
      when(() => mockSessionManager.logout()).thenReturn(null);

      final interceptor = TestInterceptor(
        mockFlutterSecureStorage,
        mockSessionManager,
        refreshResult: false,
      );


      final response = http.Response("Unauthorized", 401);

      // Act 
      final result = await interceptor.interceptResponse(
        response: response,
      );

      // Assert
      expect(result.statusCode, 401);

      verify(() => mockFlutterSecureStorage.deleteAll()).called(1);
      verify(() => mockSessionManager.logout()).called(1);

    });

    

  });

}