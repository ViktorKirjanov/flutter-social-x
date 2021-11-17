import 'package:flutter/material.dart';
import 'package:social_network_x/pages/init_page/init_page.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:social_network_x/core/blocs/app_bloc/app_bloc.dart';
import 'package:social_network_x/core/models/user_model.dart';
import 'package:social_network_x/core/repositories/authentication_repository.dart';

import '../../firebase_mock.dart';

class MockUser extends Mock implements User {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

class FakeAppEvent extends Fake implements AppEvent {}

class FakeAppState extends Fake implements AppState {}

void main() {
  setupFirebaseAuthMocks();

  test('has a page', () {
    expect(InitPage.page(), isA<MaterialPage>());
  });

  group('InitPage.', () {
    late AuthenticationRepository authenticationRepository;
    late AppBloc appBloc;

    setUpAll(() async {
      await Firebase.initializeApp();
      registerFallbackValue(FakeAppEvent());
      registerFallbackValue(FakeAppState());
    });

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      appBloc = MockAppBloc();
      when(() => appBloc.state).thenReturn(const AppState.unauthenticated());
    });
    testWidgets('Finds InitPage widgets.', (WidgetTester tester) async {
      const initPageKey = Key('initPageKey');
      const logoIconKey = Key('logoIconKey');
      const signinButtonKey = Key('signinButtonKey');
      const signupButtonKey = Key('signupButtonKey');
      const googleButtonKey = Key('googleButtonKey');

      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: BlocProvider(
            create: (_) => appBloc,
            child: MaterialApp(
              home: BlocBuilder<AppBloc, AppState>(
                builder: (_, state) {
                  return const InitPage(key: initPageKey);
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byKey(initPageKey), findsOneWidget);
      expect(find.byKey(logoIconKey), findsOneWidget);
      expect(find.byKey(signinButtonKey), findsOneWidget);
      expect(find.byKey(signupButtonKey), findsOneWidget);
      expect(find.byKey(googleButtonKey), findsOneWidget);
    });
  });
}
