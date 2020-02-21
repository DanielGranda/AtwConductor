import 'package:flutter/material.dart';

class TitulosEstado extends StatelessWidget {
final String title;
final Color color;

  const TitulosEstado({Key key, @required this.title, @required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color,));
  }
}