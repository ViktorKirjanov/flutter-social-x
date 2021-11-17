import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:social_network_x/core/blocs/app_bloc/app_bloc.dart';
import 'package:social_network_x/core/models/user_model.dart';
import 'package:social_network_x/core/repositories/authentication_repository.dart';
import 'package:social_network_x/pages/auth/create_username_page.dart';

import '../../consts.dart';
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
    expect(CreateUsernamePage.page(), isA<MaterialPage>());
  });

  group('CreateUsernamePage', () {
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
      final user = MockUser();
      when(() => user.id).thenReturn(userId);
      String? validEmailString;
      when(() => user.email).thenReturn(validEmailString);
      when(() => appBloc.state).thenReturn(AppState.authenticated(user));
    });

    const createUsernamePage = Key('createUsernamePage');
    const usernameIcon = Key('usernameIcon');
    const usernameInput = Key('usernameInput');
    const createButton = Key('createButton');

    testWidgets('finds CreateUsernamePage and widgets',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: BlocProvider(
            create: (_) => appBloc,
            child: MaterialApp(
              home: BlocBuilder<AppBloc, AppState>(
                builder: (_, state) {
                  return const CreateUsernamePage(key: createUsernamePage);
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byKey(createUsernamePage), findsOneWidget);
      expect(find.byKey(usernameIcon), findsOneWidget);
      expect(find.byKey(usernameInput), findsOneWidget);
      expect(find.byKey(createButton), findsOneWidget);
    });

    group('add username', () {
      testWidgets('valid username', (WidgetTester tester) async {
        await tester.pumpWidget(
          RepositoryProvider.value(
            value: authenticationRepository,
            child: BlocProvider(
              create: (_) => appBloc,
              child: MaterialApp(
                home: BlocBuilder<AppBloc, AppState>(
                  builder: (_, state) {
                    return const CreateUsernamePage(key: createUsernamePage);
                  },
                ),
              ),
            ),
          ),
        );
        await tester.enterText(find.byKey(usernameInput), validUsername);
        await tester.tap(find.byKey(createButton));
        await tester.pump();

        expect(find.text(validUsername), findsOneWidget);
        expect(find.text(invalidUsernameMessage), findsNothing);
      });

      testWidgets('invalid username', (WidgetTester tester) async {
        await tester.pumpWidget(
          RepositoryProvider.value(
            value: authenticationRepository,
            child: BlocProvider(
              create: (_) => appBloc,
              child: MaterialApp(
                home: BlocBuilder<AppBloc, AppState>(
                  builder: (_, state) {
                    return const CreateUsernamePage(key: createUsernamePage);
                  },
                ),
              ),
            ),
          ),
        );

        await tester.enterText(find.byKey(usernameInput), invalidUsername);
        await tester.pump();

        expect(find.text(invalidUsername), findsOneWidget);
        expect(find.text(invalidUsernameMessage), findsOneWidget);
      });
    });
  });
}
