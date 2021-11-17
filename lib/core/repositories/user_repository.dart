import 'package:social_network_x/core/models/user_model.dart';

abstract class UserRepository {
  Future<bool> hasUser(String uid);

  Future<void> createUser(User user, String username);
}
