import 'package:album_searcher_for_google_photos/router_delegates/main_router_delegate.dart';
import 'package:album_searcher_for_google_photos/states/router_state.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final RouterStateData routerStateData;

  const MainPage({
    Key? key,
    required this.routerStateData,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late ChildBackButtonDispatcher _backButtonDispatcher;
  late MainRouterDelegate _routerDelegate;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Widget body = Router(
          routerDelegate: _routerDelegate,
          backButtonDispatcher: _backButtonDispatcher..takePriority(),
        );

        Widget? bottomNavigationBar;

        if (constraints.maxWidth >= 768) {
          body = Row(
            children: [
              NavigationRail(
                extended: constraints.maxWidth >= 1024,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings_outlined),
                    selectedIcon: Icon(Icons.settings),
                    label: Text('Settings'),
                  ),
                ],
                selectedIndex: RouterState.of(context).selectedIndex,
                onDestinationSelected: (value) {
                  RouterState.of(context).selectedIndex = value;
                },
              ),
              VerticalDivider(
                width: 1,
                thickness: 1,
              ),
              Expanded(
                child: body,
              ),
            ],
          );
        } else {
          bottomNavigationBar = BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
                activeIcon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Settings',
                activeIcon: Icon(Icons.settings),
              ),
            ],
            onTap: (value) {
              RouterState.of(context).selectedIndex = value;
            },
            currentIndex: RouterState.of(context).selectedIndex,
            type: BottomNavigationBarType.fixed,
          );
        }

        return Scaffold(
          body: SafeArea(
            child: body,
          ),
          bottomNavigationBar: bottomNavigationBar,
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher!
        .createChildBackButtonDispatcher();
  }

  @override
  void didUpdateWidget(covariant MainPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _routerDelegate.routerStateData = widget.routerStateData;
  }

  @override
  void initState() {
    super.initState();
    _routerDelegate = MainRouterDelegate(
      routerStateData: widget.routerStateData,
    );
  }
}
