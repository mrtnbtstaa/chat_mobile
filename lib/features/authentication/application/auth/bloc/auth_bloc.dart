import 'dart:async';

import 'package:chat/core/di/di.dart';
import 'package:chat/core/events/auth_events.dart';
import 'package:chat/core/events/event_bus.dart';
import 'package:chat/core/services/session_manager.dart';
import 'package:chat/core/usecases/base_usecase.dart';
import 'package:chat/core/utils/flutter_secure_storage_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final BaseUsecase<Unit, String> _logoutUseCase;
  AuthBloc({required BaseUsecase<Unit, String> logoutUseCase}) : _logoutUseCase = logoutUseCase, super(AuthInitial()) {
    
    EventBus().on<LogoutEvent>().listen((event){
      add(LogoutRequested());
    });

    on<LogoutRequested>(_onLogoutRequested);
  }

  FutureOr<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {

    final refreshToken = await FlutterSecureStorageManager.instance?.getRefreshToken() ?? "";
    final result = await _logoutUseCase(refreshToken);

    result.fold(
      (failure) => emit(AuthError()),
      (_){
        emit(Unauthenticated());
      }
    );

  }
}
