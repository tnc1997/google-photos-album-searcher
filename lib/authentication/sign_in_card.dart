import 'package:flutter/material.dart';

import '../common/terms_of_service_text.dart';
import 'sign_in_button.dart';

class SignInCard extends StatelessWidget {
  const SignInCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Sign in with Google to continue to Album Searcher for Google Photos.',
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Album Searcher for Google Photos will have read access to your photos library.',
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: TermsOfServiceText(),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: createSignInButton(),
            ),
          ],
        ),
      ),
    );
  }
}
