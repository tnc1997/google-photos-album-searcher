import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_notifier.dart';

class LayoutDropdownButtonFormField extends StatelessWidget {
  const LayoutDropdownButtonFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: const [
        DropdownMenuItem(
          value: LayoutMode.grid,
          child: Text('Grid'),
        ),
        DropdownMenuItem(
          value: LayoutMode.list,
          child: Text('List'),
        ),
      ],
      value: context.select<ThemeNotifier, LayoutMode>(
        (notifier) {
          return notifier.layoutMode;
        },
      ),
      onChanged: (value) async {
        final notifier = context.read<ThemeNotifier>();
        final preferences = context.read<SharedPreferences>();

        if (value != null) {
          await preferences.setInt('layout', value.index);
        } else {
          await preferences.remove('layout');
        }

        notifier.layoutMode = value;
      },
      decoration: const InputDecoration(
        labelText: 'Layout',
        border: OutlineInputBorder(),
      ),
    );
  }
}
