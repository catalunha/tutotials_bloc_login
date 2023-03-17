part of 'login_bloc.dart';

enum LoginStateStatus { initial, loading, success, error }

class LoginState {
  final LoginStateStatus status;
  final String? error;
  final String username;
  final String password;
  LoginState({
    required this.status,
    this.error,
    required this.username,
    required this.password,
  });
  LoginState.initial()
      : status = LoginStateStatus.initial,
        error = '',
        username = '',
        password = '';

  LoginState copyWith({
    LoginStateStatus? status,
    String? error,
    String? username,
    String? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      error: error ?? this.error,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginState &&
        other.status == status &&
        other.error == error &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        error.hashCode ^
        username.hashCode ^
        password.hashCode;
  }
}
