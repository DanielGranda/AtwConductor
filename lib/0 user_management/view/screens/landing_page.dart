import 'package:antawaschool/0%20user_management/bloc/bloc_user.dart';
import 'package:antawaschool/0%20user_management/services/auth_services_firebase.dart';
import 'package:antawaschool/0%20user_management/view/screens/landing_page2.dart';
import 'package:antawaschool/2%20home_page_map/views/screens/home_conductor.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import 'ingreso2.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
    String _userId = "";
    final userBloc = BlocProvider.of<UserBloc>(context);


    
    void _onLoggedIn() {
      userBloc.getCurrentUser2().then((user) {
        setState(() {
          _userId = user.uid.toString();
        });
      });
      setState(() {
        authStatus = AuthStatus.LOGGED_IN;
      });
    }

    return StreamBuilder(
      stream: userBloc.onAuthStateChanged(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;

          if (user == null) {
            return
                //IngresoAtwAdmin();
                LoginSignUpPage2(onSignedIn: _onLoggedIn);
          }
          print('Sesión iniciada con:$user');
          return HomeAtwConductor();
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
