import 'package:antawaschool/utils/hexaColor.dart';
import 'package:flutter/material.dart';

class InfoEstudiante extends StatelessWidget {
  const InfoEstudiante({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Colors.white70,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/daniel.png'),
              radius: 20,
            ),
            title: Row(
              children: <Widget>[
                Text(
                  'Victor Daniel Granda',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins-Medium',
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                                  child: IconButton(
                    icon: Icon(
                      Icons.call,
                      color: Color(hexColor('#5CC4B8')),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            subtitle: Row(
              children: <Widget>[
                Text(
                  'Estudiante',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins-Medium',
                    fontSize: 12,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
