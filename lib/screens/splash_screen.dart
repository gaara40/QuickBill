import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_bill/firebase_authentication/auth_gate.dart';
import 'package:quick_bill/main.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(Duration(seconds: 2), () {
      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const AuthGate()),
        (route) => false,
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
