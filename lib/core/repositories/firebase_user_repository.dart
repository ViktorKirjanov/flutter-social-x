import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_network_x/core/models/account_model.dart';
import 'package:social_network_x/core/models/user_model.dart';

import 'user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  final _userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<bool> hasUser(String uid) async {
    var doc = await _userCollection.doc(uid).get();
    return doc.exists;
  }

  @override
  createUser(User user, String username) async {
    var account = Account(user.id, username, user.email!, DateTime.now());
    await _userCollection.doc(user.id).set((account.toJson()));
  }
}
