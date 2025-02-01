import 'package:flutter/material.dart';

import '../common/end_of_life_card.dart';
import '../common/welcome_card.dart';
import 'sign_in_card.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 800,
            ),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  WelcomeCard(),
                  SignInCard(),
                  EndOfLifeCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
