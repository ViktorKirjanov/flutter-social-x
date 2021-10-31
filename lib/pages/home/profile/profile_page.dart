import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_network_x/pages/_widgets/primary_outlined_button.dart';

import 'settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: ProfilePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfilePage'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Spacer(),
              PrimaryOutlinedButton(
                title: 'Settings',
                action: () => Navigator.of(
                  context,
                  // rootNavigator: true,
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
