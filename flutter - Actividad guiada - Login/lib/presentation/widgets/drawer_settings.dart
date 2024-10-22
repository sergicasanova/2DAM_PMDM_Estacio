import 'package:flutter/material.dart';
import 'package:flutter_harry_potter/presentation/screens/dialog_theme.dart';

class CounterDrawerWidget extends StatelessWidget {
  const CounterDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _showChangeThemeDialog(context);
              },
              child: const Text("Cambiar tema"),
            ),
          ),
        ],
      ),
    );
  }

  void _showChangeThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ThemeSelector();
      },
    );
  }
}
