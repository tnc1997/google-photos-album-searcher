import 'dart:convert';
import 'dart:html'; // ignore: avoid_web_libraries_in_flutter

import 'package:album_searcher_for_google_photos/services/authentication/authentication_service.dart';
import 'package:album_searcher_for_google_photos/services/authentication/base_authentication_service.dart';
import 'package:album_searcher_for_google_photos/services/storage_service.dart';
import 'package:album_searcher_for_google_photos/states/authentication_state.dart';
import 'package:album_searcher_for_google_photos/states/layout_state.dart';
import 'package:album_searcher_for_google_photos/states/shared_album_state.dart';
import 'package:album_searcher_for_google_photos/states/theme_state.dart';
import 'package:flutter/services.dart';
import 'package:oauth2/oauth2.dart';

AuthenticationService createAuthenticationService(
  AuthenticationStateData authenticationStateData,
  LayoutStateData layoutStateData,
  SharedAlbumStateData sharedAlbumStateData,
  StorageService storageService,
  ThemeStateData themeStateData,
) =>
    BrowserAuthenticationService(
      authenticationStateData: authenticationStateData,
      layoutStateData: layoutStateData,
      sharedAlbumStateData: sharedAlbumStateData,
      storageService: storageService,
      themeStateData: themeStateData,
    );

class BrowserAuthenticationService extends BaseAuthenticationService {
  BrowserAuthenticationService({
    required AuthenticationStateData authenticationStateData,
    required LayoutStateData layoutStateData,
    required SharedAlbumStateData sharedAlbumStateData,
    required StorageService storageService,
    required ThemeStateData themeStateData,
  }) : super(
          assetBundleKey: 'files/browser_client_secret.json',
          authenticationStateData: authenticationStateData,
          layoutStateData: layoutStateData,
          sharedAlbumStateData: sharedAlbumStateData,
          storageService: storageService,
          themeStateData: themeStateData,
        );

  @override
  Future<void> signInInteractive() async {
    final config = json.decode(await rootBundle.loadString(assetBundleKey));

    final redirectUrl = Uri(
      scheme: Uri.base.scheme,
      host: Uri.base.host,
      port: Uri.base.port,
      path: '/oauth2redirect.html',
    );

    final grant = AuthorizationCodeGrant(
      config['web']['client_id'],
      Uri.parse(config['web']['auth_uri']),
      Uri.parse(config['web']['token_uri']),
      secret: config['web']['client_secret'],
      onCredentialsRefreshed: onCredentialsRefreshed,
    );

    final authorizationUrl = grant.getAuthorizationUrl(
      redirectUrl,
      scopes: [
        'openid',
        'https://www.googleapis.com/auth/photoslibrary.readonly',
      ],
    );

    final base = window.open(
      '$authorizationUrl&access_type=offline',
      '_blank',
      'resizable=yes,scrollbars=yes',
    );

    try {
      final event = await window.onMessage.firstWhere(
        (event) => event.data.toString().contains('code'),
      );

      final client = await grant.handleAuthorizationResponse(
        Uri.parse(event.data.toString()).queryParameters,
      );

      await storageService.setCredentials(client.credentials);

      authenticationStateData.client = client;
    } finally {
      base.close();
    }
  }
}
