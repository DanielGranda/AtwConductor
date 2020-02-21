import 'package:antawaschool/utils/hexaColor.dart';
import 'package:antawaschool/utils/titulos_estado.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vibration/vibration.dart';

import 'cabecera_unidad_educativa.dart';
import 'fondo_monitoreo.dart';

class ListaPreviaAutorizacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _salidaListaKey =
        GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(hexColor('#5CC4B8')),
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.chevronCircleLeft,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'homeConductor');
          },
        ),
        title: CabeceraUnidadEducativa(),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ImagenFondoApp(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            child: Card(
                              color: Color(hexColor('#3A4A64')),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 5),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/icon/UnidadEduca.png'))),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            //     width: double.infinity,
                            child: TitulosEstado(
                              color: Color(hexColor('#F6C34F')),
                              title: 'Listado de Estudiantes',
                            ),
                          ),
                          SizedBox(height: 10),
                          FormBuilder(
                            key: _salidaListaKey,
                            initialValue: {
                              'date': DateTime.now(),
                              'accept_terms': false,
                            },
                            autovalidate: true,
                            child: FormBuilderCheckboxList(
                              checkColor: Color(hexColor('#5CC4B8')),
                              validators: [
                                FormBuilderValidators.required(
                                  errorText: 'Requerido',
                                )
                              ],
                              decoration: InputDecoration(labelText: ""),
                              attribute: "Estudiantes",
                              options: [
                                FormBuilderFieldOption(
                                  value: "1",
                                  child: Card(
                                    child: Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundImage:
                                              AssetImage('assets/daniel.png'),
                                        ),
                                        SizedBox(width: 15),
                                        Text('Daniel Granda'),
                                      ],
                                    ),
                                  ),
                                ),
                                FormBuilderFieldOption(
                                  value: "2",
                                  child: Card(
                                    child: Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundImage:
                                              AssetImage('assets/daniel.png'),
                                        ),
                                        SizedBox(width: 15),
                                        Text('Daniel Granda'),
                                      ],
                                    ),
                                  ),
                                ),
                                FormBuilderFieldOption(
                                  value: "3",
                                  child: Card(
                                    child: Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundImage:
                                              AssetImage('assets/daniel.png'),
                                        ),
                                        SizedBox(width: 15),
                                        Text('Daniel Granda'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          //botones
                          Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  //Expanded(child: SizedBox()),
                                  FlatButton(
                                    onPressed: () {
                                      if (_salidaListaKey.currentState
                                          .saveAndValidate()) {
                                        print(
                                          _salidaListaKey.currentState.value,
                                        );
                                        AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.WARNING,
                                                animType: AnimType.TOPSLIDE,
                                                tittle: 'Solicitud de Salida',
                                                desc:
                                                    '¿Desea enviar la solicitud de salida?',
                                                btnOkColor:
                                                    Color(hexColor('#5CC4B8')),
                                                //btnCancelOnPress: () {},
                                                btnOkText: 'Aceptar',
                                                btnOkOnPress: () async {
                                                  Navigator.popAndPushNamed(
                                                      context, 'homeConductor');
                                                  if (await Vibration
                                                      .hasAmplitudeControl()) {
                                                    Vibration.vibrate(
                                                        amplitude: 128);
                                                  }
                                                  Flushbar(
                                                    backgroundColor: Color(
                                                        hexColor('#F6C34F')),
                                                    flushbarPosition:
                                                        FlushbarPosition.TOP,
                                                    message:
                                                        "Favor espere hasta que el coordinador autorice su salida",
                                                    icon: Icon(
                                                      Icons.watch_later,
                                                      size: 28.0,
                                                      color: Color(
                                                          hexColor('#5CC4B8')),
                                                    ),
                                                    duration:
                                                        Duration(seconds: 6),
                                                    leftBarIndicatorColor:
                                                        Colors.blue[300],
                                                  )..show(context);
                                                },
                                                btnCancelText: 'Cancelar',
                                                btnCancelColor:
                                                    Color(hexColor('#E86A87')),
                                                btnCancelOnPress: () {})
                                            .show();
                                      } else {
                                        print('campos por validar');
                                        AwesomeDialog(
                                                btnOkColor:
                                                    Color(hexColor('#E86A87')),
                                                context: context,
                                                dialogType: DialogType.ERROR,
                                                animType: AnimType.TOPSLIDE,
                                                tittle: 'Error de Registro ',
                                                desc:
                                                    'Revise campos obligatorios',
                                                //btnCancelOnPress: () {},
                                                btnOkOnPress: () {})
                                            .show();
                                      }
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          backgroundImage:
                                              AssetImage('assets/icon/ok.png'),
                                        ),
                                        Text("Enviar"),
                                      ],
                                    ),
                                  ),
                                  FlatButton(
                                    child: Column(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: AssetImage(
                                              'assets/icon/cancel.png'),
                                        ),
                                        Text("Cancelar"),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.popAndPushNamed(
                                          context, 'homeConductor');
                                      //_fase1Key.currentState.reset();
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
