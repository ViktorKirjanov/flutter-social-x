import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:social_network_x/core/blocs/app_bloc/app_bloc.dart';
import 'package:social_network_x/core/models/user_model.dart';
import 'package:social_network_x/core/repositories/authentication_repository.dart';
import 'package:social_network_x/core/repositories/firebase_user_repository.dart';
import 'package:social_network_x/main.dart';
import 'package:social_network_x/pages/home/home_page.dart';
import 'package:social_network_x/pages/init_page/init_page.dart';

import '../../consts.dart';

class MockUser extends Mock implements User {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockFirebaseUserRepository extends Mock
    implements FirebaseUserRepository {}

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

class FakeAppEvent extends Fake implements AppEvent {}

class FakeAppState extends Fake implements AppState {}

void main() {
  group('App', () {
    late AuthenticationRepository authenticationRepository;
    late FirebaseUserRepository userRepository;

    setUpAll(() {
      registerFallbackValue(FakeAppEvent());
      registerFallbackValue(FakeAppState());
    });

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      userRepository = MockFirebaseUserRepository();

      when(() => authenticationRepository.user).thenAnswer(
        (_) => const Stream.empty(),
      );
    });

    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(
        App(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
      );
      await tester.pump();
      expect(find.byType(App), findsOneWidget);
    });
  });

  group('AppView', () {
    late AuthenticationRepository authenticationRepository;
    late AppBloc appBloc;

    setUpAll(() {
      registerFallbackValue(FakeAppEvent());
      registerFallbackValue(FakeAppState());
    });

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      appBloc = MockAppBloc();
    });

    testWidgets('navigates to LoginPage when unauthenticated', (tester) async {
      when(() => appBloc.state).thenReturn(const AppState.unauthenticated());
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: BlocProvider(
            create: (_) => appBloc,
            child: MaterialApp(
              title: 'Flutter Social network X',
              home: BlocBuilder<AppBloc, AppState>(
                builder: (_, state) {
                  if (state.status == AppStatus.authenticated) {
                    return HomePage(key: const Key('homePage'));
                  } else if (state.status == AppStatus.unauthenticated) {
                    return const InitPage(key: Key('initPage'));
                  }
                  return Container();
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(InitPage), findsOneWidget);
    });

    testWidgets('navigates to HomePage when authenticated', (tester) async {
      final user = MockUser();
      when(() => user.id).thenReturn(userId);
      when(() => user.email).thenReturn(validEmailString);
      when(() => appBloc.state).thenReturn(AppState.authenticated(user));
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: BlocProvider(
            create: (_) => appBloc,
            child: MaterialApp(
              title: 'Flutter Social network X',
              home: BlocBuilder<AppBloc, AppState>(
                builder: (_, state) {
                  if (state.status == AppStatus.authenticated) {
                    return HomePage(key: const Key('homePage'));
                  } else if (state.status == AppStatus.unauthenticated) {
                    return const InitPage(key: Key('initPage'));
                  }
                  return Container();
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
