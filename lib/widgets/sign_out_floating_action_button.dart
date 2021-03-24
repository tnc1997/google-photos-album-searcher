import 'package:album_searcher_for_google_photos/services/authentication/authentication_service.dart';
import 'package:flutter/material.dart';

class SignOutFloatingActionButton extends StatelessWidget {
  const SignOutFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.logout),
      tooltip: 'Sign out',
      onPressed: () async {
        try {
          await AuthenticationServiceScope.of(context).signOut();
        } catch (e) {
          await showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
