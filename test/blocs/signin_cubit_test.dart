import 'package:bloc_test/bloc_test.dart';
import 'package:formz/formz.dart';
import 'package:social_network_x/core/blocs/login_cubit/login_cubit.dart';

import 'package:social_network_x/core/models/email_model.dart';
import 'package:social_network_x/core/models/password_model.dart';
import 'package:test/test.dart';

void main() {
  group('LoginCubit', () {
    blocTest<LoginCubit, LoginState>(
      'emits [] when nothing is called',
      build: () => LoginCubit(),
      expect: () => <LoginState>[],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [LoginState] when email changed',
      build: () => LoginCubit(),
      act: (cubit) => cubit.emailChanged('test@email.com'),
      expect: () => <LoginState>[
        const LoginState(
          email: Email.dirty('test@email.com'),
          password: Password.pure(),
          status: FormzStatus.invalid,
        )
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [LoginState] when password changed',
      build: () => LoginCubit(),
      act: (cubit) => cubit.passwordChanged('password123X!'),
      expect: () => <LoginState>[
        const LoginState(
          email: Email.pure(),
          password: Password.dirty('password123X!'),
          status: FormzStatus.invalid,
        )
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [LoginState]s when email and password changed',
      build: () => LoginCubit(),
      act: (cubit) => cubit
        ..emailChanged('test@email.com')
        ..passwordChanged('password123X')
        ..passwordChanged('password123X!'),
      expect: () => <LoginState>[
        const LoginState(
          email: Email.dirty('test@email.com'),
          password: Password.pure(),
          status: FormzStatus.invalid,
        ),
        const LoginState(
          email: Email.dirty('test@email.com'),
          password: Password.dirty('password123X'),
          status: FormzStatus.invalid,
        ),
        const LoginState(
          email: Email.dirty('test@email.com'),
          password: Password.dirty('password123X!'),
          status: FormzStatus.valid,
        )
      ],
    );
  });
}
