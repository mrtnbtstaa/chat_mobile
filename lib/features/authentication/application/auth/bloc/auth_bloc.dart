import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:chat/core/contracts/i_token_storage.dart';
import 'package:chat/core/di/di.dart';
import 'package:chat/core/services/session_manager.dart';
import 'package:chat/core/usecases/base_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final BaseUsecase<Unit, String> _logoutUseCase;
  final ITokenStorage _tokenStorage;
  AuthBloc({required BaseUsecase<Unit, String> logoutUseCase, required ITokenStorage tokenStorage}) 
  : _logoutUseCase = logoutUseCase, _tokenStorage = tokenStorage,
  super(AuthInitial()) {
    on<LogoutRequested>(_onLogoutRequested, transformer: droppable());
  }

  FutureOr<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    
    final refreshToken = await _tokenStorage.getRefreshToken() ?? "";
    if(kDebugMode && refreshToken.isNotEmpty){
      print("Logout requested event fired!");
    }
    final result = await _logoutUseCase(refreshToken);

    result.fold(
      (failure) async{
        emit(AuthError());
      },
      (_) async {
        await sl<SessionManager>().logout();
      }
    );

  }
}
