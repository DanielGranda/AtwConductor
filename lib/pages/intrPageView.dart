import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

import 'loginPageUi/loginAtg.dart';



//import 'homePage.dart';

class IntroPage extends StatelessWidget {
  //final prefs = new PreferenciasUsuario();

  static final String routeName = 'intro';

  static TextStyle style = TextStyle(fontSize: 25.0, /* fontFamily: "Poppins-Medium" */);
  //making list of pages needed to pass in IntroViewsFlutter constructor.
  final pages = [
    PageViewModel(
        pageColor: const Color(0xFF03A9F4),
        bubble: Image.asset('assets/inic2.png'),
        body: Text(
//          'Welcome  to  intro  slider  in  flutter  with  package  intro  views  flutter  latest  update',
          'Sistema de Monitoreo de Transporte Escolar',style: TextStyle(fontSize: 30),
        ),
        title: Text(
          '',
          style: TextStyle(fontFamily: "Poppins-Bold"),
        ),
        //textStyle: TextStyle(fontFamily: 'Rubik-Light', color: Colors.white),
        mainImage: Image.asset(
         'assets/inic2.png',
          height: 285.0,
          width: double.infinity,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: const Color(0xFF8BC34A),
      iconImageAssetPath: 'assets/inic3.png',
      bodyTextStyle: TextStyle(fontSize: 5),
      body: Text(
//        'Amazevalley  intoduce  you  with  the  latest  features  coming  in  flutter  with  practical  demos',
        'Información en tiempo real de la ruta',style: TextStyle(fontSize: 30),
      ),
      title: Text(''),
      mainImage: Image.asset(
        'assets/inic3.png',
        height: 285.0,
        width: double.infinity,
        alignment: Alignment.center,
      ),
      //textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
    PageViewModel(
      pageColor: const Color(0xFFFF8020),
      iconImageAssetPath: 'assets/inic1.png',
      body: Text(
//        'Amazevalley  give  you  brief  soluton  about  technology  where  you  fall  in  love',
        'Representantes siempre informados',style: TextStyle(fontSize: 30),
      ),
      title: Text(''),
      mainImage: Image.asset(
        'assets/inic1.png',
        height: 285.0,
        width: double.infinity,
        alignment: Alignment.center,
      ),
      //textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    //prefs.ultimaPagina = HomePage.routeName;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.white, accentColor: Colors.white, dialogBackgroundColor: Colors.transparent, fontFamily: 'rubik'),
      
      //title: 'IntroViews Flutter', //title of app
      //theme: ThemeData(
      //  primarySwatch: Colors.blue,
      //), //ThemeData
      home: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          onTapDoneButton: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => 
                LoginAtw(),
                //HomePageMonitor(),
              ), //MaterialPageRoute
            );
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ), //IntroViewsFlutter
      ), //Builder
    ); //Material App
  }
}