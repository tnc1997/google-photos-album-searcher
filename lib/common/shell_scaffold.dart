import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellScaffold extends StatelessWidget {
  const ShellScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    void onDestinationSelected(int index) {
      switch (index) {
        case 0:
          context.go('/albums');
          break;
        case 1:
          context.go('/settings');
          break;
      }
    }

    var selectedIndex = 0;

    if (GoRouterState.of(context).fullPath case final path?) {
      switch (path) {
        case '/albums':
        case '/albums/:albumId':
          selectedIndex = 0;
          break;
        case '/settings':
          selectedIndex = 1;
          break;
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.minWidth >= 1024) {
          return Scaffold(
            body: SafeArea(
              child: Row(
                children: [
                  NavigationRail(
                    extended: true,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.photo_album),
                        label: Text('Albums'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.settings),
                        label: Text('Settings'),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: onDestinationSelected,
                  ),
                  const VerticalDivider(
                    width: 1,
                  ),
                  Expanded(
                    child: child,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: SafeArea(
              child: child,
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: selectedIndex,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.photo_album),
                  label: 'Albums',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
              onDestinationSelected: onDestinationSelected,
            ),
          );
        }
      },
    );
  }
}
