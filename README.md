# Album Searcher for Google Photos

Album Searcher for Google Photos gives you an enhanced search experience for albums.

Please note that Album Searcher for Google Photos is unofficial and not endorsed by Google.

## Getting Started

1. Create a [Google Cloud Platform project](https://console.cloud.google.com/projectcreate).
2. Enable the [Photos Library API](https://console.cloud.google.com/apis/library/photoslibrary.googleapis.com).
3. Create an [OAuth consent screen](https://console.cloud.google.com/apis/credentials/consent) with the scopes "[openid](https://developers.google.com/identity/protocols/oauth2/scopes#oauth2)" and "[https://www.googleapis.com/auth/photoslibrary.readonly](https://developers.google.com/identity/protocols/oauth2/scopes#photoslibrary)".
4. Create an [OAuth client](https://console.cloud.google.com/apis/credentials/oauthclient) for desktop.
5. Create an [OAuth client](https://console.cloud.google.com/apis/credentials/oauthclient) for web with the authorised JavaScript origins "http://localhost" and "http://localhost:7357".
6. Create a file "google_sign_in_parameters.dart" with the OAuth client credentials for each platform.
7. Create a [Firebase project](https://console.firebase.google.com) linked to the existing [Google Cloud Platform project](https://console.cloud.google.com).
8. Setup Firebase in the Flutter application by following [these](https://firebase.google.com/docs/flutter/setup) instructions.
9. Run `flutter run --device-id windows` to start the application on desktop.
10. Run `flutter run --device-id chrome --web-port 7357 --web-renderer html` to start the application on web.
