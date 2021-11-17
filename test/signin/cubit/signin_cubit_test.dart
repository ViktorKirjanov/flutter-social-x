// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:social_network_x/core/blocs/signin_cubit/signin_cubit.dart';
import 'package:social_network_x/core/models/formz/email_model.dart';
import 'package:social_network_x/core/models/formz/password_model.dart';
import 'package:social_network_x/core/repositories/authentication_repository.dart';
import 'package:social_network_x/core/repositories/firebase_user_repository.dart';

import '../../consts.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockFirebaseUserRepository extends Mock
    implements FirebaseUserRepository {}

void main() {
  const invalidEmail = Email.dirty(invalidEmailString);
  const validEmail = Email.dirty(validEmailString);
  const invalidPassword = Password.dirty(invalidPasswordString);
  const validPassword = Password.dirty(validPasswordString);

  group('SignInCubit.', () {
    late AuthenticationRepository authenticationRepository;
    late MockFirebaseUserRepository userRepository;
    late SignInCubit signInCubit;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      userRepository = MockFirebaseUserRepository();
      signInCubit = SignInCubit(authenticationRepository, userRepository);

      when(
        () => authenticationRepository.logInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => userId);
    });

    test('initial state is SignInState', () {
      expect(
        SignInCubit(authenticationRepository, userRepository).state,
        SignInState(),
      );
    });

    group('emailChanged.', () {
      blocTest<SignInCubit, SignInState>(
        'emits [invalid] when email/password are invalid. ',
        build: () => signInCubit,
        act: (cubit) => cubit.emailChanged(invalidEmailString),
        expect: () => const <SignInState>[
          SignInState(
            email: invalidEmail,
            status: FormzStatus.invalid,
          ),
        ],
      );

      blocTest<SignInCubit, SignInState>(
        'emits [valid] when email/password are valid',
        build: () => signInCubit,
        seed: () => SignInState(password: validPassword),
        act: (cubit) => cubit.emailChanged(validEmailString),
        expect: () => const <SignInState>[
          SignInState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('passwordChanged.', () {
      blocTest<SignInCubit, SignInState>(
        'emits [invalid] when email/password are invalid',
        build: () => signInCubit,
        act: (cubit) => cubit.passwordChanged(invalidPasswordString),
        expect: () => const <SignInState>[
          SignInState(
            password: invalidPassword,
            status: FormzStatus.invalid,
          ),
        ],
      );

      blocTest<SignInCubit, SignInState>(
        'emits [valid] when email/password are valid',
        build: () => signInCubit,
        seed: () => SignInState(email: validEmail),
        act: (cubit) => cubit.passwordChanged(validPasswordString),
        expect: () => const <SignInState>[
          SignInState(
            email: validEmail,
            password: validPassword,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('logInWithCredentials.', () {
      blocTest<SignInCubit, SignInState>(
        'Does nothing when status is not validated',
        build: () => signInCubit,
        act: (cubit) => cubit.logInWithCredentials(),
        expect: () => const <SignInState>[],
      );

      blocTest<SignInCubit, SignInState>(
        'Calls logInWithEmailAndPassword with correct email and password',
        build: () => signInCubit,
        seed: () => SignInState(
          status: FormzStatus.valid,
          email: validEmail,
          password: validPassword,
        ),
        act: (cubit) => cubit.logInWithCredentials(),
        verify: (_) {
          verify(
            () => authenticationRepository.logInWithEmailAndPassword(
              email: validEmailString,
              password: validPasswordString,
            ),
          ).called(1);
        },
      );

      blocTest<SignInCubit, SignInState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when logInWithEmailAndPassword succeeds and has username',
        setUp: () {
          when(
            () => userRepository.hasUser(userId),
          ).thenAnswer((_) async => true);
        },
        build: () => signInCubit,
        seed: () => SignInState(
          status: FormzStatus.valid,
          email: validEmail,
          password: validPassword,
        ),
        act: (cubit) => cubit.logInWithCredentials(),
        expect: () => const <SignInState>[
          SignInState(
            status: FormzStatus.submissionInProgress,
            email: validEmail,
            password: validPassword,
            hasUsername: false,
          ),
          SignInState(
            status: FormzStatus.submissionSuccess,
            email: validEmail,
            password: validPassword,
            hasUsername: true,
          )
        ],
      );

      blocTest<SignInCubit, SignInState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when logInWithEmailAndPassword succeeds and has no username',
        setUp: () {
          when(
            () => userRepository.hasUser(userId),
          ).thenAnswer((_) async => false);
        },
        build: () => signInCubit,
        seed: () => SignInState(
          status: FormzStatus.valid,
          email: validEmail,
          password: validPassword,
        ),
        act: (cubit) => cubit.logInWithCredentials(),
        expect: () => const <SignInState>[
          SignInState(
            status: FormzStatus.submissionInProgress,
            email: validEmail,
            password: validPassword,
            hasUsername: false,
          ),
          SignInState(
            status: FormzStatus.submissionSuccess,
            email: validEmail,
            password: validPassword,
            hasUsername: false,
          )
        ],
      );

      blocTest<SignInCubit, SignInState>(
        'emits [submissionInProgress, submissionFailure] '
        'when logInWithEmailAndPassword fails',
        setUp: () {
          when(
            () => authenticationRepository.logInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenThrow(Exception('oops'));
        },
        build: () => signInCubit,
        seed: () => SignInState(
          status: FormzStatus.valid,
          email: validEmail,
          password: validPassword,
        ),
        act: (cubit) => cubit.logInWithCredentials(),
        expect: () => const <SignInState>[
          SignInState(
            status: FormzStatus.submissionInProgress,
            email: validEmail,
            password: validPassword,
            hasUsername: false,
          ),
          SignInState(
            status: FormzStatus.submissionFailure,
            email: validEmail,
            password: validPassword,
            hasUsername: false,
          )
        ],
      );
    });
  });
}
