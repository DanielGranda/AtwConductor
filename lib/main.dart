import 'package:antawaschool/estatesApp/socialLoginState.dart';
import 'package:antawaschool/pages/introPage/introAtw.dart';
import 'package:antawaschool/prueba.dart';
import 'package:antawaschool/services/pushNotification/push_notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'pages/MapsPage/HomePageMaps.dart';
import 'pages/MapsPage/MapsPagePrueba.dart';
import 'pages/RegistrePageAppUi/registreAtg.dart';
import 'pages/homePage/util/permitionGpsUI.dart';
import 'pages/loginPageUi/loginAtg.dart';

import 'pages/monitorServices/monitorServices.dart';
import 'pages/registroEPS/registroEPS.dart';
import 'pages/registroEPS/registroMonitor.dart';

void main() {
  runApp(ChangeNotifierProvider<LoginState>(
    create: (BuildContext context) => LoginState(),
    child: new MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: new MyApp(),
     initialRoute: 'splash',
      routes: {
        'registre': (BuildContext context) {
        var state =Provider.of<LoginState>(context);
        if (state.isloggedIn()) {
        return IntroPageAtw();
        } else {
        return RegistreAtw();
        }
        },
        'permition': (_) => PermitionGpsUi(),
        'registroEps': (_) => ResgistroEps(),
        'registroMonitor': (_) => ResgistroMonitor(),
        'map': (_) => MapsPrueba(),
        'login': (_) => LoginAtw(),
        'splash': (_) => MyApp(),
        'prueba': (_) => Prueba(),
        'intro': (_) => IntroPageAtw(),
        'mapAttw': (_) => HomePageMaps(),
        'servicesMonitor': (_) => MonitorServices(),
      },
    ),
  ));
}







class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
