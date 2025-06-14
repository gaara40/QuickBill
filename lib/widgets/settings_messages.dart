import 'dart:math';
import 'package:flutter/material.dart';

class WittyMessagesWidget extends StatelessWidget {
  WittyMessagesWidget({super.key});

  final List<String> messages = [
    'Patience is a virtue 😅',
    'Settings aren’t going to build themselves...',
    'You clicked it! Nothing happened... on purpose.',
    'Coming soon™️',
    'This button does *something*. Or does it?',
    'Why are you still clicking?',
    'Feature locked. Throw in a pizza 🍕',
    'Good things take time. Like this screen.',
    'You’re just one click away from... nothing.',
  ];

  void _showRandomDialog(BuildContext context) {
    final random = Random();
    final randomMessage = messages[random.nextInt(messages.length)];

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Heads Up!'),
            content: Text(randomMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Haha 😂'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showRandomDialog(context),
      child: const Text(
        'Try clicking me',
        style: TextStyle(
          color: Colors.blueGrey,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}
