// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:social_network_x/core/blocs/signin_cubit/signin_cubit.dart';
import 'package:social_network_x/core/models/formz/email_model.dart';
import 'package:social_network_x/core/models/formz/password_model.dart';

void main() {
  const email = Email.dirty('email');
  const password = Password.dirty('password');

  group('SignInState.', () {
    test('Supports value comparisons.', () {
      expect(SignInState(), SignInState());
    });

    test('Returns same object when no properties are passed.', () {
      expect(SignInState().copyWith(), SignInState());
    });

    test('Returns object with updated status when status is passed.', () {
      expect(
        SignInState().copyWith(status: FormzStatus.pure),
        SignInState(),
      );
    });

    test('Returns object with updated email when email is passed.', () {
      expect(
        SignInState().copyWith(email: email),
        SignInState(email: email),
      );
    });

    test('returns object with updated password when password is passed', () {
      expect(
        SignInState().copyWith(password: password),
        SignInState(password: password),
      );
    });
  });
}
