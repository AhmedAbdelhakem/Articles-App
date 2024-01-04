import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String username;
  final String userId;
  final String email;
  final String phone;

  MyUser({
    required this.userId,
    required this.username,
    required this.email,
    required this.phone,
  });

  MyUser.fromJson(Map<String, dynamic>? json, [param1])
      : this(
    userId: json!['userid']! as String,
    username: json['username']! as String,
    email: json['email']! as String,
    phone: json['phone']! as String,
  );

  factory MyUser.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return MyUser(
      username: data!['username'],
      email: data['email'],
      phone: data['Phone'],
      userId: data['userid'],
    );
  }

  Map<String, Object?> toJson() {
    return {
      'username': username,
      'email': email,
      'phone': phone,
    };
  }

}
