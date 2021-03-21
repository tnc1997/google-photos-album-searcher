import 'dart:convert';

import 'package:album_searcher_for_google_photos/services/io_authentication_service.dart';
import 'package:album_searcher_for_google_photos/services/storage_service.dart';
import 'package:album_searcher_for_google_photos/states/authentication_state.dart';
import 'package:flutter/services.dart';
import 'package:oauth2/oauth2.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

IoAuthenticationService createAuthenticationService(
  AuthenticationStateData authenticationStateData,
  StorageService storageService,
) =>
    MobileAuthenticationService(
      authenticationStateData: authenticationStateData,
      storageService: storageService,
    );

class MobileAuthenticationService implements IoAuthenticationService {
  final AuthenticationStateData _authenticationStateData;
  final StorageService _storageService;

  MobileAuthenticationService({
    required AuthenticationStateData authenticationStateData,
    required StorageService storageService,
  })   : _authenticationStateData = authenticationStateData,
        _storageService = storageService;

  @override
  Future<Client> signInInteractive() async {
    final config = json.decode(
      await rootBundle.loadString(
        'files/mobile_client_secret.json',
      ),
    );

    final redirectUrl = Uri.parse(
      'app.thomasclark.albumsearcherforgooglephotos://oauth2redirect',
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

    final uri = await uriLinkStream.firstWhere(
      (uri) => uri != null && uri.queryParameters.containsKey('code'),
    ) as Uri;

    final client = await grant.handleAuthorizationResponse(
      uri.queryParameters,
    );

    await _storageService.setCredentials(client.credentials);

    return _authenticationStateData.client = client;
  }

  @override
  Future<Client?> signInSilent() async {
    final config = json.decode(
      await rootBundle.loadString(
        'files/mobile_client_secret.json',
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
