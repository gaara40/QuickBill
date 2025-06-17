import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quick_bill/firebase_options.dart';

import 'package:quick_bill/screens/splash_screen.dart';
import 'package:quick_bill/theme_data.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: QuickBillTheme.lightTheme,
      darkTheme: QuickBillTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: SplashScreen(),
    );
  }
}
