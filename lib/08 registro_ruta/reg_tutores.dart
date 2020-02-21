import 'dart:io';

import 'package:antawaschool/utils/hexaColor.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:condition/condition.dart';
import 'package:vibration/vibration.dart';

class ResgistroTutores extends StatefulWidget {
  ResgistroTutores({Key key}) : super(key: key);

  @override
  _ResgistroTutoresState createState() => _ResgistroTutoresState();
}

class _ResgistroTutoresState extends State<ResgistroTutores> {
  final GlobalKey<FormBuilderState> _cantKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _rl1Key = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _rl2Key = GlobalKey<FormBuilderState>();
/*   final GlobalKey<FormBuilderState> _rl3Key = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _rl4Key = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _rl5Key = GlobalKey<FormBuilderState>(); */

  int count;
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
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    SafeArea(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Registro de Estudiantes y Tutores'.toUpperCase(),
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
                                AssetImage("assets/icon/FAMILIA.png"),
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
                    FormBuilder(
                        key: _cantKey,
                        initialValue: {
                          'date': DateTime.now(),
                          'accept_terms': false,
                        },
                        autovalidate: true,
                        child: Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(FontAwesome.user_circle,
                                  color: Color(hexColor('#3A4A64'))),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Cantidad de estudiantes por parada',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(hexColor('#3A4A64'))),
                              ),
                            ],
                          ),
                          FormBuilderSegmentedControl(
                              decoration: InputDecoration(
                                  labelText:
                                      "Conforme a la parada seleccionada"),
                              attribute: "cantEstudiantes",
                              options: List.generate(5, (i) => i + 1)
                                  .map((number) =>
                                      FormBuilderFieldOption(value: number))
                                  .toList(),
                              key: Key('value'),
                              onChanged: (value) {
                                setState(() {
                                  count = value;
                                });
                              }),
                          SizedBox(
                            height: 5,
                          ),
                        ])),
                    Container(
                      child: Conditioned(
                        cases: [
                          unTutor(),
                          Case(count == 2,
                              builder: () => Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    children: <Widget>[
                                      unTutorExpandad(),
                                      dosTutoresExpandad(),
                                      //Divider(),
                                    ],
                                  ))),
                          Case(count == 3,
                              builder: () => Icon(Icons.wb_cloudy)),
                          Case(count == 4,
                              builder: () => Icon(Icons.wb_cloudy)),
                          Case(count == 5,
                              builder: () => Icon(Icons.wb_cloudy)),
                        ],
                        defaultBuilder: () => Icon(Icons.wb_sunny),
                      ),
                    ),
                    //EXPANDIBLE 1 DATOS PERSONALES
                    SizedBox(
                      height: 20,
                    ),

                    //BOTONES
                    Row(
                      children: <Widget>[
                        Expanded(child: SizedBox()),
                        FlatButton(
                          onPressed: () {
                            AwesomeDialog(
                                btnOkColor: Color(hexColor('#5CC4B8')),
                                context: context,
                                dialogType: DialogType.SUCCES,
                                animType: AnimType.TOPSLIDE,
                                tittle: 'Registro Exitoso',
                                desc:
                                    'Se ha agregado tutor y estudiante a la parada',
                                //btnCancelOnPress: () {},
                                btnOkOnPress: () async {
                                  Navigator.popAndPushNamed(context, 'regParadas');
                                  if (await Vibration.hasVibrator()) {
    Vibration.vibrate();
}
                                }).show();

/* 
                            if (_rl1Key.currentState.saveAndValidate() &
                                _rl2Key.currentState.saveAndValidate()) {
                              print(
                                _rl1Key.currentState.value,
                              );
                              print(
                                _rl2Key.currentState.value,
                              );
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
                            Navigator.popAndPushNamed(context, 'regParadas');
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

  Case unTutor() {
    return Case(
      count == 1,
      builder: () => Container(
        child: unTutorExpandad(),
      ),
    );
  }

  ExpandablePanel unTutorExpandad() {
    return ExpandablePanel(
      header: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Icon(FontAwesome.child, color: Color(hexColor('#61B4E5'))),
              SizedBox(
                width: 10,
              ),
              Text(
                '(1) Datos del tutor y estudiante',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(hexColor('#61B4E5'))),
              ),
            ],
          ),
          Divider()
        ],
      ),
      collapsed: Container(
        child: FormBuilder(
          key: _rl1Key,
          initialValue: {
            'date': DateTime.now(),
            'accept_terms': false,
          },
          autovalidate: true,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Datos del representante / tutor',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color(hexColor('#E86A87'))),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                textCapitalization: TextCapitalization.sentences,
                attribute: "unTutorNombres",
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.perm_identity,
                      color: Color(hexColor('#61B4E5')),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Nombres del representante / tutor",
                    labelStyle: TextStyle(
                        fontSize: 14, color: Color(hexColor('#3A4A64'))),
                    helperStyle: TextStyle(
                        fontSize: 12, color: Color(hexColor('#61B4E5'))),
                    hintText: 'Ingrese sus nombres'),
                style:
                    TextStyle(fontSize: 14, color: Color(hexColor('#61B4E5'))),
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
              FormBuilderTextField(
                textCapitalization: TextCapitalization.sentences,
                attribute: "unTutorApellidos",
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.perm_identity,
                      color: Color(hexColor('#61B4E5')),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Apellidos del representante / tutor",
                    labelStyle: TextStyle(
                        fontSize: 14, color: Color(hexColor('#3A4A64'))),
                    helperStyle: TextStyle(
                        fontSize: 12, color: Color(hexColor('#61B4E5'))),
                    hintText: 'Ingrese sus apellidos'),
                style:
                    TextStyle(fontSize: 14, color: Color(hexColor('#61B4E5'))),
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
              FormBuilderTextField(
                keyboardType: TextInputType.number,
                attribute: "unTutorCedula",
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      FontAwesome.id_card,
                      color: Color(hexColor('#61B4E5')),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Cédula del representante / tutor",
                    labelStyle: TextStyle(
                        fontSize: 14, color: Color(hexColor('#3A4A64'))),
                    helperStyle: TextStyle(
                        fontSize: 12, color: Color(hexColor('#61B4E5'))),
                    hintText: 'Ingrese su cédula o documento de identidad'),
                style:
                    TextStyle(fontSize: 14, color: Color(hexColor('#61B4E5'))),
                validators: [
                  FormBuilderValidators.required(errorText: 'Requerido'),
                  FormBuilderValidators.minLength(5,
                      errorText: 'Mínimo 5 caracters')
                ],
              ),
              SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                keyboardType: TextInputType.phone,
                attribute: "unTutorCelular",
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.phone,
                      color: Color(hexColor('#61B4E5')),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Celular",
                    labelStyle: TextStyle(
                        fontSize: 14, color: Color(hexColor('#3A4A64'))),
                    helperStyle: TextStyle(
                        fontSize: 12, color: Color(hexColor('#61B4E5'))),
                    hintText: 'Ingrese su celular'),
                style:
                    TextStyle(fontSize: 14, color: Color(hexColor('#61B4E5'))),
                validators: [
                  FormBuilderValidators.required(
                    errorText: 'Requerido',
                  ),
                  FormBuilderValidators.minLength(10,
                      errorText: 'Mínimo 10 caracteres'),
                  FormBuilderValidators.numeric(errorText: 'Solo números')
                ],
              ),
              SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                keyboardType: TextInputType.emailAddress,
                attribute: "unTutorEmail",
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.alternate_email,
                      color: Color(hexColor('#61B4E5')),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Email",
                    labelStyle: TextStyle(
                        fontSize: 14, color: Color(hexColor('#3A4A64'))),
                    helperStyle: TextStyle(
                        fontSize: 12, color: Color(hexColor('#61B4E5'))),
                    hintText: 'Ingrese su email'),
                style:
                    TextStyle(fontSize: 14, color: Color(hexColor('#61B4E5'))),
                validators: [
                  FormBuilderValidators.required(
                    errorText: 'Requerido',
                  ),
                  FormBuilderValidators.email(
                      errorText: 'Debe ser un correo válido')
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Text(
                    'Datos del estudiante',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color(hexColor('#E86A87'))),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                textCapitalization: TextCapitalization.sentences,
                attribute: "unEstudianteNombres",
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.perm_identity,
                      color: Color(hexColor('#61B4E5')),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Nombres del estudiante",
                    labelStyle: TextStyle(
                        fontSize: 14, color: Color(hexColor('#3A4A64'))),
                    helperStyle: TextStyle(
                        fontSize: 12, color: Color(hexColor('#61B4E5'))),
                    hintText: 'Ingrese sus nombres'),
                style:
                    TextStyle(fontSize: 14, color: Color(hexColor('#61B4E5'))),
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
              FormBuilderTextField(
                textCapitalization: TextCapitalization.sentences,
                attribute: "unEstudianteApellidos",
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.perm_identity,
                      color: Color(hexColor('#61B4E5')),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Apellidos del Estudiante",
                    labelStyle: TextStyle(
                        fontSize: 14, color: Color(hexColor('#3A4A64'))),
                    helperStyle: TextStyle(
                        fontSize: 12, color: Color(hexColor('#61B4E5'))),
                    hintText: 'Ingrese sus apellidos'),
                style:
                    TextStyle(fontSize: 14, color: Color(hexColor('#61B4E5'))),
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
            ],
          ),
        ),
      ),
    );
  }

  ExpandablePanel dosTutoresExpandad() {
    return ExpandablePanel(
      header: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Icon(FontAwesome.child, color: Color(hexColor('#61B4E5'))),
              SizedBox(
                width: 10,
              ),
              Text(
                '(2) Datos del tutor y estudiante',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(hexColor('#61B4E5'))),
              ),
            ],
          ),
          Divider()
        ],
      ),
      collapsed: Container(
        child: FormBuilder(
          key: _rl2Key,
          initialValue: {
            'date': DateTime.now(),
            'accept_terms': false,
          },
          autovalidate: true,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Datos del representante / tutor',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color(hexColor('#E86A87'))),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                textCapitalization: TextCapitalization.sentences,
                attribute: "unTutorNombres",
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.perm_identity,
                      color: Color(hexColor('#61B4E5')),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Nombres del representante / tutor",
                    labelStyle: TextStyle(
                        fontSize: 14, color: Color(hexColor('#3A4A64'))),
                    helperStyle: TextStyle(
                        fontSize: 12, color: Color(hexColor('#61B4E5'))),
                    hintText: 'Ingrese sus nombres'),
                style:
                    TextStyle(fontSize: 14, color: Color(hexColor('#61B4E5'))),
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
              FormBuilderTextField(
                textCapitalization: TextCapitalization.sentences,
                attribute: "unTutorApellidos",
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.perm_identity,
                      color: Color(hexColor('#61B4E5')),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Apellidos del representante / tutor",
                    labelStyle: TextStyle(
                        fontSize: 14, color: Color(hexColor('#3A4A64'))),
                    helperStyle: TextStyle(
                        fontSize: 12, color: Color(hexColor('#61B4E5'))),
                    hintText: 'Ingrese sus apellidos'),
                style:
                    TextStyle(fontSize: 14, color: Color(hexColor('#61B4E5'))),
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
              FormBuilderTextField(
                keyboardType: TextInputType.number,
                attribute: "unTutorCedula",
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      FontAwesome.id_card,
                      color: Color(hexColor('#61B4E5')),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Cédula del representante / tutor",
                    labelStyle: TextStyle(
                        fontSize: 14, color: Color(hexColor('#3A4A64'))),
                    helperStyle: TextStyle(
                        fontSize: 12, color: Color(hexColor('#61B4E5'))),
                    hintText: 'Ingrese su cédula o documento de identidad'),
                style:
                    TextStyle(fontSize: 14, color: Color(hexColor('#61B4E5'))),
                validators: [
                  FormBuilderValidators.required(errorText: 'Requerido'),
                  FormBuilderValidators.minLength(5,
                      errorText: 'Mínimo 5 caracters')
                ],
              ),
              SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                keyboardType: TextInputType.phone,
                attribute: "unTutorCelular",
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.phone,
                      color: Color(hexColor('#61B4E5')),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Celular",
                    labelStyle: TextStyle(
                        fontSize: 14, color: Color(hexColor('#3A4A64'))),
                    helperStyle: TextStyle(
                        fontSize: 12, color: Color(hexColor('#61B4E5'))),
                    hintText: 'Ingrese su celular'),
                style:
                    TextStyle(fontSize: 14, color: Color(hexColor('#61B4E5'))),
                validators: [
                  FormBuilderValidators.required(
                    errorText: 'Requerido',
                  ),
                  FormBuilderValidators.minLength(10,
                      errorText: 'Mínimo 10 caracteres'),
                  FormBuilderValidators.numeric(errorText: 'Solo números')
                ],
              ),
              SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                keyboardType: TextInputType.emailAddress,
                attribute: "unTutorEmail",
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.alternate_email,
                      color: Color(hexColor('#61B4E5')),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Email",
                    labelStyle: TextStyle(
                        fontSize: 14, color: Color(hexColor('#3A4A64'))),
                    helperStyle: TextStyle(
                        fontSize: 12, color: Color(hexColor('#61B4E5'))),
                    hintText: 'Ingrese su email'),
                style:
                    TextStyle(fontSize: 14, color: Color(hexColor('#61B4E5'))),
                validators: [
                  FormBuilderValidators.required(
                    errorText: 'Requerido',
                  ),
                  FormBuilderValidators.email(
                      errorText: 'Debe ser un correo válido')
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Text(
                    'Datos del estudiante',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color(hexColor('#E86A87'))),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                textCapitalization: TextCapitalization.sentences,
                attribute: "unEstudianteNombres",
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.perm_identity,
                      color: Color(hexColor('#61B4E5')),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Nombres del estudiante",
                    labelStyle: TextStyle(
                        fontSize: 14, color: Color(hexColor('#3A4A64'))),
                    helperStyle: TextStyle(
                        fontSize: 12, color: Color(hexColor('#61B4E5'))),
                    hintText: 'Ingrese sus nombres'),
                style:
                    TextStyle(fontSize: 14, color: Color(hexColor('#61B4E5'))),
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
              FormBuilderTextField(
                textCapitalization: TextCapitalization.sentences,
                attribute: "unEstudianteApellidos",
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.perm_identity,
                      color: Color(hexColor('#61B4E5')),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Apellidos del Estudiante",
                    labelStyle: TextStyle(
                        fontSize: 14, color: Color(hexColor('#3A4A64'))),
                    helperStyle: TextStyle(
                        fontSize: 12, color: Color(hexColor('#61B4E5'))),
                    hintText: 'Ingrese sus apellidos'),
                style:
                    TextStyle(fontSize: 14, color: Color(hexColor('#61B4E5'))),
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
            ],
          ),
        ),
      ),
    );
  }
}
