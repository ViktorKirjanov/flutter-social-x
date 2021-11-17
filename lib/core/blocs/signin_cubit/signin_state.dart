part of 'signin_cubit.dart';

class SignInState extends Equatable {
  final String? uid;
  final bool hasUsername;
  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;

  const SignInState({
    this.uid,
    this.hasUsername = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  @override
  List<Object> get props => [hasUsername, email, password, status];

  SignInState copyWith({
    String? uid,
    bool? hasUsername,
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return SignInState(
      uid: uid ?? this.uid,
      hasUsername: hasUsername ?? this.hasUsername,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
