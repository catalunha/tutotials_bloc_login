import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository,
      required UserRepository userRepository})
      : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<_AuthenticationEventStatusChanged>(_onAuthenticationEventStatusChanged);
    on<AuthenticationEventLogoutRequested>(
        _onAuthenticationEventLogoutRequested);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(_AuthenticationEventStatusChanged(status)),
    );
  }
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  FutureOr<void> _onAuthenticationEventStatusChanged(
      _AuthenticationEventStatusChanged event,
      Emitter<AuthenticationState> emit) async {
    if (event.status == AuthenticationStatus.unauthenticated) {
      return emit(const AuthenticationState.unauthenticated());
    } else if (event.status == AuthenticationStatus.authenticated) {
      final user = await _tryGetUser();
      return emit(user != null
          ? AuthenticationState.authenticated(user)
          : const AuthenticationState.unauthenticated());
    } else {}
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }

  FutureOr<void> _onAuthenticationEventLogoutRequested(
      AuthenticationEventLogoutRequested event,
      Emitter<AuthenticationState> emit) {
    _authenticationRepository.logOut();
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }
}
