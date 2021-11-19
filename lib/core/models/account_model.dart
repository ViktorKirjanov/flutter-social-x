import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final String id;
  final String username;
  final String email;
  final DateTime created;

  const Account(this.id, this.username, this.email, this.created);

  Map<String, Object> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'created': created.toString(),
    };
  }

  @override
  List<Object> get props => [id, username];

  @override
  String toString() {
    return 'Account { id: $id, username: $username, email: $email, created: $created}';
  }

  Account fromJson(Map<String, Object> json) {
    return Account(
      json['id'] as String,
      json['username'] as String,
      json['email'] as String,
      json['created'] as DateTime,
    );
  }

  Account fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snap) {
    return Account(
      snap.id,
      snap.data()!['username'],
      snap.data()!['email'],
      snap.data()!['created'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'username': username,
      'email': email,
      'created': created,
    };
  }
}
