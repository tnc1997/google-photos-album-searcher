import 'dart:io';

import 'package:album_searcher_for_google_photos/services/authentication/authentication_service.dart';
import 'package:album_searcher_for_google_photos/services/authentication/base_authentication_service.dart';
import 'package:album_searcher_for_google_photos/services/authentication/desktop_authentication_service.dart';
import 'package:album_searcher_for_google_photos/services/authentication/mobile_authentication_service.dart';
import 'package:album_searcher_for_google_photos/services/storage_service.dart';
import 'package:album_searcher_for_google_photos/states/authentication_state.dart';
import 'package:album_searcher_for_google_photos/states/layout_state.dart';
import 'package:album_searcher_for_google_photos/states/shared_album_state.dart';
import 'package:album_searcher_for_google_photos/states/theme_state.dart';

AuthenticationService createAuthenticationService(
  AuthenticationStateData authenticationStateData,
  LayoutStateData layoutStateData,
  SharedAlbumStateData sharedAlbumStateData,
  StorageService storageService,
  ThemeStateData themeStateData,
) =>
    Platform.isLinux || Platform.isMacOS || Platform.isWindows
        ? DesktopAuthenticationService(
            authenticationStateData: authenticationStateData,
            layoutStateData: layoutStateData,
            sharedAlbumStateData: sharedAlbumStateData,
            storageService: storageService,
            themeStateData: themeStateData,
          )
        : MobileAuthenticationService(
            authenticationStateData: authenticationStateData,
            layoutStateData: layoutStateData,
            sharedAlbumStateData: sharedAlbumStateData,
            storageService: storageService,
            themeStateData: themeStateData,
          );

abstract class IoAuthenticationService extends BaseAuthenticationService {
  IoAuthenticationService({
    required String assetBundleKey,
    required AuthenticationStateData authenticationStateData,
    required LayoutStateData layoutStateData,
    required SharedAlbumStateData sharedAlbumStateData,
    required StorageService storageService,
    required ThemeStateData themeStateData,
  }) : super(
          assetBundleKey: assetBundleKey,
          authenticationStateData: authenticationStateData,
          layoutStateData: layoutStateData,
          sharedAlbumStateData: sharedAlbumStateData,
          storageService: storageService,
          themeStateData: themeStateData,
        );
}
