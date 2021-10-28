import 'package:flutter/material.dart';
import 'package:social_network_x/pages/_widgets/primary_outlined_button.dart';
import 'package:social_network_x/pages/auth/_widgets/google_button.dart';
import 'package:social_network_x/pages/auth/signin_page.dart';
import 'package:social_network_x/pages/auth/signup_page.dart';

class InitPage extends StatefulWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
