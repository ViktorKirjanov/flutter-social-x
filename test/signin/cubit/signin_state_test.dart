// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:social_network_x/core/blocs/signin_cubit/signin_cubit.dart';
import 'package:social_network_x/core/models/email_model.dart';
import 'package:social_network_x/core/models/password_model.dart';

void main() {
  const email = Email.dirty('email');
  const password = Password.dirty('password');

  group('SignInState', () {
    test('supports value comparisons', () {
      expect(SignInState(), SignInState());
    });

    test('returns same object when no properties are passed', () {
      expect(SignInState().copyWith(), SignInState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        SignInState().copyWith(status: FormzStatus.pure),
        SignInState(),
      );
    });

    test('returns object with updated email when email is passed', () {
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
