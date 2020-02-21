import 'dart:io';

import 'package:antawaschool/utils/hexaColor.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vibration/vibration.dart';

class RegistroRutas extends StatefulWidget {
  RegistroRutas({Key key}) : super(key: key);

  @override
  _RegistroRutasState createState() => _RegistroRutasState();
}

class _RegistroRutasState extends State<RegistroRutas> {
  final GlobalKey<FormBuilderState> _rutaKey = GlobalKey<FormBuilderState>();

  bool discapcidad = true;
  bool conductor = true;

  File foto;
  static File galleryFile;
  static Future<File> imageFile;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          galleryFile = snapshot.data;
          return Image.file(
            snapshot.data,
            width: 30,
            height: 30,
          );
        } else if (snapshot.error != null) {
          return const Text('Error');
        } else
          return Icon(FontAwesomeIcons.image,
              color: Color(hexColor('#61B4E5')));
      },
    );
  }

//Archivo desde foto
  static File cameraFile;
  static Future<File> photoFile;

  pickImageFromCamera(ImageSource source) {
    setState(() {
      photoFile = ImagePicker.pickImage(source: ImageSource.camera);
    });
  }

  Widget showPhoto() {
    return FutureBuilder<File>(
      future: photoFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          cameraFile = snapshot.data;
          return Image.file(
            snapshot.data,
            width: 30,
            height: 30,
          );
        } else if (snapshot.error != null) {
          return const Text('Error');
        } else
          return Icon(FontAwesomeIcons.camera,
              color: Color(hexColor('#61B4E5')));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    SafeArea(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Registro de Rutas'.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(hexColor('#5CC4B8'))),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/icon/IcoMapaR.png"),
                            radius: 30,
                          ),
                          Divider(
                            color: Color(hexColor('#3A4A64')),
                            thickness: 4,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //EXPANDIBLE 1 DATOS PERSONALES
                    Container(
                      child: ExpandablePanel(
                        header: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(FontAwesome.map_o,
                                    color: Color(hexColor('#3A4A64'))),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Datos de su ruta',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(hexColor('#3A4A64'))),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                        collapsed: Container(
                          child: FormBuilder(
                            key: _rutaKey,
                            initialValue: {
                              'date': DateTime.now(),
                              'accept_terms': false,
                            },
                            autovalidate: true,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                FormBuilderTextField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  attribute: "nombresdeRuta",
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.insert_drive_file,
                                        color: Color(hexColor('#61B4E5')),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      labelText: "Nombre de la ruta",
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          color: Color(hexColor('#3A4A64'))),
                                      helperStyle: TextStyle(
                                          fontSize: 12,
                                          color: Color(hexColor('#61B4E5'))),
                                      hintText: 'Ingrese el nombre de la ruta'),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(hexColor('#61B4E5'))),
                                  validators: [
                                    FormBuilderValidators.required(
                                      errorText: 'Requerido',
                                    ),
                                    FormBuilderValidators.minLength(3,
                                        errorText: 'Mínimo 3 caracteres')
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: FormBuilderDropdown(
                                    attribute: "tipoRuta",
                                    decoration: InputDecoration(
                                        labelText: "Tipo de ruta"),
                                    icon: Icon(FontAwesome.map_marker,
                                        color: Color(hexColor('#61B4E5'))),
                                    //hint: Text('Seleccione el combustible'),
                                    validators: [
                                      FormBuilderValidators.required(
                                          errorText: 'Requerido')
                                    ],
                                    items: [
                                      'Ida',
                                      'Retorno',
                                    ]
                                        .map((tipoRuta) => DropdownMenuItem(
                                            value: tipoRuta,
                                            child: Text(
                                              "$tipoRuta",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(
                                                      hexColor('#61B4E5'))),
                                            )))
                                        .toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: FormBuilderDropdown(
                                    attribute: "jornada",
                                    decoration:
                                        InputDecoration(labelText: "Jornada"),
                                    icon: Icon(FontAwesome.calendar,
                                        color: Color(hexColor('#61B4E5'))),
                                    //hint: Text('Seleccione el combustible'),
                                    validators: [
                                      FormBuilderValidators.required(
                                          errorText: 'Requerido')
                                    ],
                                    items: [
                                      'Matutina',
                                      'Vespertina',
                                      'Nocturna',
                                    ]
                                        .map((tipoRuta) => DropdownMenuItem(
                                            value: tipoRuta,
                                            child: Text(
                                              "$tipoRuta",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(
                                                      hexColor('#61B4E5'))),
                                            )))
                                        .toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FormBuilderDateTimePicker(
                                  attribute: "inicioRuta",
                                  inputType: InputType.time,
                                  //format: DateFormat("yyyy-MM-dd"),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      suffixIcon: Icon(
                                        FontAwesome.clock_o,
                                        color: Color(hexColor('#61B4E5')),
                                      ),
                                      labelText: "Hora de inicio de ruta"),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(hexColor('#61B4E5'))),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                FormBuilderDateTimePicker(
                                  attribute: "finRuta",
                                  inputType: InputType.time,
                                  //format: DateFormat("yyyy-MM-dd"),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      suffixIcon: Icon(
                                        FontAwesome.clock_o,
                                        color: Color(hexColor('#61B4E5')),
                                      ),
                                      labelText:
                                          "Hora de finalización de ruta"),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(hexColor('#61B4E5'))),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: FormBuilderDropdown(
                                    attribute: "sector",
                                    decoration:
                                        InputDecoration(labelText: "Sector"),
                                    icon: Icon(FontAwesome.map_o,
                                        color: Color(hexColor('#61B4E5'))),
                                    //hint: Text('Seleccione el combustible'),
                                    validators: [
                                      FormBuilderValidators.required(
                                          errorText: 'Requerido')
                                    ],
                                    items: [
                                      "La Tola",
                                      "El Dorado",
                                      "San Roque",
                                      "La Ronda",
                                      "La Marin",
                                      "La Guaragua",
                                      "La Loma Grande",
                                      "San Marcos",
                                      "La Vicentina",
                                      "El Tejar",
                                      "Toctiuco",
                                      "La Libertad",
                                      "Miraflores",
                                      "San Juan",
                                      "San Diego",
                                      "El Panecillo",
                                      "El Ejido",
                                      "La Floresta",
                                      "Monjas",
                                      "La Mariscal",
                                      "La González Suárez",
                                      "El Batán",
                                      "Las Casas",
                                      "Bellavista",
                                      "Guapulo",
                                      "Iñaquito",
                                      "Quito Tennis",
                                      "Atucucho",
                                      "La Florida",
                                      "San Carlos",
                                      "Quito Norte",
                                      "Mena de Hierro",
                                      "Cotocollao",
                                      "Comité del Pueblo",
                                      "La Bota",
                                      "Ponceano",
                                      "El Condado",
                                      "Kennedy",
                                      "Rumiñahui",
                                      "El Inca",
                                      "Carcelén",
                                      "San Bartolo",
                                      "La Magdalena",
                                      "La Mena 2",
                                      "Villaflora",
                                      "Solanda",
                                      "Quitumbe",
                                      "Chilibulo",
                                      "Reino de Quito-La Mena",
                                      "El Pintado",
                                      "Quito Sur",
                                      "El Calzado",
                                      "Chimbacalle",
                                      "5 esquinas",
                                      "Luluncoto",
                                      "El Camal",
                                      "Puengasí",
                                      "La Ferroviaria",
                                      "La Forestal",
                                      "Oriente Quiteño",
                                      "La Argelia",
                                      "Santa Rita",
                                      "Turubamba",
                                      "Chillogallo",
                                      "Ciudadela Ibarra",
                                      "Ciudadela del Ejército",
                                      "La Ecuatoriana",
                                      "Manuelita Saenz",
                                      "Cornejo",
                                      "Nueva Aurora",
                                      "Lucha de los Pobres",
                                      "Guajalo",
                                      "San Matin",
                                      "El Troje",
                                      "Caupichu",
                                      "El Beaterio",
                                      "Guamaní",
                                      "La Victoria",
                                      "Tumbaco",
                                      "Puembo",
                                      "Pifo",
                                      "Alangasi",
                                      "Conocoto",
                                      "San Rafael",
                                    ]
                                        .map((sector) => DropdownMenuItem(
                                            value: sector,
                                            child: Text(
                                              "$sector",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(
                                                      hexColor('#61B4E5'))),
                                            )))
                                        .toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: FormBuilderDropdown(
                                    attribute: "vehiculoRuta",
                                    decoration: InputDecoration(
                                        labelText:
                                            "Vehículo vinculado a la ruta"),
                                    icon: Icon(FontAwesome.bus,
                                        color: Color(hexColor('#61B4E5'))),
                                    //hint: Text('Seleccione el combustible'),
                                    validators: [
                                      FormBuilderValidators.required(
                                          errorText: 'Requerido')
                                    ],
                                    items: [
                                      'PDJ-4035',
                                      'PHJ-8923',
                                      'GHY-6233',
                                    ]
                                        .map((vehiculoVinculadoRuta) =>
                                            DropdownMenuItem(
                                                value: vehiculoVinculadoRuta,
                                                child: Text(
                                                  "$vehiculoVinculadoRuta",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(
                                                          hexColor('#61B4E5'))),
                                                )))
                                        .toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: FormBuilderDropdown(
                                    attribute: "monitorRuta",
                                    decoration: InputDecoration(
                                        labelText:
                                            "Monitor vinculado a la ruta"),
                                    icon: Icon(FontAwesome.user_circle,
                                        color: Color(hexColor('#61B4E5'))),
                                    //hint: Text('Seleccione el combustible'),
                                    validators: [
                                      FormBuilderValidators.required(
                                          errorText: 'Requerido')
                                    ],
                                    items: [
                                      'Daniel Granda',
                                      'Ricardo Puga',
                                      'Renato Montenegro',
                                    ]
                                        .map((monitorVinculado) =>
                                            DropdownMenuItem(
                                                value: monitorVinculado,
                                                child: Text(
                                                  "$monitorVinculado",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(
                                                          hexColor('#61B4E5'))),
                                                )))
                                        .toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: FormBuilderDropdown(
                                    attribute: "conductorRuta",
                                    decoration: InputDecoration(
                                        labelText:
                                            "Conductor vinculado a la ruta"),
                                    icon: Icon(FontAwesome.user_circle_o,
                                        color: Color(hexColor('#61B4E5'))),
                                    //hint: Text('Seleccione el combustible'),
                                    validators: [
                                      FormBuilderValidators.required(
                                          errorText: 'Requerido')
                                    ],
                                    items: [
                                      'Daniel Granda',
                                      'Ricardo Puga',
                                      'Renato Montenegro',
                                    ]
                                        .map((conductorVinculado) =>
                                            DropdownMenuItem(
                                                value: conductorVinculado,
                                                child: Text(
                                                  "$conductorVinculado",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(
                                                          hexColor('#61B4E5'))),
                                                )))
                                        .toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    //EXPANDIBLE 2 PREGUNTAS FILTRO

                    //BOTONES
                    Row(
                      children: <Widget>[
                        Expanded(child: SizedBox()),
                        FlatButton(
                          onPressed: () {
                            if (_rutaKey.currentState.saveAndValidate()) {
                              print(
                                _rutaKey.currentState.value,
                              );

                              AwesomeDialog(
                                  btnOkColor: Color(hexColor('#5CC4B8')),
                                  context: context,
                                  dialogType: DialogType.SUCCES,
                                  animType: AnimType.TOPSLIDE,
                                  tittle: 'Registro Exitoso',
                                  desc:
                                      'Se ha agregado un nueva nueva ruta al servicio',
                                  //btnCancelOnPress: () {},
                                  btnOkOnPress: () async {
                                    Navigator.popAndPushNamed(
                                        context, 'homeRutas');
                                    if (await Vibration.hasVibrator()) {
                                      Vibration.vibrate();
                                    }
                                  }).show();
                            } else {
                              print('campos por validar');
                              AwesomeDialog(
                                  btnOkColor: Color(hexColor('#E86A87')),
                                  context: context,
                                  dialogType: DialogType.ERROR,
                                  animType: AnimType.TOPSLIDE,
                                  tittle: 'Error de Registro ',
                                  desc: 'Revise campos obligatorios',
                                  //btnCancelOnPress: () {},
                                  btnOkOnPress: () async {
                                    if (await Vibration.hasVibrator()) {
                                      Vibration.vibrate();
                                    }
                                    /* Navigator.pushNamed(context, 'registroMonitor'); */
                                  }).show();
                            }
                            /*       var user =
                                Provider.of<LoginState>(context, listen: false)
                                    .currentUser();

                            if (_fase1Key.currentState.saveAndValidate() &
                                _fase2Key.currentState.saveAndValidate()) {
                              print(
                                _fase1Key.currentState.value,
                              );
                              print(
                                _fase2Key.currentState.value,
                              );
                              Firestore.instance
                                  .collection('user')
                                  .document(user.uid)
                                  .collection('registroMonitorEps')
                                  .document()
                                  .setData({
                                "nombre":
                                    _fase1Key.currentState.value['Nombres'],
                                "apellidos":
                                    _fase1Key.currentState.value['Apellidos'],
                                "cedula":
                                    _fase1Key.currentState.value['Cédula'],
                                "celular":
                                    _fase1Key.currentState.value['Celular'],
                                "email": _fase1Key.currentState.value['Email'],
                                "Fecha_de_Nacimiento":
                                    _fase1Key.currentState.value['edad'],
                                "Tambien_Conductor": _fase1Key
                                    .currentState.value['TambienMonitor'],
                                "Puntos_Licencia": _fase1Key
                                    .currentState.value['PuntosLicencia'],
                              });
                              AwesomeDialog(
                                  btnOkColor: Color(hexColor('#5CC4B8')),
                                  context: context,
                                  dialogType: DialogType.SUCCES,
                                  animType: AnimType.TOPSLIDE,
                                  tittle: 'Registro Exitoso',
                                  desc:
                                      'Se ha agregado un nuevo monitor al servicio',
                                  //btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    Navigator.pushNamed(
                                        context, 'servicesMonitor');
                                  }).show();
                            } else {
                              print('campos por validar');
                              AwesomeDialog(
                                      btnOkColor: Color(hexColor('#E86A87')),
                                      context: context,
                                      dialogType: DialogType.ERROR,
                                      animType: AnimType.TOPSLIDE,
                                      tittle: 'Error de Registro ',
                                      desc: 'Revise campos obligatorios',
                                      //btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        /* Navigator.pushNamed(context, 'registroMonitor'); */
                                      })
                                  .show();
                            } */
                          },
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    AssetImage('assets/icon/ok.png'),
                              ),
                              Text("Registrarce"),
                            ],
                          ),
                        ),
                        FlatButton(
                          onPressed: () async {
                            Navigator.popAndPushNamed(context, 'homeRutas');
                            if (await Vibration.hasVibrator()) {
                              Vibration.vibrate();
                            }
                            //_fase1Key.currentState.reset();
                          },
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    AssetImage('assets/icon/cancel.png'),
                              ),
                              Text("Cancelar"),
                            ],
                          ),
                        ),
                        Expanded(child: SizedBox()),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
