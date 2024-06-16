import 'package:flutter/material.dart';

import '../authentication/sign_out_button.dart';
import 'clear_cache_button.dart';
import 'layout_dropdown_button_form_field.dart';
import 'theme_dropdown_button_form_field.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: LayoutDropdownButtonFormField(),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: ThemeDropdownButtonFormField(),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: ClearCacheButton(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: SignOutButton(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
