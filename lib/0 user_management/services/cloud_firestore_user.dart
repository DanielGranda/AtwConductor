
class CloudFirestoreApi{


}

       /*      if (_ingresoPadresKey.currentState.value['email'] ==

                    userData[0]["nombre"]) {
                  Navigator.pushNamed(context, 'home');
                } else {
                  print('no usuario no registrado');
                } */


                /*      onTap: () async {
                      _ingresoPadresKey.currentState.saveAndValidate();
                      print(
                        _ingresoPadresKey.currentState.value,
                      );
                      try {
                        await Firestore.instance
                            .collection('userAdministradorAtwGo')
                            .document('User_adm1717084592')
                            .get()
                            .then((DocumentSnapshot documentAdmin) {
                          if (
                              /* _ingresoPadresKey.currentState.value['nombre'] ==documentAdmin["nombre"] && */
                              _ingresoPadresKey.currentState.value['cedula'] ==
                                      documentAdmin["identificacion"] &&
                                  _ingresoPadresKey
                                          .currentState.value['password'] ==
                                      documentAdmin["contraseña"]) {
                            print('Exito');
                          } else {
                            print('no coincide');
                          }
                        });
                      } catch (e) {
                        print(e.toString());
                      }

               
                    }, */

/* 
                    List userData;
  Map data;
  getUser() async {
    try {
      http.Response reponse =
          await http.get('http://192.168.0.109:3000/unidad');
      debugPrint(reponse.body);
      data = json.decode(reponse.body);
      setState(() {
        userData = data['unidades'];
      });
    } catch (e) {
      print(e.toString());
    }
    print("${userData[0]["nombre"]}");
    //Condicional de ingreso
    /*    if (userData[0]["nombre"] == 'Henry Urre4') {
      Navigator.pushNamed(context, 'home');
    } else {
      print('no usuario no registrado');
    } */
  } */