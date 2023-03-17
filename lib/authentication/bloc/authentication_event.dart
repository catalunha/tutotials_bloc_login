part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class _AuthenticationEventStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus status;
  const _AuthenticationEventStatusChanged(this.status);
}

class AuthenticationEventLogoutRequested extends AuthenticationEvent {}
