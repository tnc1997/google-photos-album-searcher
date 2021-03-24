import 'package:album_searcher_for_google_photos/route_information_parsers/app_route_information_parser.dart';
import 'package:album_searcher_for_google_photos/route_paths/route_path.dart';
import 'package:album_searcher_for_google_photos/router_delegates/app_router_delegate.dart';
import 'package:album_searcher_for_google_photos/services/album_service.dart';
import 'package:album_searcher_for_google_photos/services/authentication_service.dart';
import 'package:album_searcher_for_google_photos/services/media_item_service.dart';
import 'package:album_searcher_for_google_photos/services/shared_album_service.dart';
import 'package:album_searcher_for_google_photos/services/storage_service.dart';
import 'package:album_searcher_for_google_photos/states/authentication_state.dart';
import 'package:album_searcher_for_google_photos/states/layout_state.dart';
import 'package:album_searcher_for_google_photos/states/router_state.dart';
import 'package:album_searcher_for_google_photos/states/shared_album_state.dart';
import 'package:album_searcher_for_google_photos/states/theme_state.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageService = StorageService();
  final authenticationStateData = AuthenticationStateData();
  final authenticationService = AuthenticationService(
    authenticationStateData: authenticationStateData,
    storageService: storageService,
  );
  final albumService = AlbumService(
    authenticationStateData: authenticationStateData,
  );
  final layoutStateData = LayoutStateData(
    layoutMode: await storageService.getLayoutMode(),
  );
  final mediaItemService = MediaItemService(
    authenticationStateData: authenticationStateData,
  );
  final routeInformationParser = AppRouteInformationParser();
  final routerStateData = RouterStateData();
  final routerDelegate = AppRouterDelegate(
    authenticationStateData: authenticationStateData,
    routerStateData: routerStateData,
  );
  final sharedAlbumStateData = SharedAlbumStateData(
    sharedAlbums: await storageService.getSharedAlbums(),
  );
  final sharedAlbumService = SharedAlbumService(
    authenticationStateData: authenticationStateData,
    sharedAlbumStateData: sharedAlbumStateData,
    storageService: storageService,
  );
  final themeStateData = ThemeStateData(
    themeMode: await storageService.getThemeMode(),
  );

  await authenticationService.signInSilent();

  runApp(
    App(
      albumService: albumService,
      authenticationService: authenticationService,
      authenticationStateData: authenticationStateData,
      layoutStateData: layoutStateData,
      mediaItemService: mediaItemService,
      routeInformationParser: routeInformationParser,
      routerDelegate: routerDelegate,
      routerStateData: routerStateData,
      sharedAlbumService: sharedAlbumService,
      sharedAlbumStateData: sharedAlbumStateData,
      storageService: storageService,
      themeStateData: themeStateData,
    ),
  );
}

class App extends StatefulWidget {
  final AlbumService albumService;
  final AuthenticationService authenticationService;
  final AuthenticationStateData authenticationStateData;
  final LayoutStateData layoutStateData;
  final MediaItemService mediaItemService;
  final RouteInformationParser<RoutePath> routeInformationParser;
  final AppRouterDelegate routerDelegate;
  final RouterStateData routerStateData;
  final SharedAlbumService sharedAlbumService;
  final SharedAlbumStateData sharedAlbumStateData;
  final StorageService storageService;
  final ThemeStateData themeStateData;

  const App({
    Key? key,
    required this.albumService,
    required this.authenticationService,
    required this.authenticationStateData,
    required this.layoutStateData,
    required this.mediaItemService,
    required this.routeInformationParser,
    required this.routerDelegate,
    required this.routerStateData,
    required this.sharedAlbumService,
    required this.sharedAlbumStateData,
    required this.storageService,
    required this.themeStateData,
  }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return AlbumServiceScope(
      service: widget.albumService,
      child: AuthenticationServiceScope(
        service: widget.authenticationService,
        child: AuthenticationState(
          notifier: widget.authenticationStateData,
          child: LayoutState(
            notifier: widget.layoutStateData,
            child: MediaItemServiceScope(
              service: widget.mediaItemService,
              child: RouterState(
                notifier: widget.routerStateData,
                child: SharedAlbumServiceScope(
                  service: widget.sharedAlbumService,
                  child: SharedAlbumState(
                    notifier: widget.sharedAlbumStateData,
                    child: StorageServiceScope(
                      service: widget.storageService,
                      child: ThemeState(
                        notifier: widget.themeStateData,
                        child: Builder(
                          builder: (context) => MaterialApp.router(
                            routeInformationParser:
                                widget.routeInformationParser,
                            routerDelegate: widget.routerDelegate,
                            title: 'Album Searcher for Google Photos',
                            theme: ThemeData.from(
                              colorScheme: ColorScheme.light(
                                primary: Colors.red,
                                primaryVariant: Colors.red[700]!,
                                secondary: Colors.red,
                                secondaryVariant: Colors.red[700]!,
                                onPrimary: Colors.white,
                                onSecondary: Colors.white,
                              ),
                            ),
                            darkTheme: ThemeData.from(
                              colorScheme: ColorScheme.dark(
                                primary: Colors.red,
                                primaryVariant: Colors.red[700]!,
                                secondary: Colors.red,
                                secondaryVariant: Colors.red[700]!,
                                onPrimary: Colors.white,
                                onSecondary: Colors.white,
                              ),
                            ),
                            themeMode: ThemeState.of(context).themeMode,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.authenticationStateData.dispose();
    widget.layoutStateData.dispose();
    widget.routerDelegate.dispose();
    widget.routerStateData.dispose();
    widget.sharedAlbumStateData.dispose();
    widget.themeStateData.dispose();
    super.dispose();
  }
}
