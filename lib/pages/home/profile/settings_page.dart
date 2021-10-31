import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_network_x/core/blocs/app_bloc/app_bloc.dart';
import 'package:social_network_x/pages/_widgets/primary_outlined_button.dart';
import 'package:social_network_x/pages/init_page/init_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: SettingsPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SettingsPage'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Spacer(),
              _buildLogoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(context) {
    return PrimaryOutlinedButton(
      key: const Key('logout'),
      title: 'Logout',
      action: () {
        context.read<AppBloc>().add(AppLogoutRequested());
        Navigator.of(
          context,
          rootNavigator: true,
        ).pushAndRemoveUntil(
          MaterialPageRoute<bool>(
            builder: (BuildContext context) => const InitPage(
              key: Key('initPage'),
            ),
          ),
          (Route<dynamic> route) => false,
        );
      },
    );
  }
}
