import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_bill/global_providers/theme_mode_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final systemBrightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode =
        themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system && systemBrightness == Brightness.dark);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Toggle card
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Dark Theme'),
                    Switch(
                      value: isDarkMode,
                      onChanged: (_) {
                        ref.read(themeModeProvider.notifier).toggleTheme();
                      },
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.construction, size: 80, color: Colors.grey),
                    SizedBox(height: 20),
                    Text(
                      'Settings under construction 🚧',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'More features coming soon — stay tuned!\nIn the meantime, feel free to toggle between light and dark themes above.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// appBar: AppBar(title: const Text('Settings')),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.construction, size: 80, color: Colors.grey),
//             const SizedBox(height: 20),
//             const Text(
//               'Settings under construction 🚧',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               'Things are coming soon.\nStay tuned',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 15, color: Colors.grey[600]),
//             ),
//             SizedBox(height: 40),
//             WittyMessagesWidget(),
//           ],
//         ),
//       ),