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

class ResgistroVehiculos extends StatefulWidget {
  ResgistroVehiculos({Key key}) : super(key: key);

  @override
  _ResgistroVehiculosState createState() => _ResgistroVehiculosState();
}

class _ResgistroVehiculosState extends State<ResgistroVehiculos> {
  final GlobalKey<FormBuilderState> _fase1Key = GlobalKey<FormBuilderState>();
  // final GlobalKey<FormBuilderState> _fase2Key = GlobalKey<FormBuilderState>();

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
                            'Registro de Vehículos'.toUpperCase(),
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
                                AssetImage("assets/imgEps/VehiculoEps.png"),
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
                                Icon(FontAwesome.bus,
                                    color: Color(hexColor('#3A4A64'))),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Datos del Vehículo',
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
                            key: _fase1Key,
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
                                Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Text('Imagen del'),
                                            Text('vehículo'),
                                          ],
                                        ),
                                        InkWell(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Container(
                                              height: 80,
                                              width: 80,
                                              child: showPhoto(),
                                            ),
                                          ),
                                          onTap: () => pickImageFromCamera(
                                              ImageSource.camera),
                                        ),
                                        InkWell(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Container(
                                              height: 80,
                                              width: 80,
                                              child: showImage(),
                                            ),
                                          ),
                                          onTap: () => pickImageFromGallery(
                                              ImageSource.gallery),
                                        ),
                                      ],
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                FormBuilderTextField(
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  attribute: "placas",
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        FontAwesome.car,
                                        color: Color(hexColor('#61B4E5')),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      labelText: "Placas del Vehículo",
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          color: Color(hexColor('#3A4A64'))),
                                      helperStyle: TextStyle(
                                          fontSize: 12,
                                          color: Color(hexColor('#61B4E5'))),
                                      hintText: 'Ejemplo: PDH-4533'),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(hexColor('#61B4E5'))),
                                  validators: [
                                    FormBuilderValidators.required(
                                      errorText: 'Requerido',
                                    ),
                                    FormBuilderValidators.minLength(8,
                                        errorText:
                                            'Error de ingreso, mire el ejemplo'),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FormBuilderTextField(
                                  keyboardType: TextInputType.number,
                                  attribute: "fabricacion",
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.calendar_today,
                                        color: Color(hexColor('#61B4E5')),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      labelText: "Año de Fabricación",
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          color: Color(hexColor('#3A4A64'))),
                                      helperStyle: TextStyle(
                                          fontSize: 12,
                                          color: Color(hexColor('#61B4E5'))),
                                      hintText: 'Ejemplo: 2017'),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(hexColor('#61B4E5'))),
                                  validators: [
                                    FormBuilderValidators.required(
                                      errorText: 'Requerido',
                                    ),
                                    FormBuilderValidators.minLength(4,
                                        errorText:
                                            'Error de ingreso, mire el ejemplo')
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
                                    attribute: "combustible",
                                    decoration: InputDecoration(
                                        labelText: "Tipo de combustible"),
                                    icon: Icon(FontAwesome.fax,
                                        color: Color(hexColor('#61B4E5'))),
                                    //hint: Text('Seleccione el combustible'),
                                    validators: [
                                      FormBuilderValidators.required(
                                          errorText: 'Requerido')
                                    ],
                                    items: [
                                      'Gasolina',
                                      'Diesel',
                                      'Hybrido',
                                      'Electrico'
                                    ]
                                        .map((combustible) => DropdownMenuItem(
                                            value: combustible,
                                            child: Text(
                                              "$combustible",
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
                                    attribute: "marca",
                                    decoration: InputDecoration(
                                        labelText: "Marca del vehículo"),
                                    icon: Icon(FontAwesome.list,
                                        color: Color(hexColor('#61B4E5'))),
                                    validators: [
                                      FormBuilderValidators.required(
                                          errorText: 'Requerido')
                                    ],
                                    items: [
                                      'BAIC',
                                      'BMW',
                                      'Brilliance',
                                      'BYD',
                                      'Changan',
                                      'Changhe',
                                      'Chery',
                                      'Chevrolet',
                                      'Citroën',
                                      'DFSK',
                                      'Dodge',
                                      'Domy',
                                      'Dongfeng',
                                      'DS',
                                      'FAW',
                                      'Fiat',
                                      'Ford',
                                      'Foton',
                                      'Great Wall',
                                      'Haval',
                                      'Honda',
                                      'Hyundai',
                                      'JAC Motors',
                                      'Jeep',
                                      'Jinbei',
                                      'Kia',
                                      'King Long',
                                      'Mahindra',
                                      'Mazda',
                                      'Mercedes Benz',
                                      'MINI',
                                      'Mitsubishi',
                                      'Nissan',
                                      'Peugeot',
                                      'Porsche',
                                      'Renault',
                                      'Skoda',
                                      'SsangYong',
                                      'Tata',
                                      'Toyota',
                                      'Volkswagen',
                                      'Zotye',
                                    ]
                                        .map((marca) => DropdownMenuItem(
                                            value: marca,
                                            child: Text(
                                              "$marca",
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
                                    attribute: "color",
                                    decoration:
                                        InputDecoration(labelText: "Color"),
                                    icon: Icon(Icons.palette,
                                        color: Color(hexColor('#61B4E5'))),
                                    //hint: Text('Seleccione el combustible'),
                                    validators: [
                                      FormBuilderValidators.required(
                                          errorText: 'Requerido')
                                    ],
                                    items: [
                                      'Amarillo',
                                      'Blanco',
                                      'Otro',
                                    ]
                                        .map((color) => DropdownMenuItem(
                                            value: color,
                                            child: Text(
                                              "$color",
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
                                    attribute: "tipo",
                                    decoration:
                                        InputDecoration(labelText: "Tipo"),
                                    icon: Icon(FontAwesome.bus,
                                        color: Color(hexColor('#61B4E5'))),
                                    //hint: Text('Seleccione el combustible'),
                                    validators: [
                                      FormBuilderValidators.required(
                                          errorText: 'Requerido')
                                    ],
                                    items: [
                                      'Furgoneta',
                                      'Bus',
                                      'Automovil',
                                    ]
                                        .map((tipo) => DropdownMenuItem(
                                            value: tipo,
                                            child: Text(
                                              "$tipo",
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
                            if (_fase1Key.currentState.saveAndValidate()) {
                              print(
                                _fase1Key.currentState.value,
                              );

                              AwesomeDialog(
                                  btnOkColor: Color(hexColor('#5CC4B8')),
                                  context: context,
                                  dialogType: DialogType.SUCCES,
                                  animType: AnimType.TOPSLIDE,
                                  tittle: 'Registro Exitoso',
                                  desc:
                                      'Se ha agregado un nuevo vehículo al servicio',
                                  //btnCancelOnPress: () {},
                                  btnOkOnPress: () async {
                                    Navigator.popAndPushNamed(
                                        context, 'servicesMonitor');
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
                                    /* Navigator.pushNamed(context, 'registroMonitor'); */
                                    if (await Vibration.hasVibrator()) {
                                      Vibration.vibrate();
                                    }
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
                            Navigator.popAndPushNamed(
                                context, 'servicesMonitor');
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
