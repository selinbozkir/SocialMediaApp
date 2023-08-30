import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:son_proje/widgets/MyTextBox.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../models/gonderiler.dart';
import '../models/kullanici_view_model.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  var currentUser = FirebaseAuth.instance.currentUser!;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? selectedValue;

  final ImagePicker _imagePicker = ImagePicker();
  dynamic _pickImage;
  KullaniciViewModel kullaniciModel = KullaniciViewModel();
  final FocusNode _focusNode = FocusNode();
  final TextEditingController cntrl = TextEditingController();
  String _biography = '';
  XFile? image;
  List<GonderiModel> userPosts = [];

  @override
  void initState() {
    super.initState();
    _focusNode;
    fetchUserDataAndPhoto(currentUser.uid);
    _fetchBiographyFromFirestore(currentUser.uid);
    fetchUserPosts(currentUser.uid);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Profil Sayfası'),
      ),
      body: ListView(children: [
        const SizedBox(
          height: 10,
        ),
        CircleAvatar(
          child: Padding(
            padding: const EdgeInsets.only(top: 75, left: 60),
            child: InkWell(
                onTap: () =>
                    _onImageButtonPressed(ImageSource.camera, context: context),
                child: Icon(
                  Icons.camera_alt,
                  size: 30,
                  color: Color.fromARGB(255, 0, 0, 0),
                )),
          ),
          backgroundImage: _pickImage != null ? NetworkImage(_pickImage) : null,
          radius: 50,
        ),
        Text(
          currentUser.email!,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 50,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Hakkımdakiler',
            style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 120, 43, 39),
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        MyTextBox(text: currentUser.email.toString()),
        const SizedBox(
          height: 10,
        ),
        MyTextBox(
          text: _biography,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  child: Column(children: [
                    Focus(
                      onFocusChange: (isFocused) {
                        if (!isFocused) {
                          kullaniciModel.updateUserBiography(cntrl.text);
                        }
                      },
                      child: TextField(
                        focusNode: _focusNode,
                        controller: cntrl,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 3,
                                color: Color.fromARGB(255, 255, 255, 255)),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 255, 252, 252),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                      ),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(_focusNode);
                      },
                      child: const Text('Güncelle',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ]),
                );
              },
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
          child: Text(
            'Gönderilerim',
            style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 120, 43, 39),
                fontWeight: FontWeight.w700),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: userPosts.length,
          itemBuilder: (context, index) {
            GonderiModel gonderi = userPosts[index];
            return ListTile(
              title: Text(gonderi.aciklama),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(gonderi.kullanici_email),
                  SizedBox(height: 8),
                  gonderi.image.isNotEmpty
                      ? Image.network(
                          gonderi.image,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      : Container(),
                ],
              ),
            );
          },
        ),
      ]),
    );
  }

  void fetchUserPosts(String userId) async {
    try {
      CollectionReference postsCollection = firestore.collection('gonderiler');

      QuerySnapshot postsSnapshot =
          await postsCollection.where('kullanici_id', isEqualTo: userId).get();

      List<DocumentSnapshot> postDocuments = postsSnapshot.docs;

      List<GonderiModel> posts = postDocuments
          .map((postDoc) => GonderiModel.fromSnapshot(postDoc))
          .toList();

      setState(() {
        userPosts = posts;
      });
    } catch (e) {
      print('Kullanıcı gönderileri alınırken hata oluştu: $e');
    }
  }

  //Biyografiyi gösterme

  void _fetchBiographyFromFirestore(String userId) async {
    try {
      CollectionReference collection = firestore.collection('users');
      DocumentReference document = collection.doc(userId);

      DocumentSnapshot snapshot = await document.get();
      if (snapshot.exists) {
        setState(() {
          _biography = snapshot.get('biography') ?? '';
          cntrl.text = _biography;
        });
      }
    } catch (e) {
      print('Biyografi alınırken hata oluştu: $e');
    }
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

  void _onImageButtonPressed(ImageSource source,
      {required BuildContext context}) async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: source);
      setState(() {
        image = pickedFile!;
        if (image != null) {
          kullaniciModel.uploadImageToFirebase(
              File(image!.path), currentUser.uid);
        }
      });
      print('aaa');
    } catch (e) {
      setState(() {
        _pickImage = e;
      });
    }
  }
}
