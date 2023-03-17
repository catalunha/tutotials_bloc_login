import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;
  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(LoginState.initial()) {
    on<LoginEventFormSubmitted>(_onLoginEventFormSubmitted);
  }

  FutureOr<void> _onLoginEventFormSubmitted(
      LoginEventFormSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStateStatus.loading));
    try {
      await _authenticationRepository.logIn(
          username: event.username, password: event.password);
      emit(state.copyWith(status: LoginStateStatus.success));
    } catch (_) {
      emit(state.copyWith(
          status: LoginStateStatus.error, error: 'Falha no login'));
    }
  }
}
