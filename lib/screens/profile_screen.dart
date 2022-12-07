import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:step/color_schemes.dart';
import 'package:step/screens/home_screen.dart';

import 'package:step/vm/login_controller.dart';

class ProfileScreen extends StatefulHookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Signout"),
          onPressed: () {
            ref.read(loginControllerProvider.notifier).signOut();
          },
        ),
      ),
    );
  }
}
