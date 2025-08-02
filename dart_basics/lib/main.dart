import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar:  AppBar(
          title: Text('Test App'),
        ),
        body: Center(
          child: Text(
            'TEST adasdsad 1',
            style: TextStyle(color: Color.fromARGB(255, 133, 31, 31)),
          ),
        ),
      ),
    ),
  );
}
