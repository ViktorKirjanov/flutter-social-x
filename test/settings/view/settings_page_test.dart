import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_network_x/core/models/user_model.dart';
import 'package:social_network_x/pages/home/profile/settings_page.dart';
import '../../consts.dart';
import '../../firebase_mock.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:social_network_x/core/blocs/app_bloc/app_bloc.dart';
import 'package:social_network_x/core/repositories/authentication_repository.dart';

class MockUser extends Mock implements User {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

class FakeAppEvent extends Fake implements AppEvent {}

class FakeAppState extends Fake implements AppState {}

void main() {
  setupFirebaseAuthMocks();

  test('has a page', () {
    expect(SettingsPage.page(), isA<MaterialPage>());
  });
  group('SettingsPage.', () {
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
      when(() => user.email).thenReturn(validEmailString);
      when(() => appBloc.state).thenReturn(AppState.authenticated(user));
    });

    testWidgets('Finds SettingsPage widgets.', (WidgetTester tester) async {
      const settingsPageKey = Key('settingsPageKey');
      const logoutKey = Key('logout');

      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: BlocProvider(
            create: (_) => appBloc,
            child: MaterialApp(
              home: BlocBuilder<AppBloc, AppState>(
                builder: (_, state) {
                  return const SettingsPage(key: settingsPageKey);
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byKey(settingsPageKey), findsOneWidget);
      expect(find.byKey(logoutKey), findsOneWidget);
    });
  });
}
