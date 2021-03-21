import 'dart:io';

import 'package:album_searcher_for_google_photos/services/authentication_service.dart';
import 'package:album_searcher_for_google_photos/services/desktop_authentication_service.dart';
import 'package:album_searcher_for_google_photos/services/mobile_authentication_service.dart';
import 'package:album_searcher_for_google_photos/services/storage_service.dart';
import 'package:album_searcher_for_google_photos/states/authentication_state.dart';

IoAuthenticationService createAuthenticationService(
  AuthenticationStateData authenticationStateData,
  StorageService storageService,
) =>
    Platform.isLinux || Platform.isMacOS || Platform.isWindows
        ? DesktopAuthenticationService(
            authenticationStateData: authenticationStateData,
            storageService: storageService,
          )
        : MobileAuthenticationService(
            authenticationStateData: authenticationStateData,
            storageService: storageService,
          );

abstract class IoAuthenticationService extends AuthenticationService {
  factory IoAuthenticationService({
    required AuthenticationStateData authenticationStateData,
    required StorageService storageService,
  }) =>
      createAuthenticationService(authenticationStateData, storageService);
}
