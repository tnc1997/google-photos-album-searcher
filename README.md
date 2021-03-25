# Album Searcher for Google Photos

Album Searcher for Google Photos gives you an enhanced search experience for shared albums.

## Getting Started

1. Create a [Google Cloud Platform project](https://console.cloud.google.com/projectcreate).
1. Enable the [Photos Library API](https://console.cloud.google.com/apis/library/photoslibrary.googleapis.com).
1. Create an [OAuth consent screen](https://console.cloud.google.com/apis/credentials/consent) with the scopes "[openid](https://developers.google.com/identity/protocols/oauth2/scopes#oauth2)" and "[https://www.googleapis.com/auth/photoslibrary.readonly](https://developers.google.com/identity/protocols/oauth2/scopes#photoslibrary)".
1. Create an [OAuth client](https://console.cloud.google.com/apis/credentials/oauthclient) for desktop.
1. Create an [OAuth client](https://console.cloud.google.com/apis/credentials/oauthclient) for web with the authorised JavaScript origin "http://localhost:1234" and the authorised redirect URI "http://localhost:1234/oauth2redirect.html".
1. Download the JSON of the desktop OAuth client to the directory "files" with the name "desktop_client_secret.json".
1. Download the JSON of the web OAuth client to the directory "files" with the name "browser_client_secret.json".
1. Create a [Firebase project](https://console.firebase.google.com) linked to the existing [Google Cloud Platform project](https://console.cloud.google.com).
1. Add a [web app](https://firebase.google.com/docs/web/setup) to the [Firebase project](https://console.firebase.google.com) making a note of the Firebase config.
1. Create a file "firebase-config.js" in the directory "web" with the following content:
    ```javascript
    export var firebaseConfig = {
        apiKey: "API_KEY",
        authDomain: "PROJECT_ID.firebaseapp.com",
        databaseURL: "https://PROJECT_ID.firebaseio.com",
        projectId: "PROJECT_ID",
        storageBucket: "PROJECT_ID.appspot.com",
        messagingSenderId: "SENDER_ID",
        appId: "APP_ID",
        measurementId: "G-MEASUREMENT_ID",
    };
    ```
1. Run `flutter run --device-id windows --no-sound-null-safety` to start the application on desktop.
1. Run `flutter run --device-id chrome --no-sound-null-safety --web-port 1234 --web-renderer html` to start the application on web.
