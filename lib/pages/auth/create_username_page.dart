import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:social_network_x/core/blocs/app_bloc/app_bloc.dart';
import 'package:social_network_x/core/blocs/create_username_cubit/create_username_cubit.dart';
import 'package:social_network_x/core/repositories/firebase_user_repository.dart';
import 'package:social_network_x/pages/_widgets/primary_outlined_button.dart';
import 'package:social_network_x/pages/_widgets/primary_outlined_loading_button.dart';
import 'package:social_network_x/pages/home/home_page.dart';

import '_widgets/auth_icon.dart';

class CreateUsernamePage extends StatefulWidget {
  const CreateUsernamePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: CreateUsernamePage());

  @override
  State<CreateUsernamePage> createState() => _CreateUsernamePageState();
}

class _CreateUsernamePageState extends State<CreateUsernamePage> {
  final TextEditingController _nameController = TextEditingController();

  late CreateUsernameCubit _createUsernameCubit;

  @override
  void initState() {
    var user = BlocProvider.of<AppBloc>(context).state.user;
    _createUsernameCubit = CreateUsernameCubit(FirebaseUserRepository(), user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add your name')),
      body: BlocListener<CreateUsernameCubit, CreateUsernameState>(
        bloc: _createUsernameCubit,
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
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
          } else if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Create user failure'),
                  padding: const EdgeInsets.all(25),
                ),
              );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const AuthIcon(
                key: Key('usernameIcon'),
                iconData: FontAwesomeIcons.users,
              ),
              const SizedBox(height: 24.0),
              _buildUsernameInput(),
              const SizedBox(height: 24.0),
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameInput() {
    return BlocBuilder<CreateUsernameCubit, CreateUsernameState>(
      bloc: _createUsernameCubit,
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return TextFormField(
          key: const Key('usernameInput'),
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Name',
            errorText: state.username.invalid ? 'invalid username' : null,
          ),
          onChanged: (val) => _createUsernameCubit.usernameChanged(val),
        );
      },
    );
  }

  Widget _buildButton() {
    return BlocBuilder<CreateUsernameCubit, CreateUsernameState>(
      bloc: _createUsernameCubit,
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (_, state) {
        if (state.status == FormzStatus.submissionInProgress) {
          return const PrimaryOutlinedLoadingButton();
        }
        return PrimaryOutlinedButton(
          key: const Key('createButton'),
          title: 'Create',
          action: () => _createUsernameCubit.createUsername(),
        );
      },
    );
  }
}
