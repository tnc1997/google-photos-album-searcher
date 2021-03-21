import 'package:album_searcher_for_google_photos/widgets/layout_dropdown_form_field.dart';
import 'package:album_searcher_for_google_photos/widgets/sign_out_floating_action_button.dart';
import 'package:album_searcher_for_google_photos/widgets/theme_dropdown_form_field.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: LayoutDropdownButtonFormField(),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ThemeDropdownButtonFormField(),
            ),
          ],
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: SignOutFloatingActionButton(),
        ),
      ],
    );
  }
}
