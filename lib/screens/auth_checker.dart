import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:step/providers/auth.dart';
import 'package:step/screens/login_page.dart';
import 'package:step/screens/nav_bar.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);

    return _authState.when(
        data: (user) {
          if (user != null) {
            return const NavigationScreen();
          }
          return const LoginPage();
        },
        loading: () => const SplashScreen(),
        error: (e, trace) {
          return const NavigationScreen();
        });
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
