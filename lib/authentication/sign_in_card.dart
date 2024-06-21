import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                'Read access to your photos library is required to enable searching.',
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Usage of data adheres to the ',
                    ),
                    TextSpan(
                      text: 'Google API Services User Data Policy',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          await launchUrl(
                            Uri.https(
                              'developers.google.com',
                              '/terms/api-services-user-data-policy',
                            ),
                            webOnlyWindowName: '_blank',
                          );
                        },
                    ),
                    const TextSpan(
                      text: '.',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'By continuing you agree to the ',
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          await launchUrl(
                            Uri.https(
                              'googlephotosalbumsearcher.thomasclark.app',
                              '/privacy.html',
                            ),
                            webOnlyWindowName: '_blank',
                          );
                        },
                    ),
                    const TextSpan(
                      text: ' and the ',
                    ),
                    TextSpan(
                      text: 'Terms of Service',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          await launchUrl(
                            Uri.https(
                              'googlephotosalbumsearcher.thomasclark.app',
                              '/terms.html',
                            ),
                            webOnlyWindowName: '_blank',
                          );
                        },
                    ),
                    const TextSpan(
                      text: '.',
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
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
