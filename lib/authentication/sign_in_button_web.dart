import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_web/web_only.dart';
import 'package:provider/provider.dart';

import 'google_sign_in_account_notifier.dart';

Widget createSignInButton() {
  return const SignInButtonWeb();
}

class SignInButtonWeb extends StatefulWidget {
  const SignInButtonWeb({
    super.key,
  });

  @override
  State<SignInButtonWeb> createState() {
    return _SignInButtonWebState();
  }
}

class _SignInButtonWebState extends State<SignInButtonWeb> {
  @override
  Widget build(BuildContext context) {
    if (context.watch<GoogleSignInAccountNotifier>().value != null) {
      return ElevatedButton(
        onPressed: () async {
          final googleSignIn = context.read<GoogleSignIn>();
          final router = GoRouter.of(context);

          if (await googleSignIn.requestScopes(googleSignIn.scopes)) {
            await FirebaseAnalytics.instance.logLogin(
              loginMethod: 'Google',
            );

            router.go('/albums');
          }
        },
        child: const Text('GRANT CONSENT'),
      );
    }

    return renderButton(
      configuration: GSIButtonConfiguration(
        theme: switch (Theme.of(context).brightness) {
          Brightness.dark => GSIButtonTheme.filledBlack,
          Brightness.light => GSIButtonTheme.filledBlue,
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<GoogleSignIn>().signInSilently();
  }
}
