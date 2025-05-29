import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_bill/global_providers/auth_state_providers.dart';
import 'package:quick_bill/screens/dashboard_screen.dart';
import 'package:quick_bill/screens/login_screen.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (_) => authState.when(
                data: (user) {
                  if (user != null) {
                    return DashboardScreen();
                  } else {
                    return LoginScreen();
                  }
                },
                error: (error, st) {
                  return Center(child: Text('$error'));
                },
                loading: () => CircularProgressIndicator(color: Colors.white),
              ),
        ),
      );
    });
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 3),
            const Icon(
              Icons.receipt_long_rounded,
              color: Colors.white,
              size: 100,
            ),
            const SizedBox(height: 20),
            Text(
              'QuickBill',
              style: GoogleFonts.robotoSlab(
                fontSize: 28,
                letterSpacing: 1.2,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(flex: 2),

            const CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
