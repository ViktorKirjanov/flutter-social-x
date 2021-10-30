import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_x/pages/home/home_page.dart';
import 'package:social_network_x/pages/init_page.dart';

import 'core/blocs/app_bloc/app_bloc.dart';
import 'core/blocs/bloc_observer.dart';
import 'core/repositories/authentication_repository.dart';
import 'theme.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  runApp(App(authenticationRepository: authenticationRepository));
}

class App extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;

  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: MaterialApp(
          title: 'Flutter Social network X',
          theme: theme,
          home: BlocBuilder<AppBloc, AppState>(
            builder: (_, state) {
              if (state.status == AppStatus.authenticated) {
                return const HomePage(key: Key('homePage'));
              } else if (state.status == AppStatus.unauthenticated) {
                return const InitPage(key: Key('initPage'));
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
