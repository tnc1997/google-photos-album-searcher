import 'dart:convert';
import 'dart:html'; // ignore: avoid_web_libraries_in_flutter

import 'package:album_searcher_for_google_photos/services/authentication_service.dart';
import 'package:album_searcher_for_google_photos/services/storage_service.dart';
import 'package:album_searcher_for_google_photos/states/authentication_state.dart';
import 'package:flutter/services.dart';
import 'package:oauth2/oauth2.dart';

AuthenticationService createAuthenticationService(
  AuthenticationStateData authenticationStateData,
  StorageService storageService,
) =>
    BrowserAuthenticationService(
      authenticationStateData: authenticationStateData,
      storageService: storageService,
    );

class BrowserAuthenticationService implements AuthenticationService {
  final AuthenticationStateData _authenticationStateData;
  final StorageService _storageService;

  BrowserAuthenticationService({
    required AuthenticationStateData authenticationStateData,
    required StorageService storageService,
  })   : _authenticationStateData = authenticationStateData,
        _storageService = storageService;

  @override
  Future<Client> signInInteractive() async {
    final config = json.decode(
      await rootBundle.loadString(
        'files/browser_client_secret.json',
      ),
    );

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
      onCredentialsRefreshed: _onCredentialsRefreshed,
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

      await _storageService.setCredentials(client.credentials);

      return _authenticationStateData.client = client;
    } finally {
      base.close();
    }
  }

  @override
  Future<Client?> signInSilent() async {
    final config = json.decode(
      await rootBundle.loadString(
        'files/browser_client_secret.json',
      ),
    );

    final credentials = await _storageService.getCredentials();

    if (credentials != null) {
      return _authenticationStateData.client = Client(
        credentials,
        identifier: config['web']['client_id'],
        secret: config['web']['client_secret'],
        onCredentialsRefreshed: _onCredentialsRefreshed,
      );
    }
  }

  Future<void> _onCredentialsRefreshed(Credentials credentials) async {
    await _storageService.setCredentials(credentials);
  }
}
