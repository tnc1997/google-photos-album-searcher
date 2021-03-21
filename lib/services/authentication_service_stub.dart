import 'package:album_searcher_for_google_photos/services/authentication_service.dart';
import 'package:album_searcher_for_google_photos/services/storage_service.dart';
import 'package:album_searcher_for_google_photos/states/authentication_state.dart';

AuthenticationService createAuthenticationService(
  AuthenticationStateData authenticationStateData,
  StorageService storageService,
) =>
    throw UnsupportedError(
      'Cannot create an authentication service without dart:html or dart:io.',
    );
