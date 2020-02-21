import 'package:antawaschool/09%20notificaciones/pushNotification/push_notification.dart';
import 'package:antawaschool/pages/RegistrePageAppUi/registreAtg.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashAtw extends StatefulWidget {
  @override
  _SplashAtwState createState() => new _SplashAtwState();
}

class _SplashAtwState extends State<SplashAtw> {
  @override
  void initState() {
    super.initState();

    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotificatiom();
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      imageBackground: AssetImage('assets/SPASH_SCREEN_2.gif'),
      seconds: 7, //Teimpo de animación
      navigateAfterSeconds: RegistreAtw(),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: () => print(""),
      loaderColor: Colors.white.withOpacity(0.2),
    );
  }
}