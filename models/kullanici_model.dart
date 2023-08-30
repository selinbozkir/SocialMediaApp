import 'package:cloud_firestore/cloud_firestore.dart';

class KullaniciModel {
  late final String username;
  late String email;
  late String password;
  late String cinsiyet;

  KullaniciModel({
    required this.username,
    required this.email,
    required this.password,
    required this.cinsiyet,
  });

  factory KullaniciModel.fromSnapshot(DocumentSnapshot snapshot) {
    return KullaniciModel(
      username: snapshot["username"],
      email: snapshot["email"],
      password: snapshot["password"],
      cinsiyet: snapshot["cinsiyet"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'cinsiyet': cinsiyet,
    };
  }

  factory KullaniciModel.fromMap(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data() ?? {};

    String? email = data["email"];
    return KullaniciModel(
      username: data["username"] ?? "",
      email: email ?? "",
      password: data["password"] ?? "",
      cinsiyet: data["cinsiyet"] ?? "",
    );
  }
}
