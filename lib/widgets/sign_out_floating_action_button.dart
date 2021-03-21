import 'package:album_searcher_for_google_photos/services/storage_service.dart';
import 'package:album_searcher_for_google_photos/states/authentication_state.dart';
import 'package:album_searcher_for_google_photos/states/shared_album_state.dart';
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
          await StorageServiceScope.of(context).removeCredentials();
          await StorageServiceScope.of(context).removeSharedAlbums();
          AuthenticationState.of(context).client = null;
          SharedAlbumState.of(context).sharedAlbums = null;
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
