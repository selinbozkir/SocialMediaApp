import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:son_proje/main.dart';
import 'package:son_proje/models/kullanici_view_model.dart';
import 'package:son_proje/pages/anasayfa.dart';
import 'package:son_proje/pages/profil.dart';
import 'package:son_proje/widgets/MyListTile.dart';

import '../services/auth.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var currentUser = FirebaseAuth.instance.currentUser!;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  dynamic _pickImage;
  KullaniciViewModel kullaniciModel = KullaniciViewModel();
  @override
  void initState() {
    super.initState();
    fetchUserDataAndPhoto(currentUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    var _authService = Auth();
    var user = _firebaseAuth.currentUser;
    var userId = user?.email ?? "";
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 16, 15, 15),
      child: Column(
        children: [
          DrawerHeader(
              child: CircleAvatar(
            backgroundImage:
                _pickImage != null ? NetworkImage(_pickImage) : null,
            radius: 50,
          )),
          MyListTile(
            icon: Icons.home,
            text: 'A N A S A Y F A',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Anasayfa()),
            ),
          ),
          MyListTile(
            icon: Icons.person,
            text: 'P R O F İ L',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profil()),
            ),
          ),
          const SizedBox(
            height: 350,
          ),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 16, 15, 15), // Background color
              ),
              onPressed: () {
                _authService.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MyApp()));
                });
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: const Text(
                'Çıkış Yap',
                style: TextStyle(fontSize: 20),
              )),
        ],
      ),
    );
  }

  Future<void> fetchUserDataAndPhoto(String userId) async {
    try {
      var userSnapshot = await kullaniciModel.getUserData(userId);
      String? photoUrl = userSnapshot.get('photoUrl');
      if (photoUrl != null) {
        setState(() {
          _pickImage = photoUrl;
        });
      }
    } catch (e) {
      print('Kullanıcı verileri alınırken hata oluştu: $e');
    }
  }
}
