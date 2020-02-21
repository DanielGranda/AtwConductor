import 'package:antawaschool/utils/hexaColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:vibration/vibration.dart';

class DetalleRutasGlobal extends StatefulWidget {
  DetalleRutasGlobal({Key key}) : super(key: key);

  @override
  _DetalleRutasGlobalState createState() => _DetalleRutasGlobalState();
}

class _DetalleRutasGlobalState extends State<DetalleRutasGlobal> {
  @override
  Widget build(BuildContext context) {
    TextStyle estiloCard = TextStyle(fontSize: 12);
    //var user = Provider.of<LoginState>(context, listen: false).currentUser();
    return Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(
            FontAwesome.chevron_circle_left,
            color: Color(hexColor('#61B4E5')),
            size: 30,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'homeConductor');
          },
        ),
        backgroundColor: Colors.white,
        title: Text('Configuración de Rutas'.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(hexColor('#5CC4B8')),
            )),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
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
          ),
          ListView(
            children: <Widget>[
              Card(
                elevation: 5,
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Text('Ruta: Solanda'),
                      Expanded(
                          child: SizedBox(
                        width: 0,
                      )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit,
                              color: Color(hexColor('##F6C34F')))),
                 
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.check_circle, color: Color(hexColor('#5CC4B8'))),
                          Text('Estado: Aprobada el 28-02-2020',
                              style: estiloCard),
                        ],
                      ),
                      Text(
                        'Tipo: Ida',
                        style: estiloCard,
                      ),
                      Text('Cantidad de Paradas: 16', style: estiloCard),
                      Text('Hora de salida: 7:00', style: estiloCard),
                      Text('Cantidad de llegada: 8:00', style: estiloCard),
                      Text('Estudiantes: 15', style: estiloCard),
                      Text('Tutores: 15', style: estiloCard),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(hexColor('#3A4A64')),
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.popAndPushNamed(context, 'menuRegRutas');
          if (await Vibration.hasVibrator()) {
    Vibration.vibrate();
}
        },
      ),
    );
  }
}
