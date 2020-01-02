import 'package:antawaschool/utils/hexaColor.dart';
import 'package:antawaschool/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormCardRegistre extends StatelessWidget {
  final GlobalKey<FormBuilderState> _registreKey =
      GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return new Container(
      //width: double.infinity,
      //height: ScreenUtil.getInstance().setHeight(500),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Registro",
                style: TextStyle(
                    color: Color(hexColor('#61B4E5')),
                    fontSize: ScreenUtil.getInstance().setSp(45),
                    fontFamily: "Poppins-Bold",
                    letterSpacing: .6)),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Email",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0)),
            SizedBox(
              height: 10,
            ),
            FormBuilder(
              key: _registreKey,
              initialValue: {
                'date': DateTime.now(),
                'accept_terms': false,
              },
              child: FormBuilderTextField(
                keyboardType: TextInputType.emailAddress,
                attribute: "Email",
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
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Contraseña",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  fontFamily: "Poppins-Medium",
                )),
            TextField(
              style: TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Ingrese su contraseña",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "Olvidó su contraseña?",
                  style: TextStyle(
                      color: Colors.blue,
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil.getInstance().setSp(28)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
