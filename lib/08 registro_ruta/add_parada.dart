import 'package:antawaschool/utils/hexaColor.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';


class AddParada extends StatefulWidget {
  AddParada({Key key}) : super(key: key);

  @override
  _AddParadaState createState() => _AddParadaState();
}

class _AddParadaState extends State<AddParada> {
  @override
  Widget build(BuildContext context) {
     //var user = Provider.of<LoginState>(context, listen: false).currentUser();
    return  Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
                image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.dstIn),
              image: AssetImage("assets/backGround/FondoBlancoATW.png"),
              fit: BoxFit.contain,
            )),
          ),

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(hexColor('#3A4A64')),
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.pushNamed(context, 'regParadas');
          if (await Vibration.hasVibrator()) {
    Vibration.vibrate();
}
        },
      ),
    );
  }
}