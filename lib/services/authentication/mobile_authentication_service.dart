import 'package:album_searcher_for_google_photos/services/authentication/authentication_service.dart';
import 'package:album_searcher_for_google_photos/services/authentication/io_authentication_service.dart';
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
    MobileAuthenticationService(
      authenticationStateData: authenticationStateData,
      layoutStateData: layoutStateData,
      sharedAlbumStateData: sharedAlbumStateData,
      storageService: storageService,
      themeStateData: themeStateData,
    );

class MobileAuthenticationService extends IoAuthenticationService {
  MobileAuthenticationService({
    required AuthenticationStateData authenticationStateData,
    required LayoutStateData layoutStateData,
    required SharedAlbumStateData sharedAlbumStateData,
    required StorageService storageService,
    required ThemeStateData themeStateData,
  }) : super(
          assetBundleKey: 'files/mobile_client_secret.json',
          authenticationStateData: authenticationStateData,
          layoutStateData: layoutStateData,
          sharedAlbumStateData: sharedAlbumStateData,
          storageService: storageService,
          themeStateData: themeStateData,
        );

  @override
  Future<void> signInInteractive() async {
    throw UnimplementedError();

    // final config = json.decode(await rootBundle.loadString(assetBundleKey));
    //
    // final redirectUrl = Uri.parse(
    //   'app.thomasclark.albumsearcherforgooglephotos://oauth2redirect',
    // );
    //
    // final grant = AuthorizationCodeGrant(
    //   config['installed']['client_id'],
    //   Uri.parse(config['installed']['auth_uri']),
    //   Uri.parse(config['installed']['token_uri']),
    //   secret: config['installed']['client_secret'],
    //   onCredentialsRefreshed: onCredentialsRefreshed,
    // );
    //
    // final authorizationUrl = grant.getAuthorizationUrl(
    //   redirectUrl,
    //   scopes: [
    //     'openid',
    //     'https://www.googleapis.com/auth/photoslibrary.readonly',
    //   ],
    // );
    //
    // await launch('$authorizationUrl&access_type=offline');
    //
    // final uri = await uriLinkStream.firstWhere(
    //   (uri) => uri != null && uri.queryParameters.containsKey('code'),
    // ) as Uri;
    //
    // final client = await grant.handleAuthorizationResponse(
    //   uri.queryParameters,
    // );
    //
    // await storageService.setCredentials(client.credentials);
    //
    // authenticationStateData.client = client;
  }
}
