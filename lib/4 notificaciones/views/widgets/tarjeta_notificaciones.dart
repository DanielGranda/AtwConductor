
import 'package:antawaschool/utils/hexaColor.dart';
import 'package:flutter/material.dart';

class TarjetaNotificaciones extends StatelessWidget {
  const TarjetaNotificaciones({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Colors.white54,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(hexColor('#5CC4B8')),
              child: Icon(
                Icons.timer_off,
                color: Colors.white,
              ),
              radius: 20,
            ),
            title: Text(
              'Retraso de 10 minutos',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              'Novedad en ruta',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: 10,
                color: Colors.blueGrey,
              ),
            ),
            trailing: Text(
              '05-ene',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: 10,
                color: Colors.blueGrey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
