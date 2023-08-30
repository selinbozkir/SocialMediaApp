import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:son_proje/services/database.dart';
import '../models/gonderiler.dart';
import '../services/storage_service.dart';

class GonderiViews extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  StorageService _storageService = StorageService();
  String mediaUrl = '';
  String _collectionPath = 'gonderiler';

  Database _database = Database();

  Future<GonderiModel> addData(String aciklama, XFile? pickedFile,
      String kullanici_id, String kullanici_email) async {
    var ref = _firestore.collection("gonderiler");
    var user = firebaseAuth.currentUser;
    var user_email = user?.email ?? "";
    var userId = user?.uid ?? "";
    if (pickedFile != null) {
      mediaUrl = await _storageService.uploadMedia(File(pickedFile.path));
    }
    var documentRef = await ref.add({
      'aciklama': aciklama,
      'image': mediaUrl,
      'eklenme_tarihi': DateTime.now().toString(),
      'kullanici_id': userId,
      'kullanici_email': user_email
    });

    return GonderiModel(
      aciklama: aciklama,
      eklenme_tarihi: DateTime.now().toString(),
      image: mediaUrl,
      kullanici_id: userId,
      kullanici_email: user_email,
    );
  }

  Stream<QuerySnapshot> getData() {
    var ref = _firestore.collection("gonderiler").snapshots();
    return ref;
  }

  Future<void> removeData(String aciklama) async {
    var collection = FirebaseFirestore.instance.collection('gonderiler');
    var snapshot =
        await collection.where('aciklama', isEqualTo: aciklama).get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
