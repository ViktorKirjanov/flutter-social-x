import 'package:bloc_test/bloc_test.dart';
import 'package:formz/formz.dart';

import 'package:social_network_x/core/blocs/signup_cubit/signup_cubit.dart';
import 'package:social_network_x/core/models/email_model.dart';
import 'package:social_network_x/core/models/password_model.dart';
import 'package:test/test.dart';

void main() {
  group('SignUpCubit', () {
    blocTest<SignUpCubit, SignUpState>(
      'emits [] when nothing is called',
      build: () => SignUpCubit(),
      expect: () => <SignUpState>[],
    );

    blocTest<SignUpCubit, SignUpState>(
      'emits [SignUpState] when email changed',
      build: () => SignUpCubit(),
      act: (cubit) => cubit.emailChanged('test@email.com'),
      expect: () => <SignUpState>[
        const SignUpState(
          email: Email.dirty('test@email.com'),
          password: Password.pure(),
          status: FormzStatus.invalid,
        )
      ],
    );

    blocTest<SignUpCubit, SignUpState>(
      'emits [SignUpState] when password changed',
      build: () => SignUpCubit(),
      act: (cubit) => cubit.passwordChanged('password123X!'),
      expect: () => <SignUpState>[
        const SignUpState(
          email: Email.pure(),
          password: Password.dirty('password123X!'),
          status: FormzStatus.invalid,
        )
      ],
    );

    blocTest<SignUpCubit, SignUpState>(
      'emits [SignUpState]s when email and password changed',
      build: () => SignUpCubit(),
      act: (cubit) => cubit
        ..emailChanged('test@email.com')
        ..passwordChanged('password123X')
        ..passwordChanged('password123X!'),
      expect: () => <SignUpState>[
        const SignUpState(
          email: Email.dirty('test@email.com'),
          password: Password.pure(),
          status: FormzStatus.invalid,
        ),
        const SignUpState(
          email: Email.dirty('test@email.com'),
          password: Password.dirty('password123X'),
          status: FormzStatus.invalid,
        ),
        const SignUpState(
          email: Email.dirty('test@email.com'),
          password: Password.dirty('password123X!'),
          status: FormzStatus.valid,
        )
      ],
    );
  });
}
