import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';


//final d_oIEwBTeJA:APA91bEtjBsejZw8DG4UD3Qv7YwvPXd-ISVveXVp0RefJBTkF8pnYwefUO_PHykV-mdEUhOctI2VLof4CgrI3kltt_epnVS-05Dk4mUIQnfbrP8F3jlFJWZxMgvpX83YLVgp_fNHonu3

class PushNotificationProvider {

FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

final _mensajesStreamController = StreamController<String>.broadcast();

Stream<String> get mensajes => _mensajesStreamController.stream;

initNotificatiom(){
  _firebaseMessaging.requestNotificationPermissions();
  _firebaseMessaging.getToken().then((token){

    print('-token de prueba-');
    print(token);
  });

  _firebaseMessaging.configure(

      onMessage: ( info ) async{

        print('======= On Message ========');
        print( info );
        String argumento = 'no-data';
        if ( Platform.isAndroid  ) {  
         argumento = info['data']['comida'] ?? 'no-data';
        } else {
         argumento = info['comida'] ?? 'no-data-ios';
        }
        _mensajesStreamController.sink.add(argumento);
      },
      onLaunch: ( info ) async {
        print('======= On Launch ========');
        print( info );
      },

      onResume: ( info ) async {
        print('======= On Resume ========');
        print( info );
      
        String argumento = 'no-data';

      if ( Platform.isAndroid  ) {  
        argumento = info['data']['comida'] ?? 'no-data';
      } else {
        argumento = info['comida'] ?? 'no-data-ios';
      }
      _mensajesStreamController.sink.add(argumento);
     }
  );

}
    dispose() {
    _mensajesStreamController?.close();
  }

}