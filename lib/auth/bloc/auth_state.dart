part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthErrorState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthenticatingState extends AuthState {}
