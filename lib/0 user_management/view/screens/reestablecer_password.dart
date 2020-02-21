import 'package:antawaschool/0%20user_management/bloc/bloc_user.dart';
import 'package:antawaschool/0%20user_management/view/widgets/cabecera.dart';
import 'package:antawaschool/0%20user_management/view/widgets/fondo_ingreso.dart';
import 'package:antawaschool/0%20user_management/view/widgets/formulario_password2.dart';
import 'package:antawaschool/utils/hexaColor.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ReestablecerPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _passwordKey =
        GlobalKey<FormBuilderState>();
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FondoIngreso(),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Cabecera(),
                    SizedBox(height: 80),

                    FormularioPassword(
                      password: _passwordKey,
                      colorField: Colors.white,
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
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
                                  borderRadius:
                                      new BorderRadius.circular(15.0)),
                              color: Color(hexColor('#5CC4B8')),
                              child: Text('Recuperar Contraseña',
                                  style: new TextStyle(
                                      fontSize: 16.0, color: Colors.white)),
                              onPressed: () {
                                _passwordKey.currentState.saveAndValidate();
                                print(
                                  _passwordKey.currentState.value,
                                );

                                final userBloc =
                                    BlocProvider.of<UserBloc>(context);
                                if (userBloc.getCurrentUser2() != null) {
                                  userBloc.sendPasswordResetMail2(_passwordKey
                                      .currentState.value['correoRecuperar']);

                                  AwesomeDialog(
                                      btnOkColor: Color(hexColor('#5CC4B8')),
                                      context: context,
                                      dialogType: DialogType.SUCCES,
                                      animType: AnimType.TOPSLIDE,
                                      tittle: 'Recuperación de Contraseña',
                                      desc:
                                          'Revise su email para recuperar la contraseña',
                                      //btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        Navigator.pop(context);
                                        //Navigator.of(context).pop();
                                      }).show();
                                } else{
                                  print('object');
                                }
                              },
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 25,
                    ),

                    SizedBox(
                      height: 25,
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    //RedesSocialesSignIn(colorField: colorField),
                    SizedBox(
                      height: 300,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
