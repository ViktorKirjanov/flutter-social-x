import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_x/pages/init_page.dart';

import 'core/blocs/bloc_observer.dart';
import 'theme.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Social network X',
      theme: theme,
      home: const InitPage(key: Key('initPage')),
    );
  }
}
