import 'package:flutter/material.dart';
class TabItem {
  //Container container;
  //IconData icon;
  String title;
  String urlImage;
  Color circleColor;
  TextStyle labelStyle;

  TabItem(this.urlImage,/* this.container,  *//* this.icon */this.title, this.circleColor, {this.labelStyle = const TextStyle(fontWeight: FontWeight.bold)});
}