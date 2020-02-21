import 'package:flutter/material.dart';


class FondoIngreso extends StatelessWidget {
  const FondoIngreso({
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
      //Colors.black.withOpacity(0.2), BlendMode.colorBurn),
      Colors.black.withOpacity(0.4),
      BlendMode.dstIn),
        // image: AssetImage("assets/backGround/backGroundAtw.png"),
        image: AssetImage("assets/backGround/FondoBlancoATW.png"),
        fit: BoxFit.contain,
      )),
    );
  }
}
