import 'package:antawaschool/0%20user_management/model/user_adm_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreApi {
  final String USERS = 'userAdministradorAtwGo';
  final Firestore _db = Firestore.instance;

  void updateUserData(UserAdmin user) async {
    DocumentReference ref = _db.collection(USERS).document(user.email);
    return ref.setData({
      'uid': user.uid,
      'nombres': user.nombres,
      'email': user.email,
      'identificacion': user.cedula,
      'contraseña': user.password,
      'photoUrl': user.photoUrl,
      'lastSignIn': DateTime.now(),
    }, merge: true).then((value) => print(
        'Se ha grabado la siguiente información en base de datos: $ref '));
  }
}


/*                       try {
                        await Firestore.instance
                            .collection('userAdministradorAtwGo')
                            .document('User_adm1717084592')
                            .get()
                            .then((DocumentSnapshot documentAdmin) {
                          if (
                              _ingresoAdminKey.currentState.value['correo'] ==documentAdmin["email"] && 
                              _ingresoAdminKey.currentState.value['cedula'] ==
                                      documentAdmin["identificacion"] &&
                                  _ingresoAdminKey
                                          .currentState.value['password'] ==
                                      documentAdmin["contraseña"]) {
                            print('Exito');
                          
                            userBloc
                                .signInWithPasswordAndEmail(
                                    _ingresoAdminKey
                                        .currentState.value['correo'],
                                    _ingresoAdminKey
                                        .currentState.value['password'])
                                .then((user) {
                              userBloc.updateUserData(
                                  UserAdmin(uid: user.uid, email: user.email));
                                    print('Exito2');
                            });
                            print('Exito3');
                            /*    AwesomeDialog(
                                        dismissOnTouchOutside: false,
                                        btnOkColor: Color(hexColor('#5CC4B8')),
                                        context: context,
                                        dialogType: DialogType.SUCCES,
                                        animType: AnimType.TOPSLIDE,
                                        tittle: 'Ingreso Exitoso',
                                        desc: "Bienvenido ${documentAdmin["nombre"]}",
                                        //btnCancelOnPress: () {},
                                        btnOkOnPress: () {
                                     Navigator.pop(context);
                                        }).show(); */
                          } else {
                            print('no coincide');
                          }
                        });
                      } catch (e) {
                        print(e.toString());
                      } */
////////////////////////////////////////////
                      /* try {
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
                                    try {
                                      print('coincide');
                                      /* userBloc
                                          .registroWithPasswordAndEmail(
                                              _ingresoAdminKey
                                                  .currentState.value['email'],
                                              _ingresoAdminKey.currentState
                                                  .value['password'])
                                          .then((user) {
                                        userBloc.updateUserData(UserAdmin(
                                            uid: user.uid, email: user.email));
                                      });
                                      AwesomeDialog(
                                          dismissOnTouchOutside: false,
                                          btnOkColor:
                                              Color(hexColor('#5CC4B8')),
                                          context: context,
                                          dialogType: DialogType.SUCCES,
                                          animType: AnimType.TOPSLIDE,
                                          tittle: 'Ingreso Exitoso',
                                          desc:
                                              "Bienvenido ${docAdm["nombre"]}",
                                          //btnCancelOnPress: () {},
                                          btnOkOnPress: () {
                                            Navigator.pushReplacementNamed(
                                                context, 'home');
                                          }).show();

                                      Navigator.of(context).pop(); */
                                    } on PlatformException catch (e) {
                                      AwesomeDialog(
                                              btnOkColor:
                                                  Color(hexColor('#F6C34F')),
                                              context: context,
                                              dialogType: DialogType.ERROR,
                                              animType: AnimType.TOPSLIDE,
                                              tittle: 'Verificación',
                                              desc: e.message,
                                              btnCancelText: 'Aceptar',
                                              btnCancelOnPress: () {})
                                          .show();
                                    }
                                  } else {
                                    print('no coincide');
                                  }
                                }))
                            .asFuture(() {
                          userBloc
                              .signInWithPasswordAndEmail(
                                  _ingresoAdminKey.currentState.value['correo'],
                                  _ingresoAdminKey
                                      .currentState.value['password'])
                              .then((user) {
                            userBloc.updateUserData(
                                UserAdmin(uid: user.uid, email: user.email));
                            print('Exito2');
                          });
                        });
                      } catch (e) {
                        print(e.toString());
                      } */
