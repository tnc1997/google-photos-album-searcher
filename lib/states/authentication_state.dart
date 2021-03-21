import 'package:flutter/material.dart';
import 'package:oauth2/oauth2.dart';

class AuthenticationState extends InheritedNotifier<AuthenticationStateData> {
  const AuthenticationState({
    Key? key,
    required AuthenticationStateData notifier,
    required Widget child,
  }) : super(
          key: key,
          notifier: notifier,
          child: child,
        );

  static AuthenticationStateData of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AuthenticationState>()!
        .notifier!;
  }
}

class AuthenticationStateData extends ChangeNotifier {
  Client? _client;

  AuthenticationStateData({
    Client? client,
  }) : _client = client;

  Client? get client => _client;

  set client(Client? client) {
    if (client != _client) {
      _client = client;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _client?.close();
    super.dispose();
  }
}
