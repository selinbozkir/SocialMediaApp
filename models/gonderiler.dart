import 'package:cloud_firestore/cloud_firestore.dart';

class GonderiModel {
  final String aciklama;
  final String image;
  String eklenme_tarihi;
  String kullanici_id;
  String kullanici_email;

  GonderiModel({
    required this.aciklama,
    required this.image,
    required this.eklenme_tarihi,
    required this.kullanici_id,
    required this.kullanici_email,
  });

  factory GonderiModel.fromSnapshot(DocumentSnapshot snapshot) {
    return GonderiModel(
        aciklama: snapshot["aciklama"],
        image: snapshot["image"],
        eklenme_tarihi: snapshot["eklenme_tarihi"],
        kullanici_id: snapshot['kullanici_id'],
        kullanici_email: snapshot['kullanici_email']);
  }
  Map<String, dynamic> toMap() => {
        'aciklama': aciklama,
        'image': image,
        'eklenme_tarihi': eklenme_tarihi,
        'kullanici_id': kullanici_id,
        'kullanici_mail': kullanici_email
      };

  factory GonderiModel.fromMap(map) => GonderiModel(
      aciklama: map['aciklama'] ?? "",
      eklenme_tarihi: map['eklenme_tarihi'] ?? "",
      image: map['image'] ?? "",
      kullanici_id: map['kullanici_id'] ?? "",
      kullanici_email: map['kullanici_email'] ?? "");
}
