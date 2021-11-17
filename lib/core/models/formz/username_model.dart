import 'package:formz/formz.dart';

enum UsernamelValidationError { invalid }

class Username extends FormzInput<String, UsernamelValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  static final RegExp _usernamelRegExp = RegExp(r'^[\w]*$');

  @override
  UsernamelValidationError? validator(String? value) {
    return _usernamelRegExp.hasMatch(value ?? '')
        ? null
        : UsernamelValidationError.invalid;
  }
}
