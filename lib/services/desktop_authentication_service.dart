import 'dart:convert';
import 'dart:io';

import 'package:album_searcher_for_google_photos/services/io_authentication_service.dart';
import 'package:album_searcher_for_google_photos/services/storage_service.dart';
import 'package:album_searcher_for_google_photos/states/authentication_state.dart';
import 'package:flutter/services.dart';
import 'package:oauth2/oauth2.dart';
import 'package:url_launcher/url_launcher.dart';

IoAuthenticationService createAuthenticationService(
  AuthenticationStateData authenticationStateData,
  StorageService storageService,
) =>
    DesktopAuthenticationService(
      authenticationStateData: authenticationStateData,
      storageService: storageService,
    );

class DesktopAuthenticationService implements IoAuthenticationService {
  final AuthenticationStateData _authenticationStateData;
  final StorageService _storageService;

  DesktopAuthenticationService({
    required AuthenticationStateData authenticationStateData,
    required StorageService storageService,
  })   : _authenticationStateData = authenticationStateData,
        _storageService = storageService;

  @override
  Future<Client> signInInteractive() async {
    final config = json.decode(
      await rootBundle.loadString(
        'files/desktop_client_secret.json',
      ),
    );

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
        onCredentialsRefreshed: _onCredentialsRefreshed,
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

      await _storageService.setCredentials(client.credentials);

      return _authenticationStateData.client = client;
    } finally {
      await server.close();
    }
  }

  @override
  Future<Client?> signInSilent() async {
    final config = json.decode(
      await rootBundle.loadString(
        'files/desktop_client_secret.json',
      ),
    );

    final credentials = await _storageService.getCredentials();

    if (credentials != null) {
      return _authenticationStateData.client = Client(
        credentials,
        identifier: config['installed']['client_id'],
        secret: config['installed']['client_secret'],
        onCredentialsRefreshed: _onCredentialsRefreshed,
      );
    }
  }

  Future<void> _onCredentialsRefreshed(Credentials credentials) async {
    await _storageService.setCredentials(credentials);
  }
}
