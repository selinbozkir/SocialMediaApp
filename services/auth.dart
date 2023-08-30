import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    var user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  Future<User?> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<User?> register(
    String userName,
    String email,
    String password,
    String? selectedGender,
  ) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      await _fireStore.collection('users').doc(uid).set({
        'kullaniciAdi': userName,
        'email': email,
        'sifre': password,
        'cinsiyet': selectedGender
      });

      return userCredential.user;
    } catch (e) {
      print("Hata: $e");
      return null;
    }
  }
}
