// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:social_network_x/core/blocs/signin_cubit/signin_cubit.dart';
import 'package:social_network_x/core/models/email_model.dart';
import 'package:social_network_x/core/models/password_model.dart';
import 'package:social_network_x/core/repositories/authentication_repository.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  const invalidEmailString = 'invalid';
  const invalidEmail = Email.dirty(invalidEmailString);

  const validEmailString = 'test@gmail.com';
  const validEmail = Email.dirty(validEmailString);

  const invalidPasswordString = 'invalid';
  const invalidPassword = Password.dirty(invalidPasswordString);

  const validPasswordString = 't0pS3cret1234!';
  const validPassword = Password.dirty(validPasswordString);

  group('SignInCubit', () {
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();

      when(
        () => authenticationRepository.logInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async {});
    });

    test('initial state is SignInState', () {
      expect(SignInCubit(authenticationRepository).state, SignInState());
    });

    group('emailChanged', () {
      blocTest<SignInCubit, SignInState>(
        'emits [invalid] when email/password are invalid',
        build: () => SignInCubit(authenticationRepository),
        act: (cubit) => cubit.emailChanged(invalidEmailString),
        expect: () => const <SignInState>[
          SignInState(email: invalidEmail, status: FormzStatus.invalid),
        ],
      );

      blocTest<SignInCubit, SignInState>(
        'emits [valid] when email/password are valid',
        build: () => SignInCubit(authenticationRepository),
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

    group('passwordChanged', () {
      blocTest<SignInCubit, SignInState>(
        'emits [invalid] when email/password are invalid',
        build: () => SignInCubit(authenticationRepository),
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
        build: () => SignInCubit(authenticationRepository),
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

    group('logInWithCredentials', () {
      blocTest<SignInCubit, SignInState>(
        'does nothing when status is not validated',
        build: () => SignInCubit(authenticationRepository),
        act: (cubit) => cubit.logInWithCredentials(),
        expect: () => const <SignInState>[],
      );

      blocTest<SignInCubit, SignInState>(
        'calls logInWithEmailAndPassword with correct email/password',
        build: () => SignInCubit(authenticationRepository),
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
        'when logInWithEmailAndPassword succeeds',
        build: () => SignInCubit(authenticationRepository),
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
          ),
          SignInState(
            status: FormzStatus.submissionSuccess,
            email: validEmail,
            password: validPassword,
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
        build: () => SignInCubit(authenticationRepository),
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
          ),
          SignInState(
            status: FormzStatus.submissionFailure,
            email: validEmail,
            password: validPassword,
          )
        ],
      );
    });
  });
}
