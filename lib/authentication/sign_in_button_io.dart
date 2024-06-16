import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'google_sign_in_account_notifier.dart';

Widget createSignInButton() {
  return const SignInButtonIo();
}

class SignInButtonIo extends StatefulWidget {
  const SignInButtonIo({
    super.key,
  });

  @override
  State<SignInButtonIo> createState() {
    return _SignInButtonIoState();
  }
}

class _SignInButtonIoState extends State<SignInButtonIo> {
  @override
  Widget build(BuildContext context) {
    if (context.watch<GoogleSignInAccountNotifier>().value != null) {
      return ElevatedButton(
        onPressed: () async {
          context.go('/albums');
        },
        child: const Text('CONTINUE'),
      );
    }

    return ElevatedButton(
      onPressed: () async {
        final googleSignIn = context.read<GoogleSignIn>();
        final router = GoRouter.of(context);

        if (await googleSignIn.signIn() != null) {
          if (defaultTargetPlatform == TargetPlatform.android) {
            await FirebaseAnalytics.instance.logLogin(
              loginMethod: 'Google',
            );
          }

          router.go('/albums');
        }
      },
      child: const Text('SIGN IN'),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<GoogleSignIn>().signInSilently();
  }
}
