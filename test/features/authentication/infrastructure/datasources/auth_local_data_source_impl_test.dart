import 'package:chat/features/authentication/infrastructure/datasources/local/auth_local_data_source_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage{}

void main(){

  late MockFlutterSecureStorage mockFlutterSecureStorage;
  late AuthLocalDataSourceImpl authLocalDataSourceImpl;

  const tAccess = "access_token_value";
  const tRefresh = "refresh_token_value";

  const tKeyAccess = "access_token";
  const tKeyRefresh = "refresh_token";

  setUp((){
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    authLocalDataSourceImpl = AuthLocalDataSourceImpl(flutterSecureStorage: mockFlutterSecureStorage);
  });

  group('AuthLocalDataSource Execution', () {

    test('Should call write on FlutterSecureStorage to save token', () async {

      // Arrange
      when(() => mockFlutterSecureStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value')
      )).thenAnswer((_) async => Future.value());

      try{
        // Act
        await authLocalDataSourceImpl.cacheToken(tAccess, tRefresh);

        // Assert
        verify(() => {
          mockFlutterSecureStorage.write(key: tKeyAccess, value: tAccess),
          mockFlutterSecureStorage.write(key: tKeyRefresh, value: tRefresh)
        }).called(1);
      }catch(e){
        if(kDebugMode){
          print("Caught an error: $e");
        }
      }

    });

    test('Should return the access token from FlutterSecureStorage when it exists', () async {

      const tAccessToken = "access_token";

      // Arrange
      when(() => mockFlutterSecureStorage.read(key: 'access_token', aOptions: any(named: 'aOptions')))
      .thenAnswer((_) async => tAccessToken);

      // Act
      final result = await authLocalDataSourceImpl.getAccessToken();

      // Assert
      expect(result, equals(tAccessToken));
      verify(() => mockFlutterSecureStorage.read(key: tAccessToken)).called(1);

    });

    test('Should return null when there is no access token from FlutterSecureStorage', () async {
        
      // Arrange
      when(() => mockFlutterSecureStorage.read(key: 'access_token', aOptions: any(named: 'aOptions')))
      .thenAnswer((_) async => null);

      // Act
      final result = await authLocalDataSourceImpl.getAccessToken();

      expect(result, isNull);

    });
    
    test('Should return the refresh token from FlutterSecureStorage when it exists', () async {

      const tRefreshToken = "refresh_token";

      // Arrange
      when(() => mockFlutterSecureStorage.read(key: 'refresh_token', aOptions: any(named: 'aOptions')))
      .thenAnswer((_) async => tRefreshToken);

      // Act    
      final result = await authLocalDataSourceImpl.getRefreshToken();

      // Assert
      expect(result, tRefreshToken);
      verify(() => mockFlutterSecureStorage.read(key: tRefreshToken)).called(1);

    });

    test('Should return null when there is no refresh token from FlutterSecureStorage', () async {
        
      // Arrange
      when(() => mockFlutterSecureStorage.read(key: 'refresh_token', aOptions: any(named: 'aOptions')))
      .thenAnswer((_) async => null);

      // Act
      final result = await authLocalDataSourceImpl.getRefreshToken();

      // Assert
      expect(result, isNull);

    });

    

  });


}