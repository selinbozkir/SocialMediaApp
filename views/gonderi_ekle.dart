import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:son_proje/views/gonderi_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GonderiEkle extends StatefulWidget {
  const GonderiEkle({super.key});

  @override
  State<GonderiEkle> createState() => _GonderiEkleState();
}

class _GonderiEkleState extends State<GonderiEkle> {
  TextEditingController gonderiCntrl = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GonderiViews _gonderiViews = GonderiViews();

  String? selectedValue;
  final ImagePicker _imagePicker = ImagePicker();
  dynamic _pickImage;

  XFile? image;

  Widget imagePlace() {
    double height = MediaQuery.of(context).size.height;
    if (image != null) {
      return Container(
        height: 200,
        child: Image.file(File(image!.path)),
      );
    } else {
      if (_pickImage != null) {
        return Image.network(_pickImage);
      } else
        return Text("Görüntü Seçin");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Gönderi Ekle'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 550,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: gonderiCntrl,
                    decoration: const InputDecoration(
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 252, 252),
                      hintText: 'Gönderi Yaz',
                    ),
                  ),
                  Center(
                    child: imagePlace(),
                  ),
                  const SizedBox(
                    height: 236,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 130,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                          ),
                          onPressed: () {
                            _onImageButtonPressed(ImageSource.camera,
                                context: context);
                          },
                          icon: const Icon(
                            Icons.camera_alt_sharp,
                            size: 25,
                            color: Colors.black,
                          ),
                          label: const Text(
                            '',
                            style: TextStyle(color: Colors.black),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                          ),
                          onPressed: () {
                            _onImageButtonPressed(ImageSource.gallery,
                                context: context);
                          },
                          icon: const Icon(
                            Icons.image,
                            size: 25,
                            color: Colors.black,
                          ),
                          label: const Text(
                            '',
                            style: TextStyle(color: Colors.black),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                          ),
                          onPressed: () {
                            _gonderiViews
                                .addData(
                                    gonderiCntrl.text,
                                    image,
                                    firebaseAuth.currentUser?.uid ?? "",
                                    firebaseAuth.currentUser?.email ?? "")
                                .then((value) {
                              Fluttertoast.showToast(
                                  msg: "Gönderi başarıyla paylaşıldı",
                                  timeInSecForIosWeb: 2,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.grey[600],
                                  textColor: Colors.white,
                                  fontSize: 14);
                              Navigator.pop(context);
                            });
                          },
                          icon: const Icon(
                            Icons.post_add,
                            size: 25,
                            color: Colors.black,
                          ),
                          label: const Text(
                            'Paylaş',
                            style: TextStyle(color: Colors.black),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onImageButtonPressed(ImageSource source,
      {required BuildContext context}) async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: source);
      setState(() {
        image = pickedFile!;
        if (image != null) {}
      });
      print('aaa');
    } catch (e) {
      setState(() {
        _pickImage = e;
      });
    }
  }
}
