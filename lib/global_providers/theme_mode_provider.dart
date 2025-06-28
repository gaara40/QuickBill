import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  static const _key = 'theme_mode';
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadSavedTheme();
  }

  Future<void> _loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);

    if (saved == 'dark') {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.system;
    }
  }

  void toggleTheme() async {
    final newTheme =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    state = newTheme;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, newTheme == ThemeMode.dark ? 'dark' : 'light');

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor:
            newTheme == ThemeMode.dark ? Colors.black : null,
        systemNavigationBarIconBrightness:
            newTheme == ThemeMode.dark ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
            newTheme == ThemeMode.dark ? Brightness.light : Brightness.dark,
      ),
    );
  }

  void resetTheme() async {
    state = ThemeMode.system;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);

    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    final isDarkSystemTheme = brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: isDarkSystemTheme ? Colors.black : null,
        systemNavigationBarIconBrightness:
            isDarkSystemTheme ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
            isDarkSystemTheme ? Brightness.light : Brightness.dark,
      ),
    );
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(),
);
