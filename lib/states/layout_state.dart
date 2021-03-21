import 'package:album_searcher_for_google_photos/enums/layout_mode.dart';
import 'package:flutter/material.dart';

class LayoutState extends InheritedNotifier<LayoutStateData> {
  const LayoutState({
    Key? key,
    required LayoutStateData notifier,
    required Widget child,
  }) : super(
          key: key,
          notifier: notifier,
          child: child,
        );

  static LayoutStateData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LayoutState>()!.notifier!;
  }
}

class LayoutStateData extends ChangeNotifier {
  LayoutMode? _layoutMode;

  LayoutStateData({
    LayoutMode? layoutMode,
  }) : _layoutMode = layoutMode ?? LayoutMode.list;

  LayoutMode? get layoutMode => _layoutMode;

  set layoutMode(LayoutMode? layoutMode) {
    if (layoutMode != _layoutMode) {
      _layoutMode = layoutMode;
      notifyListeners();
    }
  }
}
