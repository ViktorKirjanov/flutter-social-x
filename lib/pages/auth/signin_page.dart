import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:social_network_x/core/blocs/signin_cubit/signin_cubit.dart';
import 'package:social_network_x/core/repositories/authentication_repository.dart';
import 'package:social_network_x/core/repositories/firebase_user_repository.dart';
import 'package:social_network_x/pages/_widgets/primary_outlined_button.dart';
import 'package:social_network_x/pages/_widgets/primary_outlined_loading_button.dart';
import 'package:social_network_x/pages/home/home_page.dart';

import '_widgets/auth_icon.dart';
import '_widgets/email_input.dart';
import '_widgets/password_input.dart';
import '_widgets/pop_button.dart';
import 'create_username_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: SigninPage());

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late SignInCubit _signInCubit;

  @override
  void initState() {
    super.initState();
    _signInCubit = SignInCubit(
      context.read<AuthenticationRepository>(),
      FirebaseUserRepository(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignInCubit, SignInState>(
        bloc: _signInCubit,
        listener: (context, state) async {
          if (state.status.isSubmissionSuccess) {
            if (state.hasUsername) {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pushAndRemoveUntil(
                MaterialPageRoute<bool>(
                  builder: (BuildContext context) => HomePage(
                    key: const Key('homePage'),
                  ),
                ),
                (Route<dynamic> route) => false,
              );
            } else {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pushAndRemoveUntil(
                MaterialPageRoute<bool>(
                  builder: (BuildContext context) => const CreateUsernamePage(
                    key: Key('createUsernamePage'),
                  ),
                ),
                (Route<dynamic> route) => false,
              );
            }
          } else if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Sign Up Failure'),
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
      ),
    );
  }

  Widget _buildEmailInput() {
    return BlocBuilder<SignInCubit, SignInState>(
      bloc: _signInCubit,
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (_, state) {
        return EmailInput(
          emailController: _emailController,
          errorText: state.email.invalid ? 'invalid email' : null,
          onChanged: (email) => _signInCubit.emailChanged(email),
        );
      },
    );
  }

  Widget _buildPasswordInput() {
    return BlocBuilder<SignInCubit, SignInState>(
      bloc: _signInCubit,
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (_, state) {
        return PasswordInput(
          passwordController: _passwordController,
          onChanged: (password) => _signInCubit.passwordChanged(password),
          errorText: state.password.invalid ? 'invalid password' : null,
        );
      },
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<SignInCubit, SignInState>(
      bloc: _signInCubit,
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (_, state) {
        if (state.status == FormzStatus.submissionInProgress) {
          return const PrimaryOutlinedLoadingButton();
        }
        return PrimaryOutlinedButton(
          key: const Key('signinButtonKey'),
          title: 'Login',
          action: () => _signInCubit.logInWithCredentials(),
        );
      },
    );
  }
}
