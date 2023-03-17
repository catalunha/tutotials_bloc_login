import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: BlocProvider(
          create: (context) => LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context)),
          child: const LoginView(),
        ));
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameTEC = TextEditingController();
  final _passwordTEC = TextEditingController();
  @override
  void dispose() {
    _usernameTEC.dispose();
    _passwordTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStateStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.error ?? '...')));
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _usernameTEC,
              decoration: const InputDecoration(label: Text('nome de usuario')),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Informação obrigatória';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordTEC,
              decoration: const InputDecoration(label: Text('senha')),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Informação obrigatória';
                }
                return null;
              },
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return state.status == LoginStateStatus.loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          final validate =
                              _formKey.currentState?.validate() ?? false;
                          if (validate) {
                            context.read<LoginBloc>().add(
                                  LoginEventFormSubmitted(
                                    username: _usernameTEC.text,
                                    password: _passwordTEC.text,
                                  ),
                                );
                          }
                        },
                        child: const Text('Login'),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
