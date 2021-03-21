import 'package:flutter/material.dart';
import 'package:album_searcher_for_google_photos/pages/album_page.dart';
import 'package:album_searcher_for_google_photos/pages/main_page.dart';
import 'package:album_searcher_for_google_photos/pages/sign_in_page.dart';
import 'package:album_searcher_for_google_photos/route_paths/album_route_path.dart';
import 'package:album_searcher_for_google_photos/route_paths/home_route_path.dart';
import 'package:album_searcher_for_google_photos/route_paths/route_path.dart';
import 'package:album_searcher_for_google_photos/route_paths/settings_route_path.dart';
import 'package:album_searcher_for_google_photos/route_paths/sign_in_route_path.dart';
import 'package:album_searcher_for_google_photos/states/authentication_state.dart';
import 'package:album_searcher_for_google_photos/states/router_state.dart';

class AppRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  final AuthenticationStateData authenticationStateData;
  final RouterStateData routerStateData;

  AppRouterDelegate({
    required this.authenticationStateData,
    required this.routerStateData,
  }) {
    authenticationStateData.addListener(notifyListeners);
    routerStateData.addListener(notifyListeners);
  }

  @override
  RoutePath? get currentConfiguration {
    if (authenticationStateData.client == null) {
      return SignInRoutePath();
    }

    final selectedAlbum = routerStateData.selectedAlbum;
    if (selectedAlbum != null) {
      return AlbumRoutePath(id: selectedAlbum);
    }

    switch (routerStateData.selectedIndex) {
      case 0:
        return HomeRoutePath();
      case 1:
        return SettingsRoutePath();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (authenticationStateData.client != null) ...[
          MaterialPage<void>(
            child: MainPage(
              routerStateData: routerStateData,
            ),
            key: ValueKey('main_page'),
          ),
          if (routerStateData.selectedAlbum != null)
            MaterialPage<void>(
              child: AlbumPage(
                id: routerStateData.selectedAlbum!,
              ),
              key: ValueKey('album_page'),
            ),
        ] else
          const MaterialPage<void>(
            child: SignInPage(),
            key: ValueKey('sign_in_page'),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        routerStateData.selectedAlbum = null;

        return true;
      },
    );
  }

  @override
  void dispose() {
    authenticationStateData.removeListener(notifyListeners);
    routerStateData.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Future<void> setNewRoutePath(RoutePath configuration) async {
    if (configuration is HomeRoutePath) {
      routerStateData.selectedIndex = 0;
    } else if (configuration is AlbumRoutePath) {
      routerStateData.selectedAlbum = configuration.id;
    } else if (configuration is SettingsRoutePath) {
      routerStateData.selectedIndex = 1;
    }
  }
}
