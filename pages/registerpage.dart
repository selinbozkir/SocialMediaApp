import 'package:flutter/material.dart';
import 'package:son_proje/widgets/MyDropdownButton.dart';

import '../services/auth.dart';
import 'loginpage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController userNameCntrl = TextEditingController();
  TextEditingController emailCntrl = TextEditingController();
  TextEditingController passwordCntrl = TextEditingController();
  String? _selectedGender;
  void _onGenderChanged(String? value) {
    setState(() {
      _selectedGender = value;
    });
  }

  final _authService = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 227, 227),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.person, color: Colors.white, size: 70),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    style: const TextStyle(color: Colors.black),
                    controller: userNameCntrl,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 252, 252),
                      hintText: 'Kullanıcı Adı',
                      icon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: emailCntrl,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 252, 252),
                      hintText: 'Email',
                      icon: const Icon(Icons.email_sharp, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: true,
                    controller: passwordCntrl,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 252, 252),
                      hintText: 'Şifre',
                      icon: const Icon(Icons.password_rounded,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyDropdownButton(
                    onChanged: _onGenderChanged,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    onPressed: () {
                      if (userNameCntrl.text.isEmpty &&
                          emailCntrl.text.isEmpty &&
                          passwordCntrl.text.isEmpty) {
                        showAlertDialog(context);
                      } else {
                        _authService
                            .register(
                          userNameCntrl.text,
                          emailCntrl.text,
                          passwordCntrl.text,
                          _selectedGender,
                        )
                            .then((value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.login,
                      size: 25,
                      color: Colors.black,
                    ),
                    label: const Text(
                      '   K a y d o l   ',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    icon: const Icon(
                      Icons.login_rounded,
                      size: 25,
                      color: Colors.black,
                    ),
                    label: const Text(
                      'G i r i ş  Y a p ',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Kapat",
          style: TextStyle(
            color: Colors.black,
          )),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Eksik Bilgi"),
      content:
          const Text("Lütfen bilgileri eksiksiz doldurduğunuzdan emin olun"),
      actions: [
        cancelButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
