import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:album_searcher_for_google_photos/route_paths/album_route_path.dart';
import 'package:album_searcher_for_google_photos/route_paths/home_route_path.dart';
import 'package:album_searcher_for_google_photos/route_paths/route_path.dart';
import 'package:album_searcher_for_google_photos/route_paths/settings_route_path.dart';
import 'package:album_searcher_for_google_photos/route_paths/sign_in_route_path.dart';

class AppRouteInformationParser extends RouteInformationParser<RoutePath> {
  @override
  Future<RoutePath> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = Uri.parse(routeInformation.location!);

    switch (uri.pathSegments.length) {
      case 1:
        switch (uri.pathSegments[0]) {
          case 'login':
            return SynchronousFuture(SignInRoutePath());
          case 'settings':
            return SynchronousFuture(SettingsRoutePath());
        }
        break;
      case 2:
        switch (uri.pathSegments[0]) {
          case 'albums':
            final id = uri.pathSegments[1];
            return SynchronousFuture(AlbumRoutePath(id: id));
        }
        break;
    }

    return SynchronousFuture(HomeRoutePath());
  }

  @override
  RouteInformation? restoreRouteInformation(
    RoutePath configuration,
  ) {
    if (configuration is HomeRoutePath) {
      return RouteInformation(
        location: '/',
      );
    } else if (configuration is AlbumRoutePath) {
      return RouteInformation(
        location: '/albums/${configuration.id}',
      );
    } else if (configuration is SignInRoutePath) {
      return RouteInformation(
        location: '/login',
      );
    } else if (configuration is SettingsRoutePath) {
      return RouteInformation(
        location: '/settings',
      );
    }

    return null;
  }
}
