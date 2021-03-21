import 'package:flutter/material.dart';

class ThemeState extends InheritedNotifier<ThemeStateData> {
  const ThemeState({
    Key? key,
    required ThemeStateData notifier,
    required Widget child,
  }) : super(
          key: key,
          notifier: notifier,
          child: child,
        );

  static ThemeStateData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeState>()!.notifier!;
  }
}

class ThemeStateData extends ChangeNotifier {
  ThemeMode? _themeMode;

  ThemeStateData({
    ThemeMode? themeMode,
  }) : _themeMode = themeMode ?? ThemeMode.system;

  ThemeMode? get themeMode => _themeMode;

  set themeMode(ThemeMode? themeMode) {
    if (themeMode != _themeMode) {
      _themeMode = themeMode;
      notifyListeners();
    }
  }
}
