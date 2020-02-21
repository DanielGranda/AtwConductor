import 'package:antawaschool/0%20user_management/bloc/bloc_user.dart';
import 'package:antawaschool/0%20user_management/view/widgets/cabecera.dart';
import 'package:antawaschool/0%20user_management/view/widgets/fondo_ingreso.dart';
import 'package:antawaschool/0%20user_management/view/widgets/formulario_SingIn.dart';
import 'package:antawaschool/utils/hexaColor.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vibration/vibration.dart';

class LoginSignUpPage2 extends StatefulWidget {
  LoginSignUpPage2({this.onSignedIn});

  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginSignUpPage2State();
}

enum FormMode { LOGIN, SIGNUP }

class _LoginSignUpPage2State extends State<LoginSignUpPage2> {
  final GlobalKey<FormBuilderState> _ingresoEscuelaKey =
      GlobalKey<FormBuilderState>();

  final _formKey = new GlobalKey<FormState>();

  String _errorMessage;

  Color colorField = Color(hexColor('#3A4A64'));

  // Initial form is login form
  FormMode _formMode = FormMode.LOGIN;
  bool _isIos;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void _validateAndSubmit() async {
    if (_ingresoEscuelaKey.currentState.saveAndValidate()) {
      print(
        _ingresoEscuelaKey.currentState.value,
      );
    
            Navigator.popAndPushNamed(context, 'homeConductor');
            if (await Vibration.hasVibrator()) {
    Vibration.vibrate();
}
    
    } else {
      if (await Vibration.hasVibrator()) {
    Vibration.vibrate();
}
         AwesomeDialog(
                btnCancelColor: Color(hexColor('#E86A87')),
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.TOPSLIDE,
                tittle: 'Verificación',
                desc: 'Verifique los datos para el registro',
                btnCancelText: 'Aceptar',
                btnCancelOnPress: () {})
            .show();
    }
/* 
    _ingresoEscuelaKey.currentState.saveAndValidate();
    print(
      _ingresoEscuelaKey.currentState.value,
    );
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_validateAndSave()) {
      FirebaseUser userId;
      try {
        if (_formMode == FormMode.LOGIN) {
          final userBloc = BlocProvider.of<UserBloc>(context);
          userId = await userBloc
              .signInWithEmailAndPassword2(
                  _ingresoEscuelaKey.currentState.value['email'],
                  _ingresoEscuelaKey.currentState.value['Password'])
              .then((userId) {
            userBloc.updateUserData(UserAdmin(
                uid: userId.uid,
                email: _ingresoEscuelaKey.currentState.value['email'],
                password: _ingresoEscuelaKey.currentState.value['Password']));
            print('Signed in verificacion: $userId');
            return null;
          });
        } else {
          final userBloc = BlocProvider.of<UserBloc>(context);
          userId = await userBloc
              .signUp2(_ingresoEscuelaKey.currentState.value['email'],
                  _ingresoEscuelaKey.currentState.value['Password'])
              .then((userId) {
            userBloc.updateUserData(UserAdmin(
                uid: userId.uid,
                email: _ingresoEscuelaKey.currentState.value['email'],
                password: _ingresoEscuelaKey.currentState.value['Password']));
            return null;
          });
          userBloc.sendEmailVerification2();
          //_showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId != null && _formMode == FormMode.LOGIN) {
          widget.onSignedIn();
        }
      } catch (e) {
        print('Error: $e');
        if (this.mounted) {
          setState(() {
            _isLoading = false;
            if (_isIos) {
              _errorMessage = e.details;
            } else
              _errorMessage = e.message;
          });
        }
      }
      if (_errorMessage.length > 0 && _errorMessage != null) {
        return AwesomeDialog(
                btnOkColor: Color(hexColor('#E86A87')),
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.TOPSLIDE,
                tittle: 'Error de Registro ',
                desc: _errorMessage,
                //btnCancelOnPress: () {},
                btnOkOnPress: () {
                  //Navigator.pushNamed(context, '/');
                })
            .show();
      }
    } */
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  @override
  void dispose() {
    UserBloc().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return new Material(
        child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FondoIngreso(),
        _showBody(),
        _showCircularProgress(),
      ],
    ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  void _showVerifyEmailSentDialog() {
    AwesomeDialog(
        btnOkColor: Color(hexColor('#5CC4B8')),
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.TOPSLIDE,
        tittle: 'Registro Exitoso',
        desc:
            'El enlace para verificar la cuenta ha sido enviado a su correo electrónico',
        //btnCancelOnPress: () {},
        btnOkOnPress: () {
          _changeFormToLogin();
          //Navigator.of(context).pop();
        }).show();
  }

  Widget _showBody() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(height: 50),
              Cabecera(),
              SizedBox(height: 20),
              FormularioSingIn(
                  ingresoEscuelaKey: _ingresoEscuelaKey,
                  colorField: colorField),
              SizedBox(height: 10),
             /*  GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'recuperarClave');
                },
                child: Row(
                  children: <Widget>[
                    Expanded(child: SizedBox(width: 10)),
                    Text(
                      '¿Olvidastes tu contraseña?',
                      style: TextStyle(
                        color: Color(hexColor('#5CC4B8')),
                      ),
                    ),
                  ],
                ),
              ), */
              SizedBox(height: 30),
              _showPrimaryButton(),
              _showSecondaryButton(),
              SizedBox(height: 20),
              SizedBox(height: 300),
            ],
          ),
        ));
  }

  Widget _showSecondaryButton() {
    return new FlatButton(
      child: _formMode == FormMode.LOGIN
          ? Column(
              children: <Widget>[
                SizedBox(height: 30),
                new Text('Crear Cuenta',
                    style: new TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(hexColor('#F6C34F')),
                    )),
              ],
            )
          : Column(
              children: <Widget>[
                SizedBox(height: 30),
                new Text('¿Tienes cuenta? Ingresa',
                    style: new TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(hexColor('#F6C34F')),
                    )),
              ],
            ),
      onPressed: _formMode == FormMode.LOGIN
          ? _changeFormToSignUp
          : _changeFormToLogin,
    );
  }

  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                ]),
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF6078ea).withOpacity(.5),
                      offset: Offset(0.0, 8.0),
                      blurRadius: 8.0)
                ]),
            child: new RaisedButton(
              elevation: 5.0,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0)),
              color: Color(hexColor('#3A4A64')),
              child: _formMode == FormMode.LOGIN
                  ? new Text('Ingresar',
                      style: new TextStyle(fontSize: 18.0, color: Colors.white))
                  : new Text('Crear una cuenta',
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.white)),
              onPressed: _validateAndSubmit,
            ),
          ),
        ));
  }
}
