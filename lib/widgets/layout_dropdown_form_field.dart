import 'package:album_searcher_for_google_photos/enums/layout_mode.dart';
import 'package:album_searcher_for_google_photos/services/storage_service.dart';
import 'package:album_searcher_for_google_photos/states/layout_state.dart';
import 'package:flutter/material.dart';

class LayoutDropdownButtonFormField extends StatelessWidget {
  const LayoutDropdownButtonFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<LayoutMode>(
      items: [
        DropdownMenuItem(
          value: LayoutMode.grid,
          child: Text('Grid'),
        ),
        DropdownMenuItem(
          value: LayoutMode.list,
          child: Text('List'),
        ),
      ],
      value: LayoutState.of(context).layoutMode,
      onChanged: (value) async {
        if (value != null) {
          await StorageServiceScope.of(context).setLayoutMode(value);
        }

        LayoutState.of(context).layoutMode = value;
      },
      decoration: InputDecoration(
        labelText: 'Layout',
        border: OutlineInputBorder(),
      ),
    );
  }
}
