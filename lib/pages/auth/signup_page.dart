import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:social_network_x/core/blocs/signup_cubit/signup_cubit.dart';
import 'package:social_network_x/core/repositories/authentication_repository.dart';
import 'package:social_network_x/pages/_widgets/primary_outlined_button.dart';
import 'package:social_network_x/pages/_widgets/primary_outlined_loading_button.dart';
import 'package:social_network_x/pages/auth/create_username_page.dart';

import '_widgets/auth_icon.dart';
import '_widgets/email_input.dart';
import '_widgets/password_input.dart';
import '_widgets/pop_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: SignupPage());

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
    _signupCubit = SignUpCubit(context.read<AuthenticationRepository>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignUpCubit, SignUpState>(
        bloc: _signupCubit,
        listener: (context, state) async {
          if (state.status.isSubmissionSuccess) {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushAndRemoveUntil(
              MaterialPageRoute<bool>(
                builder: (BuildContext context) => const CreateUsernamePage(
                  key: Key('homePage'),
                ),
              ),
              (Route<dynamic> route) => false,
            );
          } else if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Loogin Failure'),
                  padding: const EdgeInsets.all(25),
                ),
              );
          }
        },
        child: Stack(
          children: [
            const PopButton(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AuthIcon(
                    key: Key('signupIconKey'),
                    iconData: FontAwesomeIcons.user,
                  ),
                  const SizedBox(height: 24.0),
                  _buildEmailInput(),
                  const SizedBox(height: 24.0),
                  _buildPasswordInput(),
                  const SizedBox(height: 24.0),
                  _buildSignUpButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailInput() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      bloc: _signupCubit,
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (_, state) {
        return EmailInput(
          key: const Key('signupEmailInputKey'),
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
          key: const Key('signupPasswordInputKey'),
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
        if (state.status == FormzStatus.submissionInProgress) {
          return const PrimaryOutlinedLoadingButton();
        }
        return PrimaryOutlinedButton(
          key: const Key('signupButtonKey'),
          title: 'Register',
          action: () => _signupCubit.signUpFormSubmitted(),
        );
      },
    );
  }
}
