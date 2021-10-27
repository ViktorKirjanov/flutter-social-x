import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_network_x/pages/_widgets/primary_outlined_button.dart';

import '_widgets/email_input.dart';
import '_widgets/password_input.dart';
import '_widgets/pop_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const PopButton(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  key: const Key('signupIcon'),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withAlpha(75),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.user,
                      size: 50.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                EmailInput(
                  key: const Key('signupEmailInput'),
                  emailController: _emailController,
                ),
                const SizedBox(height: 12.0),
                PasswordInput(
                  key: const Key('signupPasswordInput'),
                  passwordController: _passwordController,
                ),
                const SizedBox(height: 24.0),
                PrimaryOutlinedButton(
                  key: const Key('signupButton'),
                  title: 'Register',
                  action: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
