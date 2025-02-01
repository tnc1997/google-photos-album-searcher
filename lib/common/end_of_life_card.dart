import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EndOfLifeCard extends StatelessWidget {
  const EndOfLifeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xfffbbc05),
          brightness: Theme.of(context).brightness,
          dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
        ),
      ),
      child: Builder(
        builder: (context) {
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
                      'Please note that Album Searcher for Google Photos is end-of-life as of Monday 31 March 2025.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Unfortunately this decision has been forced upon us due to changes to the Google Photos APIs.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text:
                                'More information regarding these changes to the Google Photos APIs can be found in ',
                          ),
                          TextSpan(
                            text: 'this',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                await launchUrl(
                                  Uri.https(
                                    'developers.googleblog.com',
                                    '/google-photos-picker-api-launch-and-library-api-updates',
                                  ),
                                  webOnlyWindowName: '_blank',
                                );
                              },
                          ),
                          const TextSpan(
                            text: ' article.',
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
