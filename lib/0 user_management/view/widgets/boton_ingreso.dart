import 'package:antawaschool/0%20user_management/bloc/bloc_user.dart';
import 'package:antawaschool/0%20user_management/model/user_adm_model.dart';
import 'package:antawaschool/utils/hexaColor.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class BotonSingInIngreso extends StatelessWidget {
  const BotonSingInIngreso({
    Key key,
    @required GlobalKey<FormBuilderState> ingresoAdminKey,
  })  : _ingresoAdminKey = ingresoAdminKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _ingresoAdminKey;

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return StreamBuilder(
        stream:
            Firestore.instance.collection('userAdministradorAtwGo').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return InkWell(
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(hexColor('#5CC4B8')),
                      Color(hexColor('#3F7EA3')),
                      Color(hexColor('#5CC4B8'))
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
                    onTap: () async {
                      try {
                        _ingresoAdminKey.currentState.saveAndValidate();
                        print(
                          _ingresoAdminKey.currentState.value,
                        );

                        Firestore.instance
                            .collection('userAdministradorAtwGo')
                            .snapshots()
                            .listen((data) => data.documents.forEach((docAdm) {
                                  if (_ingresoAdminKey
                                              .currentState.value['correo'] ==
                                          docAdm["email"] &&
                                      _ingresoAdminKey
                                              .currentState.value['cedula'] ==
                                          docAdm["identificacion"] &&
                                      _ingresoAdminKey
                                              .currentState.value['password'] ==
                                          docAdm["contraseña"]) {
                                    print('coincide');
                                  }
                                }))
                            .asFuture(await userBloc
                                .signInWithPasswordAndEmail(
                                    _ingresoAdminKey
                                        .currentState.value['correo'],
                                    _ingresoAdminKey
                                        .currentState.value['password']).catchError((e){
                                          return AwesomeDialog(
                                    btnOkColor: Color(hexColor('#E86A87')),
                                    context: context,
                                    dialogType: DialogType.ERROR,
                                    animType: AnimType.TOPSLIDE,
                                    tittle: 'Error de Registro ',
                                    desc: 'Revise campos obligatorios',
                                    //btnCancelOnPress: () {},
                                    btnOkOnPress: () {
                                      //Navigator.pushNamed(context, '/');
                                    }).show();
                                        })
                                .then((user) {
                              userBloc.updateUserData(UserAdmin(
                                  uid: user.uid,
                                  email: user.email,
                                  cedula: _ingresoAdminKey
                                      .currentState.value['cedula'],
                                  password: _ingresoAdminKey
                                      .currentState.value['password']));
                            }
                            
                            ));
                      } catch (e) {
                        print(e.toString());
                      }
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
          } else {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}
