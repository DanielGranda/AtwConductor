
import 'package:flutter/material.dart';

class ImagenFondoApp extends StatelessWidget {
  const ImagenFondoApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
          image: DecorationImage(
        colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3), BlendMode.dstIn),
        image: AssetImage("assets/backGround/FondoBlancoATW.png"),
        fit: BoxFit.contain,
      )),
    );
  }
}


