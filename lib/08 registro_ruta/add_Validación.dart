import 'package:antawaschool/utils/hexaColor.dart';
import 'package:flutter/material.dart';

class AddValidacionParada extends StatefulWidget {
  AddValidacionParada({Key key}) : super(key: key);

  @override
  _AddValidacionParadaState createState() => _AddValidacionParadaState();
}

class _AddValidacionParadaState extends State<AddValidacionParada> {
  @override
  Widget build(BuildContext context) {
    TextStyle estiloCard = TextStyle(fontSize: 12);
    //var user = Provider.of<LoginState>(context, listen: false).currentUser();
    return Scaffold(
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
                          icon: Icon(Icons.delete,
                              color: Color(hexColor('#E86A87')))),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.check_circle,
                              color: Color(hexColor('#5CC4B8')))),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.info, color: Color(hexColor('#F6C34F'))),
                          Text('Estado: Pendiente registro de tutores', style: estiloCard),
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
    );
  }
}
