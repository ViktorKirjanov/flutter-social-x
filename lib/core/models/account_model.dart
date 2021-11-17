import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final String id;
  final String username;
  final String email;

  const Account(this.id, this.username, this.email);

  Map<String, Object> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
    };
  }

  @override
  List<Object> get props => [id, username];

  @override
  String toString() {
    return 'Account { id: $id, username: $username, email: $email }';
  }

  static Account fromJson(Map<String, Object> json) {
    return Account(
      json["id"] as String,
      json["username"] as String,
      json["email"] as String,
    );
  }

  static Account fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snap) {
    return Account(
      snap.id,
      snap.data()!['username'],
      snap.data()!['email'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "username": username,
      "email": email,
    };
  }
}
