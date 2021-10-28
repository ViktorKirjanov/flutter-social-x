import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_network_x/core/blocs/signup_cubit/signup_cubit.dart';
import 'package:social_network_x/pages/_widgets/primary_outlined_button.dart';

import '_widgets/auth_icon.dart';
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

  late SignUpCubit _signupCubit;

  @override
  void initState() {
    super.initState();
    _signupCubit = SignUpCubit();
  }

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
                const AuthIcon(
                  key: Key('signupIcon'),
                  iconData: FontAwesomeIcons.user,
                ),
                _buildEmailInput(),
                const SizedBox(height: 12.0),
                _buildPasswordInput(),
                const SizedBox(height: 24.0),
                _buildSignUpButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailInput() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      bloc: _signupCubit,
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (_, state) {
        return EmailInput(
          key: const Key('signupEmailInput'),
          emailController: _emailController,
          errorText: state.email.invalid ? 'invalid email' : null,
          onChanged: (email) => _signupCubit.emailChanged(email),
        );
      },
    );
  }

  Widget _buildPasswordInput() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      bloc: _signupCubit,
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (_, state) {
        return PasswordInput(
          key: const Key('signupPasswordInput'),
          passwordController: _passwordController,
          onChanged: (password) => _signupCubit.passwordChanged(password),
          errorText: state.password.invalid ? 'invalid password' : null,
        );
      },
    );
  }

  Widget _buildSignUpButton() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      bloc: _signupCubit,
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (_, state) {
        return PrimaryOutlinedButton(
          key: const Key('signupButton'),
          title: 'Register',
          action: () => _signupCubit.signUpFormSubmitted(),
        );
      },
    );
  }
}
