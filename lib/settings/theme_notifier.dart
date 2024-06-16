import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  LayoutMode _layoutMode;
  ThemeMode _themeMode;

  ThemeNotifier({
    LayoutMode? layoutMode,
    ThemeMode? themeMode,
  })  : _layoutMode = layoutMode ?? LayoutMode.list,
        _themeMode = themeMode ?? ThemeMode.system;

  LayoutMode get layoutMode {
    return _layoutMode;
  }

  set layoutMode(LayoutMode? layoutMode) {
    if (_layoutMode != layoutMode) {
      _layoutMode = layoutMode ?? LayoutMode.list;
      notifyListeners();
    }
  }

  ThemeMode get themeMode {
    return _themeMode;
  }

  set themeMode(ThemeMode? themeMode) {
    if (_themeMode != themeMode) {
      _themeMode = themeMode ?? ThemeMode.system;
      notifyListeners();
    }
  }
}

enum LayoutMode {
  grid,
  list,
}
