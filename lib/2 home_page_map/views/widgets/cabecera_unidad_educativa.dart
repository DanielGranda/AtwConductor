
import 'package:flutter/material.dart';

class CabeceraUnidadEducativa extends StatelessWidget {
  const CabeceraUnidadEducativa({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: CircleAvatar(
        backgroundImage: AssetImage('assets/marce.png'),
      ),
      title: Text(
        'Granda Jaramillo Luis M...',
        style: TextStyle(
          fontFamily: 'Poppins-Medium',
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        'Monitor de Ruta',
        style: TextStyle(
            fontFamily: 'Poppins-Medium',
            fontSize: 12,
            //fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
    );
  }
}