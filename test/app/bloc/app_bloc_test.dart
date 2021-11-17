// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:social_network_x/core/blocs/app_bloc/app_bloc.dart';
import 'package:social_network_x/core/models/user_model.dart';
import 'package:social_network_x/core/repositories/authentication_repository.dart';
import 'package:social_network_x/core/repositories/firebase_user_repository.dart';

import '../../consts.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockUser extends Mock implements User {}

class MockFirebaseUserRepository extends Mock
    implements FirebaseUserRepository {}

void main() {
  group('AppBloc', () {
    final user = MockUser();
    late AuthenticationRepository authenticationRepository;
    late FirebaseUserRepository userRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      userRepository = MockFirebaseUserRepository();

      when(() => authenticationRepository.user).thenAnswer(
        (_) => Stream.empty(),
      );
    });

    test('initial state is unauthenticated when user is empty', () {
      expect(
        AppBloc(
                authenticationRepository: authenticationRepository,
                userRepository: userRepository)
            .state,
        AppState.unauthenticated(),
      );
    });

    group('UserChanged.', () {
      blocTest<AppBloc, AppState>(
        'Emits authenticated when user is not empty wuth username',
        setUp: () {
          when(() => user.id).thenReturn(userId);
          when(() => user.isNotEmpty).thenReturn(true);
          when(() => userRepository.hasUser(userId))
              .thenAnswer((_) async => true);

          when(() => authenticationRepository.user).thenAnswer(
            (_) => Stream.value(user),
          );
        },
        build: () => AppBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        seed: () => AppState.unauthenticated(),
        expect: () => [AppState.authenticated(user)],
      );

      blocTest<AppBloc, AppState>(
        'Emits authenticated when user is not empty wuthout username',
        setUp: () {
          when(() => user.id).thenReturn(userId);
          when(() => user.isNotEmpty).thenReturn(true);
          when(() => userRepository.hasUser(userId))
              .thenAnswer((_) async => false);

          when(() => authenticationRepository.user).thenAnswer(
            (_) => Stream.value(user),
          );
        },
        build: () => AppBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        seed: () => AppState.unauthenticated(),
        expect: () => [AppState.authenticatedWithUsernameRequired(user)],
      );

      blocTest<AppBloc, AppState>(
        'emits unauthenticated when user is empty',
        setUp: () {
          when(() => authenticationRepository.user).thenAnswer(
            (_) => Stream.value(User.empty),
          );
        },
        build: () => AppBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        expect: () => [AppState.unauthenticated()],
      );
    });

    group('LogoutRequested', () {
      blocTest<AppBloc, AppState>(
        'invokes logOut',
        build: () => AppBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        act: (bloc) => bloc.add(AppLogoutRequested()),
        verify: (_) {
          verify(() => authenticationRepository.logOut()).called(1);
        },
      );
    });
  });
}
