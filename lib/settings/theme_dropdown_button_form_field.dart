import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_notifier.dart';

class ThemeDropdownButtonFormField extends StatelessWidget {
  const ThemeDropdownButtonFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: const [
        DropdownMenuItem(
          value: ThemeMode.system,
          child: Text('System'),
        ),
        DropdownMenuItem(
          value: ThemeMode.light,
          child: Text('Light'),
        ),
        DropdownMenuItem(
          value: ThemeMode.dark,
          child: Text('Dark'),
        ),
      ],
      value: context.select<ThemeNotifier, ThemeMode>(
        (notifier) {
          return notifier.themeMode;
        },
      ),
      onChanged: (value) async {
        final notifier = context.read<ThemeNotifier>();
        final preferences = context.read<SharedPreferences>();

        if (value != null) {
          await preferences.setInt('theme', value.index);
        } else {
          await preferences.remove('theme');
        }

        notifier.themeMode = value;
      },
      decoration: const InputDecoration(
        labelText: 'Theme',
        border: OutlineInputBorder(),
      ),
    );
  }
}
