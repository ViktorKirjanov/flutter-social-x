part of 'create_username_cubit.dart';

class CreateUsernameState extends Equatable {
  final User user;
  final Username username;
  final FormzStatus status;
  final String? errorMessage;

  const CreateUsernameState({
    required this.user,
    this.username = const Username.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  @override
  List<Object> get props => [user, username, status];

  CreateUsernameState copyWith({
    Username? username,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return CreateUsernameState(
      user: user,
      username: username ?? this.username,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
