import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_x/core/blocs/app_bloc/app_bloc.dart';
import 'package:social_network_x/pages/_widgets/primary_outlined_button.dart';

import 'settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: ProfilePage());

  @override
  Widget build(BuildContext context) {
    var user = BlocProvider.of<AppBloc>(context).state.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(user.id),
              Text(user.email!),
              const Spacer(),
              PrimaryOutlinedButton(
                title: 'Settings',
                action: () => Navigator.of(
                  context,
                  rootNavigator: true,
                ).push(
                  MaterialPageRoute<bool>(
                    builder: (BuildContext context) => const SettingsPage(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
