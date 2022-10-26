import 'package:flutter/material.dart';

class eAccessButton extends StatefulWidget {
  eAccessButton({
    required this.onPressed,
    required this.text,
  });
  final VoidCallback onPressed;
  final String text;

  @override
  State<eAccessButton> createState() => _eAccessButtonState();
}

class _eAccessButtonState extends State<eAccessButton> {
  Color buttonColor = const Color.fromARGB(95, 11, 70, 133);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *
          0.40 /
          4, //MediaQuery.of(context).size.height * 0.55 / 4.2,
      width: MediaQuery.of(context).size.width / 4,
      child: Card(
        elevation: 2,
        color: buttonColor,
        child: TextButton(
          onPressed: () {
            setState(() {
              buttonColor = const Color.fromARGB(141, 4, 40, 79);
              Future.delayed(const Duration(milliseconds: 80), () {
                setState(() {
                  buttonColor = const Color.fromARGB(95, 11, 70, 133);
                });
              });
            });
            widget.onPressed();
          },
          child: Text(
            widget.text,
            style: const TextStyle(
                fontSize: 30, color: Color.fromARGB(255, 48, 63, 93)),
          ),
        ),
      ),
    );
  }
}
