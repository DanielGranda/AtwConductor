import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'estatesApp/socialLoginState.dart';

class Prueba extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(child: Text('Hola'),
         onPressed: () {
           Provider.of<LoginState>(context, listen: false).login();
         },

        )
      ),
    );
  }
}