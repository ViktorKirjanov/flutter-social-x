import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:social_network_x/core/blocs/app_bloc/app_bloc.dart';
import 'package:social_network_x/core/models/user_model.dart';
import 'package:social_network_x/core/repositories/authentication_repository.dart';
import 'package:social_network_x/pages/auth/signin_page.dart';

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

  const signinPageKey = Key('signinPage');
  const signinIconKey = Key('signinIcon');
  const signinEmailInputKey = Key('emailInputKey');
  const signinPasswordInputKey = Key('passwordInputKey');
  const signinButtonKey = Key('signinButtonKey');
  const popButtonKey = Key('popButtonKey');

  test('has a page', () {
    expect(SigninPage.page(), isA<MaterialPage>());
  });

  group('SigninPage.', () {
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
    testWidgets('finds SigninPage widgets.', (WidgetTester tester) async {
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: BlocProvider(
            create: (_) => appBloc,
            child: MaterialApp(
              home: BlocBuilder<AppBloc, AppState>(
                builder: (_, state) {
                  return const SigninPage(key: signinPageKey);
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byKey(signinPageKey), findsOneWidget);
      expect(find.byKey(signinIconKey), findsOneWidget);
      expect(find.byKey(signinEmailInputKey), findsOneWidget);
      expect(find.byKey(signinPasswordInputKey), findsOneWidget);
      expect(find.byKey(signinButtonKey), findsOneWidget);
      expect(find.byKey(popButtonKey), findsOneWidget);
    });

    group('Add email and password.', () {
      testWidgets('Add valid email and password.', (WidgetTester tester) async {
        await tester.pumpWidget(
          RepositoryProvider<AuthenticationRepository>(
            create: (_) => MockAuthenticationRepository(),
            child: const MaterialApp(home: SigninPage(key: signinPageKey)),
          ),
        );

        await tester.enterText(
            find.byKey(signinEmailInputKey), validEmailString);
        await tester.enterText(
            find.byKey(signinPasswordInputKey), validPasswordString);
        await tester.tap(find.byKey(signinButtonKey));
        await tester.pump();

        expect(find.text(validEmailString), findsOneWidget);
        expect(find.text(validPasswordString), findsOneWidget);
        expect(find.text(invalidEmailMessageString), findsNothing);
        expect(find.text(invalidPasswordMessageString), findsNothing);
      });

      testWidgets('Add invalid email and valid password.',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          RepositoryProvider<AuthenticationRepository>(
            create: (_) => MockAuthenticationRepository(),
            child: const MaterialApp(home: SigninPage(key: signinPageKey)),
          ),
        );

        await tester.enterText(
            find.byKey(signinEmailInputKey), invalidEmailString);
        await tester.enterText(
            find.byKey(signinPasswordInputKey), validPasswordString);
        await tester.tap(find.byKey(signinButtonKey));
        await tester.pump();

        expect(find.text(invalidEmailString), findsOneWidget);
        expect(find.text(validPasswordString), findsOneWidget);
        expect(find.text(invalidEmailMessageString), findsOneWidget);
        expect(find.text(invalidPasswordMessageString), findsNothing);
      });

      testWidgets('add valid email and invalidvalid password',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          RepositoryProvider<AuthenticationRepository>(
            create: (_) => MockAuthenticationRepository(),
            child: const MaterialApp(home: SigninPage(key: signinPageKey)),
          ),
        );

        await tester.enterText(
            find.byKey(signinEmailInputKey), validEmailString);
        await tester.enterText(
            find.byKey(signinPasswordInputKey), invalidPasswordString);
        await tester.tap(find.byKey(signinButtonKey));
        await tester.pump();

        expect(find.text(validEmailString), findsOneWidget);
        expect(find.text(invalidPasswordString), findsOneWidget);
        expect(find.text(invalidEmailMessageString), findsNothing);
        expect(find.text(invalidPasswordMessageString), findsOneWidget);
      });

      testWidgets('add invalid email and  password',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          RepositoryProvider<AuthenticationRepository>(
            create: (_) => MockAuthenticationRepository(),
            child: const MaterialApp(home: SigninPage(key: signinPageKey)),
          ),
        );

        await tester.enterText(
            find.byKey(signinEmailInputKey), invalidEmailString);
        await tester.enterText(
            find.byKey(signinPasswordInputKey), invalidPasswordString);
        await tester.tap(find.byKey(signinButtonKey));
        await tester.pump();

        expect(find.text(invalidEmailString), findsOneWidget);
        expect(find.text(invalidPasswordString), findsOneWidget);
        expect(find.text(invalidEmailMessageString), findsOneWidget);
        expect(find.text(invalidPasswordMessageString), findsOneWidget);
      });
    });
  });
}
