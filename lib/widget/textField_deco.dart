// ignore: file_names
import 'package:flutter/material.dart';
  
  
  InputDecoration TextFieldDecoration(labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Color.fromARGB(255, 62, 90, 28),
      ),
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(25.0),
      ),
    );
  }