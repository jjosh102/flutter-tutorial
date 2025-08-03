import 'package:dart_basics/widgets/custom_app_bar.dart';
import 'package:dart_basics/widgets/custom_container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(),
        body: CustomContainer(),
      ),
    ),
  );
}

