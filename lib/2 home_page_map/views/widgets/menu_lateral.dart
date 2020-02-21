import 'package:antawaschool/utils/hexaColor.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class MenuLateral extends StatefulWidget {
  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  @override
  Widget build(BuildContext context) {
   // final userBloc = BlocProvider.of<UserBloc>(context);
    return SafeArea(
      child: Container(
        width: 270,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            CircleAvatar(
              backgroundImage: AssetImage('assets/marce.png'),
              radius: 50,
            ),
            /*     StreamBuilder(
            stream: Firestore.instance
                .collection('user')
                .document(user.uid)
                .collection('registroMonitorEps')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return CircleAvatar(
                  backgroundImage: NetworkImage('${user.photoUrl}'),
                  radius: 50,
                );
              }
            },
          ),
          SizedBox(height: 15), */
            Divider(
              height: 15,
              color: Color(hexColor('#3A4A64')),
              thickness: 5,
            ),
            SizedBox(height: 5),
            Container(
            
              color: Colors.white30,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/icon/icoConductor.png'),
                  radius: 15,
                ),
                title: Text(
                  'Perfil',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins-Medium',
                    fontSize: 12,
                    color: Color(hexColor('#3A4A64')),
                  ),
                ),
                trailing: Icon(
                  (Icons.arrow_forward_ios),
                ),
                onTap: () async{
                  Navigator.pushNamed(context, 'perfil');
                  if (await Vibration.hasVibrator()) {
    Vibration.vibrate();
}
                },
              ),
            ),
         Divider(),
            Container(
              color: Colors.white30,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/icon/configServ.png'),
                  radius: 15,
                ),
                title: Text(
                  'Configuración de Usuarios',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins-Medium',
                    fontSize: 12,
                    color: Color(hexColor('#3A4A64')),
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  Navigator.pushNamed(context, 'servicesMonitor');
                  if (await Vibration.hasVibrator()) {
    Vibration.vibrate();
}
                },
              ),
            ),
     Divider(),
            Container(
              color: Colors.white30,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/icon/IcoMapaR.png'),
                  radius: 15,
                ),
                title: Text(
                  'Configuración de Ruta',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins-Medium',
                    fontSize: 12,
                    color: Color(hexColor('#3A4A64')),
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () async {
                            Navigator.pushNamed(context, 'detalleRutas');
                            if (await Vibration.hasVibrator()) {
    Vibration.vibrate();
}
                },
              ),
            ),
   Divider(),
            Container(
              color: Colors.white30,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/icon/cfcerrar.png'),
                  radius: 15,
                ),
                title: Text(
                  'Cerrar Sesión',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins-Medium',
                    fontSize: 12,
                    color: Color(hexColor('#3A4A64')),
                  ),
                ),
                trailing: Icon(
                  (Icons.arrow_forward_ios),
                ),
                onTap: () {
                  AwesomeDialog(
                      btnOkColor: Color(hexColor('#F6C34F')),
                      context: context,
                      dialogType: DialogType.WARNING,
                      animType: AnimType.TOPSLIDE,
                      tittle: 'Cerrar Sesión',
                      desc: '¿Desea cerrar la sesión',
                      btnOkText: 'Aceptar',
                      btnCancelColor: Color(hexColor('#E86A87')),
                      btnOkOnPress: () async {
                        Navigator.popAndPushNamed(context, 'ingreso');
                        if (await Vibration.hasVibrator()) {
    Vibration.vibrate();
}
                  /*      userBloc.signOut();
                        Navigator.of(context).pop(); */
                      },
                      btnCancelText: 'Cancelar',
                      btnCancelOnPress: () {
                        Navigator.of(context).pop();
                      }).show();
                },
              ),
            ),
             Divider(),
          ],
        ),
      ),
    );
  }
}
