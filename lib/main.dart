import 'package:antawaschool/pages/homePage/util/HomePage.dart';
import 'package:antawaschool/pages/intrPageView.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      imageBackground: AssetImage('assets/SPASH_SCREEN_2.gif'),
      seconds: 8,
      navigateAfterSeconds: 
      //HomePage(),
      new IntroPage(),
      title: new Text(
        '',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      //image: Image.asset('assets/SPASH_SCREEN_2.gif'),
      /* Image.network('https://flutter.io/images/catalog-widget-placeholder.png'), */

      //backgroundGradient: new LinearGradient(colors: [Colors.cyan, Colors.blue], begin: Alignment.topLeft, end: Alignment.bottomRight),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.white.withOpacity(0.2),
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Welcome In SplashScreen Package"),
        automaticallyImplyLeading: false,
      ),
      body: new Center(
        child: new Text(
          "Succeeded!",
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
      ),
    );
  }
}
