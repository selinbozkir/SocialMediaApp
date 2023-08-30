import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  String text;
  final VoidCallback? onPressed;
  MyTextBox({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(
            97,
            109,
            109,
            107,
          ),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(text),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
              ),
              onPressed: onPressed,
              child: const Text('Güncelle',
                  style: TextStyle(color: Colors.white))),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
