import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:social_network_x/core/blocs/app_bloc/app_bloc.dart';
import 'package:social_network_x/pages/_widgets/primary_outlined_button.dart';

import '../init_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Scaffold(
      key: widget.key,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.id),
            const SizedBox(height: 4.0),
            Text(user.email ?? ''),
            const SizedBox(height: 4.0),
            Text(user.name ?? ''),
            const SizedBox(height: 4.0),
            PrimaryOutlinedButton(
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
                }
                // BlocProvider.of<AppBloc>(context).add(AppLogoutRequested()),
                ),
          ],
        ),
      ),
    );
  }
}
