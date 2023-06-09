import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    print('SplashPage');
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
