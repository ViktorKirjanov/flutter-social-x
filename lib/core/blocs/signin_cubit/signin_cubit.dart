import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:social_network_x/core/models/formz/email_model.dart';
import 'package:social_network_x/core/models/formz/password_model.dart';
import 'package:social_network_x/core/repositories/authentication_repository.dart';
import 'package:social_network_x/core/repositories/firebase_user_repository.dart';

part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthenticationRepository _authenticationRepository;
  final FirebaseUserRepository _userRepository;

  SignInCubit(this._authenticationRepository, this._userRepository)
      : super(const SignInState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      var uid = await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      var hasUsername = await _userRepository.hasUser(uid);
      emit(
        state.copyWith(
          hasUsername: hasUsername,
          status: FormzStatus.submissionSuccess,
        ),
      );
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzStatus.submissionFailure,
      ));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
