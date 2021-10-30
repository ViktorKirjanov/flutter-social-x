import 'package:flutter/material.dart';
import 'package:social_network_x/pages/_widgets/primary_outlined_button.dart';
import 'package:social_network_x/pages/auth/_widgets/google_button.dart';
import 'package:social_network_x/pages/auth/signin_page.dart';
import 'package:social_network_x/pages/auth/signup_page.dart';
import 'package:social_network_x/pages/init_page/widgets/logo.dart';

class InitPage extends StatelessWidget {
  const InitPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: InitPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Logo(),
              const SizedBox(height: 24.0),
              PrimaryOutlinedButton(
                key: const Key('signinButton'),
                title: 'Login with Email',
                action: () => Navigator.push(
                  context,
                  MaterialPageRoute<bool>(
                    builder: (BuildContext context) => const SigninPage(
                      key: Key('signinPageKey'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              PrimaryOutlinedButton(
                key: const Key('signupButton'),
                title: 'Create account',
                action: () => Navigator.push(
                  context,
                  MaterialPageRoute<bool>(
                    builder: (BuildContext context) =>
                        const SignupPage(key: Key('signupPageKey')),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              GoogleButton(
                key: const Key('googleButton'),
                action: () => {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
