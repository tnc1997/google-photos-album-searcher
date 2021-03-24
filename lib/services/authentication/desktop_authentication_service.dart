import 'dart:convert';
import 'dart:io';

import 'package:album_searcher_for_google_photos/services/authentication/authentication_service.dart';
import 'package:album_searcher_for_google_photos/services/authentication/io_authentication_service.dart';
import 'package:album_searcher_for_google_photos/services/storage_service.dart';
import 'package:album_searcher_for_google_photos/states/authentication_state.dart';
import 'package:album_searcher_for_google_photos/states/layout_state.dart';
import 'package:album_searcher_for_google_photos/states/shared_album_state.dart';
import 'package:album_searcher_for_google_photos/states/theme_state.dart';
import 'package:flutter/services.dart';
import 'package:oauth2/oauth2.dart';
import 'package:url_launcher/url_launcher.dart';

AuthenticationService createAuthenticationService(
  AuthenticationStateData authenticationStateData,
  LayoutStateData layoutStateData,
  SharedAlbumStateData sharedAlbumStateData,
  StorageService storageService,
  ThemeStateData themeStateData,
) =>
    DesktopAuthenticationService(
      authenticationStateData: authenticationStateData,
      layoutStateData: layoutStateData,
      sharedAlbumStateData: sharedAlbumStateData,
      storageService: storageService,
      themeStateData: themeStateData,
    );

class DesktopAuthenticationService extends IoAuthenticationService {
  DesktopAuthenticationService({
    required AuthenticationStateData authenticationStateData,
    required LayoutStateData layoutStateData,
    required SharedAlbumStateData sharedAlbumStateData,
    required StorageService storageService,
    required ThemeStateData themeStateData,
  }) : super(
          assetBundleKey: 'files/desktop_client_secret.json',
          authenticationStateData: authenticationStateData,
          layoutStateData: layoutStateData,
          sharedAlbumStateData: sharedAlbumStateData,
          storageService: storageService,
          themeStateData: themeStateData,
        );

  @override
  Future<void> signInInteractive() async {
    final config = json.decode(await rootBundle.loadString(assetBundleKey));

    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);

    try {
      final redirectUrl = Uri.parse(
        'http://${server.address.host}:${server.port}',
      );

      final grant = AuthorizationCodeGrant(
        config['installed']['client_id'],
        Uri.parse(config['installed']['auth_uri']),
        Uri.parse(config['installed']['token_uri']),
        secret: config['installed']['client_secret'],
        onCredentialsRefreshed: onCredentialsRefreshed,
      );

      final authorizationUrl = grant.getAuthorizationUrl(
        redirectUrl,
        scopes: [
          'openid',
          'https://www.googleapis.com/auth/photoslibrary.readonly',
        ],
      );

      await launch('$authorizationUrl&access_type=offline');

      final request = await server.firstWhere(
        (request) => request.uri.queryParameters.containsKey('code'),
      );

      final client = await grant.handleAuthorizationResponse(
        request.uri.queryParameters,
      );

      request.response
        ..statusCode = 200
        ..headers.set('content-type', 'text/html; charset=UTF-8')
        ..write('''
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Authentication Complete</title>
  </head>
  <body>
    <p>This window can be closed now.</p>
  </body>
</html>''');

      await request.response.close();

      await storageService.setCredentials(client.credentials);

      authenticationStateData.client = client;
    } finally {
      await server.close();
    }
  }
}
