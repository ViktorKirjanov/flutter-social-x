import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:social_network_x/core/models/user_model.dart';
import 'package:social_network_x/core/repositories/authentication_repository.dart';
import 'package:social_network_x/core/repositories/firebase_user_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthenticationRepository _authenticationRepository;
  final FirebaseUserRepository _userRepository;

  late StreamSubscription<User> _userSubscription;

  AppBloc({
    required AuthenticationRepository authenticationRepository,
    required FirebaseUserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AppState.unauthenticated()) {
    _userSubscription = _authenticationRepository.user.listen(_onUserChanged);
  }

  void _onUserChanged(User user) => add(AppUserChanged(user));

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppUserChanged) {
      yield* _mapUserChangedToState(event, state);
    } else if (event is AppLogoutRequested) {
      unawaited(_authenticationRepository.logOut());
    }
  }

  Stream<AppState> _mapUserChangedToState(
      AppUserChanged event, AppState state) async* {
    if (event.user.isNotEmpty) {
      var hasUsername = await _userRepository.hasUser(event.user.id);
      if (hasUsername) {
        yield AppState.authenticated(event.user);
      } else {
        yield AppState.authenticatedWithUsernameRequired(event.user);
      }
    } else {
      yield const AppState.unauthenticated();
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
