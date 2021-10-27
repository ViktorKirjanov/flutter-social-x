import 'package:flutter/material.dart';
import 'package:social_network_x/pages/_widgets/primary_outlined_button.dart';
import 'package:social_network_x/pages/auth/_widgets/google_button.dart';
import 'package:social_network_x/pages/auth/signin_page.dart';
import 'package:social_network_x/pages/auth/signup_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
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
                    builder: (BuildContext context) => const SigninPage(),
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
                    builder: (BuildContext context) => const SignupPage(),
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
