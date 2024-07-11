import 'dart:async';

import 'package:ayna_chat/auth/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:developer';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthenticateEvent>(authenticateEvent);
    on<SigningEvent>(signingEvent);
    on<LogoutEvent>(logoutEvent);
  }

  FutureOr<void> authenticateEvent(
      AuthenticateEvent event, Emitter<AuthState> emit) async {
    emit(AuthenticatingState());
    var user = await AuthenticationRepository().logIn(
        context: event.context, email: event.email, password: event.password);

    log(user.toString());
    if (user != null) {
      Navigator.popUntil(event.context, (route) => route.isFirst);
      event.context.go("/home");
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState());
    }
  }

  FutureOr<void> logoutEvent(LogoutEvent event, Emitter<AuthState> emit) {
    AuthenticationRepository().logOut(event.context);
    event.context.go("/");
  }

  FutureOr<void> signingEvent(
      SigningEvent event, Emitter<AuthState> emit) async {
    emit(AuthenticatingState());
    var user = await AuthenticationRepository().signUp(
        context: event.context, email: event.email, password: event.password);
    if (user != null) {
      Navigator.popUntil(event.context, (route) => route.isFirst);
      event.context.go("/home");
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState());
    }
  }
}
