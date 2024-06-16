import 'package:google_sign_in/google_sign_in.dart';

import '../common/stream_notifier.dart';

class GoogleSignInAccountNotifier extends StreamNotifier<GoogleSignInAccount?> {
  GoogleSignInAccountNotifier({
    required GoogleSignIn googleSignIn,
  }) : super(
          stream: googleSignIn.onCurrentUserChanged,
          initialValue: null,
        );
}
