import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsOfServiceText extends StatelessWidget {
  const TermsOfServiceText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text:
                'By continuing to Album Searcher for Google Photos you agree to the ',
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
    );
  }
}
