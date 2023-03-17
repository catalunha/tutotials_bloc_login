part of 'authentication_bloc.dart';

class AuthenticationState {
  final AuthenticationStatus status;
  final User user;
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });
  const AuthenticationState.unknown() : this._();
  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);
  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthenticationState &&
        other.status == status &&
        other.user == user;
  }

  @override
  int get hashCode => status.hashCode ^ user.hashCode;
}
