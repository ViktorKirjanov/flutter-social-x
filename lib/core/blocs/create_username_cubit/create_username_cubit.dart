import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:social_network_x/core/models/user_model.dart';
import 'package:social_network_x/core/models/formz/username_model.dart';
import 'package:social_network_x/core/repositories/authentication_repository.dart';
import 'package:social_network_x/core/repositories/firebase_user_repository.dart';

part 'create_username_state.dart';

class CreateUsernameCubit extends Cubit<CreateUsernameState> {
  final FirebaseUserRepository _userRepository;
  final User _user;

  CreateUsernameCubit(this._userRepository, this._user)
      : super(CreateUsernameState(user: _user));

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([username]),
    ));
  }

  Future<void> createUsername() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _userRepository.createUser(
        _user,
        state.username.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzStatus.submissionFailure,
      ));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
