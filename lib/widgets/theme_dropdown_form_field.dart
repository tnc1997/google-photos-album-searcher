import 'package:flutter/material.dart';
import 'package:album_searcher_for_google_photos/services/storage_service.dart';
import 'package:album_searcher_for_google_photos/states/theme_state.dart';

class ThemeDropdownButtonFormField extends StatelessWidget {
  const ThemeDropdownButtonFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ThemeMode>(
      items: [
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
      value: ThemeState.of(context).themeMode,
      onChanged: (value) async {
        if (value != null) {
          await StorageServiceScope.of(context).setThemeMode(value);
        }

        ThemeState.of(context).themeMode = value;
      },
      decoration: InputDecoration(
        labelText: 'Theme',
        border: OutlineInputBorder(),
      ),
    );
  }
}
