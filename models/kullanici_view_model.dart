import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class KullaniciViewModel extends ChangeNotifier {
  final String _collectionPath = 'users';
  getKullaniciList() {
    var streamListDocument =
        FirebaseFirestore.instance.collection(_collectionPath).snapshots();
    return streamListDocument;
  }

  Future<void> uploadImageToFirebase(File file, String userId) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference =
          storage.ref().child('users/$userId/profile_picture.jpg');

      UploadTask uploadTask = storageReference.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      addUserPhoto(userId, downloadUrl);
    } catch (e) {
      print('Fotoğraf yüklenirken hata oluştu: $e');
    }
  }

  void addUserPhoto(String userId, String photoUrl) async {
    try {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      await userRef.update({'photoUrl': photoUrl});
      print('Kullanıcı fotoğrafı güncellendi.');
    } catch (e) {
      print('Kullanıcı fotoğrafı güncellenirken hata oluştu: $e');
    }
  }

  Future<DocumentSnapshot> getUserData(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      return userSnapshot;
    } catch (e) {
      print('Kullanıcı verileri alınırken hata oluştu: $e');
      rethrow;
    }
  }

  Future<void> updateUserBiography(String biography) async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        DocumentReference userRef =
            FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
        await userRef.update({'biography': biography});

        print('Biyografi başarıyla güncellendi.');
      }
    } catch (e) {
      print('Biyografi güncellenirken hata oluştu: $e');
    }
  }
}
