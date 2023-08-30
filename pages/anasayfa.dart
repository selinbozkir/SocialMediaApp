import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:son_proje/pages/drawer.dart';

import '../models/gonderiler.dart';
import '../views/gonderi_ekle.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Title(color: Colors.white, child: const Text('Anasayfa')),
      ),
      drawer: const MyDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('gonderiler').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          List<GonderiModel> gonderiler = [];
          snapshot.data!.docs.forEach((doc) {
            gonderiler.add(GonderiModel.fromSnapshot(doc));
          });

          return ListView.builder(
            itemCount: gonderiler.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(gonderiler[index].aciklama),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(gonderiler[index].kullanici_email),
                    const SizedBox(height: 8),
                    gonderiler[index].image.isNotEmpty
                        ? Image.network(
                            gonderiler[index].image,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : Container(),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => GonderiEkle()));
        },
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
