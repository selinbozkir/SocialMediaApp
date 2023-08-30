import 'package:flutter/material.dart';

class MyDropdownButton extends StatefulWidget {
  final Function(String?) onChanged;
  const MyDropdownButton({super.key, required this.onChanged});

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String? _selectedGender;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 103, 57, 92),
              Color.fromARGB(255, 255, 228, 249),
              Color.fromARGB(255, 57, 23, 63)
              //add more colors
            ]),
            borderRadius: BorderRadius.circular(30),
            boxShadow: const <BoxShadow>[
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
            ]),
        child: Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: DropdownButton(
              hint: const Text('Cinsiyet seçin',
                  style: TextStyle(fontWeight: FontWeight.w700, shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Color.fromARGB(255, 205, 214, 223),
                      offset: Offset(1.5, 2.0),
                    )
                  ])),
              value: _selectedGender,
              items: <String>['Kadın', 'Erkek'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Color.fromARGB(255, 20, 21, 22),
                            offset: Offset(5.0, 5.0),
                          ),
                        ]),
                  ),
                );
              }).toList(),

              onChanged: (String? newValue) {
                setState(() {
                  _selectedGender = newValue;
                  widget.onChanged(newValue);
                });
              },
              isExpanded: true,
              underline: Container(),
              style: const TextStyle(fontSize: 18, color: Colors.white),
              dropdownColor: Color.fromARGB(255, 0, 0, 0),
              iconEnabledColor: Color.fromARGB(255, 224, 218, 218), //Icon color
            )));
  }
}
