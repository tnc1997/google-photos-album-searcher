import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../common/cache_service.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final cacheService = context.read<CacheService>();
        final googleSignIn = context.read<GoogleSignIn>();
        final router = GoRouter.of(context);

        await cacheService.clear();
        await googleSignIn.signOut();
        router.go('/signin');
      },
      icon: const Icon(Icons.logout),
      label: const Text('SIGN OUT'),
    );
  }
}
