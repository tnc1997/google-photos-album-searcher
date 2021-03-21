import 'package:album_searcher_for_google_photos/services/authentication_service_stub.dart'
    if (dart.library.html) 'package:album_searcher_for_google_photos/services/browser_authentication_service.dart'
    if (dart.library.io) 'package:album_searcher_for_google_photos/services/io_authentication_service.dart';
import 'package:album_searcher_for_google_photos/services/storage_service.dart';
import 'package:album_searcher_for_google_photos/states/authentication_state.dart';
import 'package:flutter/widgets.dart';
import 'package:oauth2/oauth2.dart';

class AuthenticationServiceScope extends InheritedWidget {
  final AuthenticationService service;

  const AuthenticationServiceScope({
    Key? key,
    required this.service,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static AuthenticationService of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AuthenticationServiceScope>()!
        .service;
  }

  @override
  bool updateShouldNotify(covariant AuthenticationServiceScope oldWidget) {
    return oldWidget.service != service;
  }
}

abstract class AuthenticationService {
  factory AuthenticationService({
    required AuthenticationStateData authenticationStateData,
    required StorageService storageService,
  }) =>
      createAuthenticationService(authenticationStateData, storageService);

  Future<Client> signInInteractive();

  Future<Client?> signInSilent();
}
