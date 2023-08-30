import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: const Color.fromARGB(255, 0, 0, 0),
      child: Image.asset('images/cat.jpg'),
    );
  }
}

class MyCard2 extends StatelessWidget {
  const MyCard2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Image.asset('images/5f3e98de043c34511849d029727fa8ea.jpg'),
    );
  }
}

class MyCard3 extends StatelessWidget {
  const MyCard3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: const Color.fromARGB(255, 0, 0, 0),
      child: Image.asset('images/8edf1c26f8e2718e0c845ea8f7de54f4.jpg'),
    );
  }
}
