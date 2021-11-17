import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_network_x/core/blocs/app_bloc/app_bloc.dart';
import 'package:social_network_x/core/models/user_model.dart';
import 'package:social_network_x/core/repositories/authentication_repository.dart';
import 'package:social_network_x/pages/auth/signup_page.dart';
import 'package:mocktail/mocktail.dart';

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

  const signupPageKey = Key('signupPageKey');
  const signupIconKey = Key('signupIconKey');
  const signupEmailInputKey = Key('signupEmailInputKey');
  const signupPasswordInputKey = Key('signupPasswordInputKey');
  const signupButtonKey = Key('signupButtonKey');
  const popButtonKey = Key('popButtonKey');

  test('has a page', () {
    expect(SignupPage.page(), isA<MaterialPage>());
  });

  group('SignupPage.', () {
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

    testWidgets('finds SignupPage widgets.', (WidgetTester tester) async {
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: BlocProvider(
            create: (_) => appBloc,
            child: MaterialApp(
              home: BlocBuilder<AppBloc, AppState>(
                builder: (_, state) {
                  return const SignupPage(key: signupPageKey);
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byKey(signupPageKey), findsOneWidget);
      expect(find.byKey(signupIconKey), findsOneWidget);
      expect(find.byKey(signupEmailInputKey), findsOneWidget);
      expect(find.byKey(signupPasswordInputKey), findsOneWidget);
      expect(find.byKey(signupButtonKey), findsOneWidget);
      expect(find.byKey(popButtonKey), findsOneWidget);
    });

    group('Add email and password. ', () {
      testWidgets('Add valid email and password. ',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          RepositoryProvider.value(
            value: authenticationRepository,
            child: BlocProvider(
              create: (_) => appBloc,
              child: MaterialApp(
                home: BlocBuilder<AppBloc, AppState>(
                  builder: (_, state) {
                    return const SignupPage(key: signupPageKey);
                  },
                ),
              ),
            ),
          ),
        );

        await tester.enterText(
            find.byKey(signupEmailInputKey), validEmailString);
        await tester.enterText(
            find.byKey(signupPasswordInputKey), validPasswordString);
        await tester.tap(find.byKey(signupButtonKey));
        await tester.pump();

        expect(find.text(validEmailString), findsOneWidget);
        expect(find.text(validPasswordString), findsOneWidget);
      });

      testWidgets('Add invalid email and valid password.',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          RepositoryProvider<AuthenticationRepository>(
            create: (_) => MockAuthenticationRepository(),
            child: const MaterialApp(home: SignupPage(key: signupPageKey)),
          ),
        );

        await tester.enterText(
            find.byKey(signupEmailInputKey), invalidEmailString);
        await tester.enterText(
            find.byKey(signupPasswordInputKey), validPasswordString);
        await tester.tap(find.byKey(signupButtonKey));
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
            child: const MaterialApp(home: SignupPage(key: signupPageKey)),
          ),
        );

        await tester.enterText(
            find.byKey(signupEmailInputKey), validEmailString);
        await tester.enterText(
            find.byKey(signupPasswordInputKey), invalidPasswordString);
        await tester.tap(find.byKey(signupButtonKey));
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
            child: const MaterialApp(home: SignupPage(key: signupPageKey)),
          ),
        );

        await tester.enterText(
            find.byKey(signupEmailInputKey), invalidEmailString);
        await tester.enterText(
            find.byKey(signupPasswordInputKey), invalidPasswordString);
        await tester.tap(find.byKey(signupButtonKey));
        await tester.pump();

        expect(find.text(invalidEmailString), findsOneWidget);
        expect(find.text(invalidPasswordString), findsOneWidget);
        expect(find.text(invalidEmailMessageString), findsOneWidget);
        expect(find.text(invalidPasswordMessageString), findsOneWidget);
      });
    });
  });
}
