import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_desktop/google_sign_in_desktop.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:googleapis/photoslibrary/v1.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'albums/album_repository.dart';
import 'albums/album_screen.dart';
import 'albums/albums_screen.dart';
import 'albums/caching_album_repository.dart';
import 'authentication/google_sign_in_account_notifier.dart';
import 'authentication/google_sign_in_desktop_token_data_store.dart';
import 'authentication/sign_in_screen.dart';
import 'authentication/authenticating_client.dart';
import 'common/cache_service.dart';
import 'common/root_navigator_key.dart';
import 'common/shell_navigator_key.dart';
import 'common/shell_scaffold.dart';
import 'firebase_options.dart';
import 'google_sign_in_parameters.dart';
import 'media_items/media_item_repository.dart';
import 'settings/settings_screen.dart';
import 'settings/theme_notifier.dart';

final _googleSignIn = GoogleSignIn(
  clientId: GoogleSignInParameters.clientId,
  scopes: GoogleSignInParameters.scopes,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (GoogleSignInPlatform.instance case GoogleSignInDesktop instance) {
    if (GoogleSignInParameters.clientSecret case final clientSecret?) {
      instance.clientSecret = clientSecret;
    }

    instance.tokenDataStore = const GoogleSignInDesktopTokenDataStore();
  }

  runApp(
    MultiProvider(
      providers: [
        Provider<CacheService>(
          create: (context) {
            return CacheService();
          },
        ),
        Provider<GoogleSignIn>.value(
          value: _googleSignIn,
        ),
        ChangeNotifierProvider<GoogleSignInAccountNotifier>(
          create: (context) {
            return GoogleSignInAccountNotifier(
              googleSignIn: _googleSignIn,
            );
          },
        ),
        Provider<PhotosLibraryApi>(
          create: (context) {
            return PhotosLibraryApi(
              AuthenticatingClient(
                googleSignIn: _googleSignIn,
              ),
            );
          },
        ),
        Provider<SharedPreferences>.value(
          value: await SharedPreferences.getInstance(),
        ),
        ChangeNotifierProxyProvider<SharedPreferences, ThemeNotifier>(
          create: (context) {
            return ThemeNotifier();
          },
          update: (context, preferences, notifier) {
            notifier ??= ThemeNotifier();

            if (preferences.getInt('layout') case final index?) {
              notifier.layoutMode = LayoutMode.values[index];
            }

            if (preferences.getInt('theme') case final index?) {
              notifier.themeMode = ThemeMode.values[index];
            }

            return notifier;
          },
        ),
        ProxyProvider2<CacheService, PhotosLibraryApi, AlbumRepository>(
          update: (context, cacheService, photosLibraryApi, previous) {
            return CachingAlbumRepository(
              inner: AlbumRepository(
                photosLibraryApi: photosLibraryApi,
              ),
              cacheService: cacheService,
            );
          },
        ),
        ProxyProvider<PhotosLibraryApi, MediaItemRepository>(
          update: (context, photosLibraryApi, previous) {
            return MediaItemRepository(
              photosLibraryApi: photosLibraryApi,
            );
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        routes: [
          ShellRoute(
            builder: (context, state, child) {
              return ShellScaffold(
                child: child,
              );
            },
            routes: [
              GoRoute(
                path: '/albums',
                builder: (context, state) {
                  return const AlbumsScreen();
                },
                routes: [
                  GoRoute(
                    path: ':albumId',
                    builder: (context, state) {
                      return AlbumScreen(
                        albumId: state.pathParameters['albumId']!,
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: '/settings',
                builder: (context, state) {
                  return const SettingsScreen();
                },
              ),
            ],
            navigatorKey: shellNavigatorKey,
          ),
          GoRoute(
            path: '/signin',
            builder: (context, state) {
              return const SignInScreen();
            },
          ),
        ],
        redirect: (context, state) async {
          if (context.read<GoogleSignInAccountNotifier>().value != null) {
            return null;
          }

          return '/signin';
        },
        initialLocation: '/albums',
        navigatorKey: rootNavigatorKey,
      ),
      title: 'Album Searcher for Google Photos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEA4335),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEA4335),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: context.select<ThemeNotifier, ThemeMode>(
        (notifier) {
          return notifier.themeMode;
        },
      ),
    );
  }
}
