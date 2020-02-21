import 'package:antawaschool/utils/hexaColor.dart';
import 'package:flutter/material.dart';


class PieAppIngreso extends StatelessWidget {
  const PieAppIngreso({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
              'Las credenciales son otorgadas por: ',
          style: TextStyle(fontFamily: "Poppins-Medium", color: Colors.grey),
        ),
        Text("AntawaGo",
            style: TextStyle(
                color: Color(hexColor('#F6C34F')),
                fontFamily: "Poppins-Bold"))
      ],
    );
  }
}
