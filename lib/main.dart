import 'package:antawaschool/prueba.dart';
import 'package:antawaschool/utils/hexaColor.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '0 user_management/bloc/bloc_user.dart';
import '0 user_management/view/screens/ingreso2.dart';
import '0 user_management/view/screens/reestablecer_password.dart';
import '07 registro_usuarios/conductorPagePrincipal.dart';
import '07 registro_usuarios/views/screens/registro_EPS.dart';
import '07 registro_usuarios/views/screens/registro_Monitor.dart';
import '07 registro_usuarios/views/screens/registro_conductor.dart';
import '07 registro_usuarios/views/screens/registro_usuarios_menu.dart';
import '07 registro_usuarios/views/screens/registro_vehiculos.dart';
import '08 registro_ruta/add_Validación.dart';
import '08 registro_ruta/add_Vehiculos.dart';
import '08 registro_ruta/add_parada.dart';
import '08 registro_ruta/reg_parada.dart';
import '08 registro_ruta/reg_tutores.dart';
import '08 registro_ruta/registro_rutas.dart';
import '08 registro_ruta/views/screens/1 detalle_rutas_global.dart';
import '08 registro_ruta/views/screens/2 registro_rutas_menu.dart';
import '1 intro/views/screens/intro_slider_atw.dart';
import '1 intro/views/screens/permition_gps.dart';
import '1 intro/views/screens/splash_atw.dart';
import '10 Perfil_usuario/views/screens/perfil_user.dart';
import '2 home_page_map/views/screens/home_conductor.dart';
import '2 home_page_map/views/widgets/lista_previo_autorizacion.dart';
import 'pages/loginPageUi/loginAtg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: UserBloc(),
      child: MaterialApp(
        title: 'Empresa Administradora del Servicio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(hexColor('#3A4A64')),
          fontFamily: 'Poppins-Medium',
        ),
 /*        home:
            //LandingPage2(auth: new Auth()),
            LandingPage(), */
        initialRoute: 'ingreso',
        routes: {
          /*  'registre': (BuildContext context) {
        var state =Provider.of<LoginState>(context);
        if (state.isloggedIn()) {
        return IntroPageAtw();
        } else {
        return RegistreAtw();
        }
        }, */
          //home
          'homeConductor': (_) => HomeAtwConductor(),
          'splash': (_) => SplashAtw(),
          'intro': (_) => IntroPageAtw(),
          'permition': (_) => PermitionGpsUi(),
          'perfil': (_) => PerfilUserUi(),

          // Ingreso
          'ingreso': (_) => LoginSignUpPage2(),
          'recuperarClave': (_) => ReestablecerPassword(),

          'login': (_) => LoginAtw(),
          'prueba': (_) => Prueba(),
          // Gestion del usuarios servicio
          'servicesMonitor': (_) => MonitorServicesMenu(),
          'registroMonitor': (_) => ResgistroMonitor(),
          'registroEps': (_) => ResgistroEps(),
          'registroConductor': (_) => ResgistroConductor(),
          'registroVehículos': (_) => ResgistroVehiculos(),
          'principalConductor': (_) => PrincipalPageConductor(),
          //Gestion de rutas
          'detalleRutas': (_) => DetalleRutasGlobal(),
          'menuRegRutas': (_) => GestionRutasMenu(),
          'regRutas': (_) => RegistroRutas(),
          'addParadas': (_) => AddParada(),
          'regParadas': (_) => RegistrodeParadas(),
          'regTutores': (_) => ResgistroTutores(),
          'addValidacion': (_) => AddValidacionParada(),
          'addVehiculos': (_) => AddVehiculos(),
          //Notificaciones
        //  'notificaciones': (_) => Notificaciones(),
        //Salidas autorización
          'listaEstudiantes': (_) => ListaPreviaAutorizacion(),
        },
      ),
    );
  }
}

/* 
void main() {
  runApp(ChangeNotifierProvider<LoginState>(
    create: (BuildContext context) => LoginState(),
    child: new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(hexColor('#5CC4B8')),
        fontFamily: 'Poppins-Medium',
      ),
      //home: new MyApp(),
      initialRoute: 'ingreso',
      routes: {
        /*  'registre': (BuildContext context) {
        var state =Provider.of<LoginState>(context);
        if (state.isloggedIn()) {
        return IntroPageAtw();
        } else {
        return RegistreAtw();
        }
        }, */
      //home
        'homeConductor': (_) => HomeAtwConductor(),
        'splash': (_) => SplashAtw(),
        'intro': (_) => IntroPageAtw(),
        'permition': (_) => PermitionGpsUi(),
        
        // Ingreso
        'ingreso': (_) => LoginSignUpPage2(),
        'recuperarClave': (_) => ReestablecerPassword(),

        'login': (_) => LoginAtw(),
        'prueba': (_) => Prueba(),
        // Gestion del usuarios servicio
        'servicesMonitor': (_) => MonitorServicesMenu(),
        'registroMonitor': (_) => ResgistroMonitor(),
        'registroEps': (_) => ResgistroEps(),
        'registroConductor': (_) => ResgistroConductor(),
        'registroVehículos': (_) => ResgistroVehiculos(),
        'principalConductor': (_) => PrincipalPageConductor(),
        //Gestion de rutas
        'detalleRutas': (_) => DetalleRutasGlobal(),
        'menuRegRutas': (_) => GestionRutasMenu(),
        'regRutas': (_) => RegistroRutas(),
        'addParadas': (_) => AddParada(),
        'regParadas': (_) => RegistrodeParadas(),
        'regTutores': (_) => ResgistroTutores(),
        'addValidacion': (_) => AddValidacionParada(),
        'addVehiculos': (_) => AddVehiculos(),
        //Notificaciones
        'notificaciones': (_) => Notificaciones(),
      },
    ),
  ));
}


 */
