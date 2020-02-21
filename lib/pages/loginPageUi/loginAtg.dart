import 'package:antawaschool/pages/loginPageUi/socialIcons.dart';
import 'package:antawaschool/utils/hexaColor.dart';
import 'package:antawaschool/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class LoginAtw extends StatefulWidget {
  @override
  _LoginAtwState createState() => new _LoginAtwState();
}

class _LoginAtwState extends State<LoginAtw> {
  bool _isSelected = false;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  final GlobalKey<FormBuilderState> _ingresoBusesKey =
      GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.black12,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          fondo(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 40.0),
              child: Column(
                children: <Widget>[
                  cabecera(),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(100),
                  ),
                  formularioRegistro(),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      botonIngresar(context),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(80),
                  ),
                  //socialencabezado(),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  //socialLogin(),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Nuevo Usuario? ",
                        style: TextStyle(
                            fontFamily: "Poppins-Medium", color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text("Registrase",
                            style: TextStyle(
                                color: Color(0xFF5d74e3),
                                fontFamily: "Poppins-Bold")),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Row socialencabezado() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        horizontalLine(),
        Text("Social Login",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                fontFamily: "Poppins-Medium")),
        horizontalLine()
      ],
    );
  }

  Row socialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocialIcon(
          colors: [
            Color(0xFF102397),
            Color(0xFF187adf),
            Color(0xFF00eaf8),
          ],
          iconData: FontAwesome.facebook_f,
          onPressed: () {},
        ),
        SocialIcon(
          colors: [
            Color(0xFFff4f38),
            Color(0xFFff355d),
          ],
          iconData: FontAwesome.google,
          onPressed: () {},
        ),
        SocialIcon(
          colors: [
            Color(0xFF17ead9),
            Color(0xFF6078ea),
          ],
          iconData: FontAwesome.linkedin,
          onPressed: () {},
        ),
        SocialIcon(
          colors: [
            Color(0xFF00c6fb),
            Color(0xFF005bea),
          ],
          iconData: FontAwesome.whatsapp,
          onPressed: () {},
        )
      ],
    );
  }

  InkWell botonIngresar(BuildContext context) {
    return InkWell(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(330),
        height: ScreenUtil.getInstance().setHeight(100),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(hexColor('#61B4E5')),
              Color(hexColor('#5CC4B8')),
            ]),
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF6078ea).withOpacity(.3),
                  offset: Offset(0.0, 8.0),
                  blurRadius: 8.0)
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
             if (_ingresoBusesKey.currentState.saveAndValidate()) {
      print(
        _ingresoBusesKey.currentState.value,
      );
        Navigator.pushReplacementNamed(context, 'intro');}
            },
            child: Center(
              child: Text("INGRESAR",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins-Bold",
                      fontSize: 18,
                      letterSpacing: 1.0)),
            ),
          ),
        ),
      ),
    );
  }

  Container formularioRegistro() {
    Color colorField = Colors.white;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 10.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Iniciar Sesión",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          fontFamily: "Poppins-Medium")),
                    SizedBox(height: 50,)
                ],
              ),
              FormBuilder(
                key: _ingresoBusesKey,
                initialValue: {
                  'date': DateTime.now(),
                  'accept_terms': false,
                },
                autovalidate: true,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: <Widget>[
                      FormBuilderTextField(
                        keyboardType: TextInputType.emailAddress,
                        attribute: "email",
                        decoration: InputDecoration(
                            suffixIcon:
                                Icon(Icons.alternate_email, color: Color(hexColor('#5CC4B8'))),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            labelText: "Email",
                            labelStyle:
                                TextStyle(fontSize: 14, color: colorField),
                            helperStyle:
                                TextStyle(fontSize: 12, color: colorField),
                            hintText: 'Ingrese su email'),
                            
                        style: TextStyle(fontSize: 14, color: colorField),
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
                      FormBuilderTextField(
                        keyboardType: TextInputType.emailAddress,
                        attribute: "Password",
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.lock, color:Color(hexColor('#5CC4B8'))),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            labelText: "Contraseña",
                            labelStyle:
                                TextStyle(fontSize: 14, color: colorField),
                            helperStyle:
                                TextStyle(fontSize: 12, color: colorField),
                            hintText: 'Ingrese su contraseña'),
                        style: TextStyle(fontSize: 14, color: colorField),
                        validators: [
                          FormBuilderValidators.required(
                            errorText: 'Requerido',
                          ),
                          FormBuilderValidators.minLength(6,
                              errorText: 'Mínimo 6 caracteres')
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Container fondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
          image: DecorationImage(
        colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2), BlendMode.colorBurn),
        image: AssetImage("assets/backGround/backGroundAtw.png"),
        fit: BoxFit.contain,
      )),
    );
  }

  Row cabecera() {
    return Row(
      children: <Widget>[
        Image.asset(
          "assets/LogoATGSN.png",
          width: ScreenUtil.getInstance().setWidth(110),
          height: ScreenUtil.getInstance().setHeight(110),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("ANTAWA SCHOOL",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins-Bold",
                    fontSize: ScreenUtil.getInstance().setSp(46),
                    letterSpacing: .6,
                    fontWeight: FontWeight.bold)),
            Text("Conductor",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins-Bold",
                    fontSize: ScreenUtil.getInstance().setSp(40),
                    letterSpacing: .4,
                    fontWeight: FontWeight.bold)),
          ],
        )
      ],
    );
  }
}
