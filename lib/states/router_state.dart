import 'package:flutter/widgets.dart';

class RouterState extends InheritedNotifier<RouterStateData> {
  const RouterState({
    Key? key,
    required RouterStateData notifier,
    required Widget child,
  }) : super(
          key: key,
          notifier: notifier,
          child: child,
        );

  static RouterStateData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RouterState>()!.notifier!;
  }
}

class RouterStateData extends ChangeNotifier {
  String? _selectedAlbum;
  int _selectedIndex = 0;

  String? get selectedAlbum => _selectedAlbum;

  set selectedAlbum(String? selectedAlbum) {
    if (selectedAlbum != _selectedAlbum) {
      _selectedAlbum = selectedAlbum;
      notifyListeners();
    }
  }

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int selectedIndex) {
    if (selectedIndex != _selectedIndex) {
      _selectedIndex = selectedIndex;
      notifyListeners();
    }
  }
}
