import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_network_x/core/blocs/login_cubit/login_cubit.dart';
import 'package:social_network_x/pages/_widgets/primary_outlined_button.dart';

import '_widgets/auth_icon.dart';
import '_widgets/email_input.dart';
import '_widgets/password_input.dart';
import '_widgets/pop_button.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late LoginCubit _loginCubit;

  @override
  void initState() {
    super.initState();
    _loginCubit = LoginCubit();
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
                  key: Key('signinIcon'),
                  iconData: FontAwesomeIcons.envelope,
                ),
                const SizedBox(height: 24.0),
                _buildEmailInput(),
                const SizedBox(height: 24.0),
                _buildPasswordInput(),
                const SizedBox(height: 24.0),
                _buildLoginButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailInput() {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: _loginCubit,
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (_, state) {
        return EmailInput(
          key: const Key('signinEmailInput'),
          emailController: _emailController,
          errorText: state.email.invalid ? 'invalid email' : null,
          onChanged: (email) => _loginCubit.emailChanged(email),
        );
      },
    );
  }

  Widget _buildPasswordInput() {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: _loginCubit,
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (_, state) {
        return PasswordInput(
          key: const Key('signinPasswordInput'),
          passwordController: _passwordController,
          onChanged: (password) => _loginCubit.passwordChanged(password),
          errorText: state.password.invalid ? 'invalid password' : null,
        );
      },
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: _loginCubit,
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (_, state) {
        return PrimaryOutlinedButton(
          key: const Key('signinButton'),
          title: 'Login',
          action: () => _loginCubit.logInWithCredentials(),
        );
      },
    );
  }
}
