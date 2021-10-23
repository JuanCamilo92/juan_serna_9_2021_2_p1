import 'package:flutter/material.dart';
import 'package:juan_serna_9_2021_2_p1/screens/list_harrypotter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'personajes de Harry Potter',
      home: ListPotter(),
    );
  }
}