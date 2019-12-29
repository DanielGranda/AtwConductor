import 'package:antawaschool/services/pushNotification/push_notification.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'pages/MapsPage/HomePageMaps.dart';
import 'pages/MapsPage/MapsPagePrueba.dart';
import 'pages/homePage/util/permitionGpsUI.dart';
import 'pages/introPage/introPageP.dart';
import 'pages/loginPageUi/loginAtg.dart';

import 'package:flutter/material.dart';

/* void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        'home': (_) => HomePageMaps(),
        'permition': (_) => PermitionGpsUi(),
        'map': (_) => MapsPrueba(),
        'login': (_) => LoginAtw(),
        'intro2': (_) => IntroScreen(),
        '/': (_) => MyApp(),
      },
    );
  }
} */

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: new MyApp(),
    initialRoute: '/',
    routes: {
      'permition': (_) => PermitionGpsUi(),
      'map': (_) => MapsPrueba(),
      'login': (_) => LoginAtw(),
      'intro2': (_) => IntroScreen(),
      '/': (_) => MyApp(),
    },
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
      navigateAfterSeconds: LoginAtw(),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: () => print(""),
      loaderColor: Colors.white.withOpacity(0.2),
    );
  }
}
