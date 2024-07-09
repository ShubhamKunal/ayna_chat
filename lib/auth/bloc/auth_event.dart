// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthenticateEvent extends AuthEvent {
  BuildContext context;
  String email;
  String password;
  AuthenticateEvent({
    required this.context,
    required this.email,
    required this.password,
  });
}

class SigningEvent extends AuthEvent {
  BuildContext context;
  String email;
  String password;
  SigningEvent({
    required this.context,
    required this.email,
    required this.password,
  });
}

class LogoutEvent extends AuthEvent {
  BuildContext context;
  LogoutEvent({
    required this.context,
  });
}
