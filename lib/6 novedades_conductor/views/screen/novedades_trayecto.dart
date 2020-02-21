import 'package:antawaschool/utils/hexaColor.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rubber/rubber.dart';

class NovedadesTrayecto extends StatefulWidget {
  NovedadesTrayecto({Key key}) : super(key: key);

  @override
  _NovedadesTrayectoState createState() => _NovedadesTrayectoState();
}

class _NovedadesTrayectoState extends State<NovedadesTrayecto>
    with SingleTickerProviderStateMixin {
  RubberAnimationController _controller;

  double _dampingValue = DampingRatio.MEDIUM_BOUNCY;
  //double _stiffnessValue = Stiffness.HIGH;

  @override
  void initState() {
    _controller = RubberAnimationController(
        dismissable: true,
        vsync: this,
        lowerBoundValue: AnimationControllerValue(pixel: 50),
        upperBoundValue: AnimationControllerValue(percentage: 1),
        springDescription: SpringDescription.withDampingRatio(
            mass: 1, stiffness: Stiffness.MEDIUM, ratio: _dampingValue),
        duration: Duration(milliseconds: 300));
    super.initState();
  }

  final GlobalKey<FormBuilderState> _quejasKey = GlobalKey<FormBuilderState>();
  String destinatarioNovedad;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            child: RubberBottomSheet(
              onTap: () {},
              lowerLayer: _getLowerLayer(),
              upperLayer: _getUpperLayer(),
              animationController: _controller,
            ),
          ),
        ),
      ],
    );
  }

  Widget _getLowerLayer() {
    return Container(
      height: 2,
      decoration: BoxDecoration(color: Colors.transparent),
    );
  }

  Widget _getUpperLayer() {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(80), topRight: Radius.circular(5)),
          child: Container(
            decoration: BoxDecoration(
                color: Color(hexColor('#5CC4B8')).withOpacity(0.9)),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white70,
                  size: 26,
                ),
              ],
            ),
            SingleChildScrollView(
              child: Row(
                children: <Widget>[
                  SizedBox(width: 30),
                  Text(
                    'Novedades en el trayecto',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins-Medium',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                          color: Colors.white70,
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: FormBuilder(
                                key: _quejasKey,
                                initialValue: {
                                  'date': DateTime.now(),
                                  'accept_terms': false,
                                },
                                autovalidate: true,
                                child: Column(
                                  children: <Widget>[
                                    FormBuilderDropdown(
                                      attribute: "tipoNovedad",
                                      decoration: InputDecoration(
                                        labelText: "Tipo de Novedad",
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
                                        '¿Seleccione el tipo de novedad?',
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
                                        'Retraso Temporal',
                                        'Cancelación del Trayecto',
                                      ]
                                          .map((tipoNovedad) =>
                                              DropdownMenuItem(
                                                  value: tipoNovedad,
                                                  child: Text("$tipoNovedad")))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          destinatarioNovedad = value;
                                        });
                                      },
                                      allowClear: true,
                                    ),
                                    SizedBox(height: 10),
                                    // CONDICONAL RETRASO
                                    ConditionalBuilder(
                                      condition: destinatarioNovedad ==
                                          'Retraso Temporal',
                                      builder: (context) {
                                        return Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: FormBuilderDropdown(
                                            attribute: "motivoRetraso",
                                            decoration: InputDecoration(
                                              labelText: "Motivo de su retraso",
                                              labelStyle: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color:
                                                    Color(hexColor('#3A4A64')),
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
                                              '¿Seleccione el motivo de su retraso?',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                fontSize: 12,
                                                color:
                                                    Color(hexColor('#5CC4B8')),
                                              ),
                                            ),
                                            validators: [
                                              FormBuilderValidators.required(
                                                  errorText:
                                                      'Campo Obligatorio')
                                            ],
                                            items: [
                                              'a) Falla mecánica',
                                              'b) Gasolina',
                                              'c) Tráfico',
                                              'd) Incidentes en la vía',
                                              'e) Incidentes internos',
                                            ]
                                                .map((retrasoTemporal) =>
                                                    DropdownMenuItem(
                                                        value: retrasoTemporal,
                                                        child: Text(
                                                            "$retrasoTemporal")))
                                                .toList(),
                                            allowClear: true,
                                          ),
                                        );
                                      },
                                    ),

                                    // CONDICONAL RETRASO

                                    ConditionalBuilder(
                                      condition: destinatarioNovedad ==
                                          'Retraso Temporal',
                                      builder: (context) {
                                        return Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: FormBuilderSlider(
                                            attribute: "retraso",
                                            validators: [
                                              FormBuilderValidators.required()
                                            ],
                                            min: 0.0,
                                            max: 60.0,
                                            initialValue: 1.0,
                                            divisions: 8,
                                            decoration: InputDecoration(
                                                icon: Icon(
                                                  Icons.watch,
                                                  color: Color(
                                                      hexColor('#3A4A64')),
                                                ),
                                                labelText:
                                                    "Tiempo aprox de retraso (min)"),
                                          ),
                                        );
                                      },
                                    ),

                                    // CONDICONAL RETRASO
                                    ConditionalBuilder(
                                      condition: destinatarioNovedad ==
                                          'Cancelación del Trayecto',
                                      builder: (context) {
                                        return Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: FormBuilderDropdown(
                                            attribute: "motivoRetraso",
                                            decoration: InputDecoration(
                                              labelText: "Motivo de su retraso",
                                              labelStyle: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color:
                                                    Color(hexColor('#3A4A64')),
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
                                              '¿Seleccione el motivo de su cancelación?',
                                              style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                fontSize: 12,
                                                color:
                                                    Color(hexColor('#5CC4B8')),
                                              ),
                                            ),
                                            validators: [
                                              FormBuilderValidators.required(
                                                  errorText:
                                                      'Campo Obligatorio')
                                            ],
                                            items: [
                                              'a) Falla mecánica',
                                              'b) Incidentes en la vía',
                                              'c) Incidentes internos',
                                            ]
                                                .map((cancelacionTrayecto) =>
                                                    DropdownMenuItem(
                                                        value:
                                                            cancelacionTrayecto,
                                                        child: Text(
                                                            "$cancelacionTrayecto")))
                                                .toList(),
                                            allowClear: true,
                                          ),
                                        );
                                      },
                                    ),

                                    SizedBox(height: 10),
                                    FormBuilderTextField(
                                      attribute: "detalle",
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          labelText: "Detalle su novedad",
                                          labelStyle: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Color(hexColor('#3A4A64'))),
                                          helperStyle: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  Color(hexColor('#61B4E5'))),
                                          hintText:
                                              'Ingrese el detalle de su novedad'),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(hexColor('#61B4E5'))),
                                      validators: [
                                        FormBuilderValidators.maxLength(50,
                                            errorText: 'Máximo 50 caracteres')
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    //Botonoes
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            //Expanded(child: SizedBox()),
                                            FlatButton(
                                              onPressed: () {
                                                if (_quejasKey.currentState
                                                    .saveAndValidate()) {
                                                  print(
                                                    _quejasKey
                                                        .currentState.value,
                                                  );
                                                  AwesomeDialog(
                                                      btnOkColor: Color(
                                                          hexColor('#5CC4B8')),
                                                      context: context,
                                                      dialogType:
                                                          DialogType.SUCCES,
                                                      animType:
                                                          AnimType.TOPSLIDE,
                                                      tittle:
                                                          'Registro Exitoso',
                                                      desc:
                                                          'Su novedad ha sido enviada con éxito',
                                                      //btnCancelOnPress: () {},
                                                      btnOkOnPress: () {
                                                        Navigator
                                                            .popAndPushNamed(
                                                                context,
                                                                'homeConductor');
                                                      }).show();
                                                } else {
                                                  print('campos por validar');
                                                  AwesomeDialog(
                                                          btnOkColor: Color(
                                                              hexColor(
                                                                  '#E86A87')),
                                                          context: context,
                                                          dialogType:
                                                              DialogType.ERROR,
                                                          animType:
                                                              AnimType.TOPSLIDE,
                                                          tittle:
                                                              'Error de Registro ',
                                                          desc:
                                                              'Revise campos obligatorios',
                                                          //btnCancelOnPress: () {},
                                                          btnOkOnPress: () {})
                                                      .show();
                                                }
                                                /*     var user =
                                                    Provider.of<LoginState>(
                                                            context,
                                                            listen: false)
                                                        .currenUser();
                                                if (_quejasKey.currentState
                                                    .saveAndValidate()) {
                                                  print(
                                                    _quejasKey
                                                        .currentState.value,
                                                  );
                                                  Firestore.instance
                                                      .collection('appPadres')
                                                      .document(user.uid)
                                                      .collection(
                                                          '${user.email}')
                                                      .document(user.uid)
                                                      .collection('quejas')
                                                      .document()
                                                      .setData({
                                                    "destinatario": _quejasKey
                                                        .currentState
                                                        .value['destinatario'],
                                                    "motivo": _quejasKey
                                                        .currentState
                                                        .value['motivo'],
                                                    "detalle": _quejasKey
                                                        .currentState
                                                        .value['detalle'],
                                                  });

                                                
                                                } */
                                              },
                                              child: Column(
                                                children: <Widget>[
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    backgroundImage: AssetImage(
                                                        'assets/icon/ok.png'),
                                                  ),
                                                  Text("Enviar"),
                                                ],
                                              ),
                                            ),
                                            FlatButton(
                                              child: Column(
                                                children: <Widget>[
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        Colors.transparent,
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
                                )),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
