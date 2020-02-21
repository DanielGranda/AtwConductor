
import 'package:antawaschool/utils/hexaColor.dart';
import 'package:flutter/material.dart';

class AvatarEstudiante extends StatelessWidget {
  const AvatarEstudiante({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color:
                    Color(hexColor('#3A4A64')).withOpacity(0.5),
                blurRadius:
                    20.0, // has the effect of softening the shadow
                spreadRadius:
                    1.0, // has the effect of extending the shadow
                offset: Offset(
                  5.0, // horizontal, move right 10
                  10.0, // vertical, move down 10
                ),
              )
            ],
            borderRadius: new BorderRadius.circular(180),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(150),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/daniel.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.1),
                    BlendMode.dstOut),
              )),
            ),
          ),
        ),
        SizedBox( height: 10),
        Text('Daniel Granda',style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),),
      ],
    );
  }
}
