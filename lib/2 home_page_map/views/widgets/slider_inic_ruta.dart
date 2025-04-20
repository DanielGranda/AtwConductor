import 'package:antawaschool/utils/hexaColor.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:slider_button/slider_button.dart';
import 'package:vibration/vibration.dart';

class SliderButtonRutaInic extends StatefulWidget {
  const SliderButtonRutaInic({
    Key key,
  }) : super(key: key);

  @override
  _SliderButtonRutaInicState createState() => _SliderButtonRutaInicState();
}

class _SliderButtonRutaInicState extends State<SliderButtonRutaInic> {
  String selecRetorno = 'Ida';
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _salidaKey =
        GlobalKey<FormBuilderState>();
    return Center(
        child: SliderButton(
      backgroundColor: Color(hexColor('#3A4A64')).withOpacity(0.5),
      baseColor: Color(hexColor('#F6C34F')),
      highlightedColor: Colors.white,
      vibrationFlag: true,
      height: 60,
      alignLabel: const Alignment(0.2, 0),
      width: 300,
      action: () async {
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate();

          AwesomeDialog(
              dismissOnTouchOutside: false,
              btnOkColor: Color(hexColor('#5CC4B8')),
              context: context,
              dialogType: DialogType.WARNING,
              animType: AnimType.TOPSLIDE,
              body: FormBuilder(
                  key: _salidaKey,
                  initialValue: {
                    'date': DateTime.now(),
                    'accept_terms': false,
                  },
                  autovalidate: true,
                  child: Column(children: <Widget>[
                    FormBuilderDropdown(
                      attribute: "ruta",
                      decoration: InputDecoration(
                        icon:
                            Icon(Icons.map, color: Color(hexColor('#3A4A64'))),
                        labelText: "Ruta",
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(hexColor('#3A4A64')),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(hexColor('#5CC4B8')),
                      ),
                      // initialValue: 'Male',
                      hint: Text(
                        '¿Seleccione la ruta?',
                        style: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          fontSize: 12,
                          color: Color(hexColor('#5CC4B8')),
                        ),
                      ),
                      validators: [
                        FormBuilderValidators.required(
                            errorText: 'Campo Obligatorio')
                      ],
                      items: [
                        'Solanda',
                        'Magdalena',
                      ]
                          .map((ruta) => DropdownMenuItem(
                              value: ruta, child: Text("$ruta")))
                          .toList(),

                      allowClear: true,
                    ),
                    SizedBox(height: 10),
                    FormBuilderDropdown(
                      attribute: "tipoRuta",
                      decoration: InputDecoration(
                        icon: Icon(Icons.watch_later,
                            color: Color(hexColor('#3A4A64'))),
                        labelText: "Tipo de Ruta",
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(hexColor('#3A4A64')),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(hexColor('#5CC4B8')),
                      ),
                      // initialValue: 'Male',
                      hint: Text(
                        '¿Seleccione el tipo ruta?',
                        style: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          fontSize: 12,
                          color: Color(hexColor('#5CC4B8')),
                        ),
                      ),

                      validators: [
                        FormBuilderValidators.required(
                            errorText: 'Campo Obligatorio')
                      ],

                      items: [
                        'Ida',
                        'Retorno',
                      ]
                          .map((ruta) => DropdownMenuItem(
                              value: ruta, child: Text("$ruta")))
                          .toList(),

                      allowClear: true,
                      key: Key('value'),
                      onChanged: (value) {
                        setState(() {
                          selecRetorno = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                  ])),
              //btnCancelOnPress: () {},
              btnOkText: 'INICIAR',
              btnOkOnPress: () async {
                if (await Vibration.hasVibrator()) {
                  Vibration.vibrate();
                }

                if (_salidaKey.currentState.saveAndValidate()) {
                  print(_salidaKey.currentState.value['tipoRuta']);
                  if (_salidaKey.currentState.value['tipoRuta'] == selecRetorno) {
                  Navigator.popAndPushNamed(context, 'homeConductor');
                  } else {}
                    Navigator.popAndPushNamed(context, 'listaEstudiantes');
                } else {
                  AwesomeDialog(
                      btnCancelColor: Color(hexColor('#E86A87')),
                      context: context,
                      dialogType: DialogType.ERROR,
                      animType: AnimType.TOPSLIDE,
                      tittle: 'Verificación',
                      desc:
                          'Verifique los datos obligatorios para iniciar ruta',
                      btnCancelText: 'Aceptar',
                      btnCancelOnPress: () {
                        Navigator.popAndPushNamed(context, 'homeConductor');
                      }).show();
                }
              },
              btnCancelText: 'CANCELAR',
              btnCancelColor: Color(hexColor('#E86A87')),
              btnCancelOnPress: () {
                Navigator.popAndPushNamed(context, 'homeConductor');
              }).show();
        }
      },
      label: Text(
        "INICIAR TRAYECTO AHORA",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(
              hexColor('#5CC4B8'),
            ),
            fontSize: 16,
            letterSpacing: 2),
      ),
      icon: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            image: DecorationImage(
                image: AssetImage('assets/VEHICULO.png'), fit: BoxFit.cover)),
        //margin: EdgeInsets.only(left: 16.0),
      ),
    ));
  }
}
