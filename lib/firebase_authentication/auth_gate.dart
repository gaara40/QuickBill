import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/global_providers/auth_state_providers.dart';
import 'package:quick_bill/navigation/main_navigation.dart';
import 'package:quick_bill/screens/login_screen.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(authStateProvider);
    if (userAsync.isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (userAsync.value != null) {
      return const MainNavigation();
    } else {
      return const LoginScreen();
    }
  }
}
