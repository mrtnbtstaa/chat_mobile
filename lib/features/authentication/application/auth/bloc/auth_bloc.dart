import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../../../../core/contracts/i_token_storage.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/services/session_manager.dart';
import '../../../../../core/usecases/base_usecase.dart';
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
    
    emit(AuthLoading());

    final refreshToken = await _tokenStorage.getRefreshToken() ?? "";
    final result = await _logoutUseCase(refreshToken);

    result.fold(
      (failure) async{
        emit(AuthError());
      },
      (_) async {
        emit(AuthInitial());
        await sl<SessionManager>().logout();
      }
    );

  }
}
