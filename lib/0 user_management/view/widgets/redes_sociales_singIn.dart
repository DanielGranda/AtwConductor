
import 'package:antawaschool/pages/RegistrePageAppUi/socialIcons.dart';
import 'package:antawaschool/utils/hexaColor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RedesSocialesSignIn extends StatelessWidget {
  const RedesSocialesSignIn({
    Key key,
    @required this.colorField,
  }) : super(key: key);

  final Color colorField;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
    
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
    color: Color(hexColor('#5CC4B8')).withOpacity(0.5),
    height: 2,
    width: 60,
                ),
                Text("Social Login",
      style: TextStyle(
          color: colorField,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
          fontFamily: "Poppins-Medium")),
                Container(
    color: Color(hexColor('#5CC4B8')).withOpacity(0.5),
    height: 2,
    width: 60,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*      SocialIcon(
                  colors: [
                    Color(0xFF102397),
                    Color(0xFF187adf),
                    Color(0xFF00eaf8),
                  ],
                  iconData: FontAwesome.facebook_f,
                  onPressed: () {},
                ), */
            SocialIcon(
              colors: [
                Color(0xFFff4f38),
                Color(0xFFff355d),
              ],
              iconData: FontAwesomeIcons.google,
              onPressed: () {
                //Provider.of<LoginState>(context,).login();
              },
            ),
            /*  SocialIcon(
              colors: [
                Color(0xFF17ead9),
                Color(0xFF6078ea),
              ],
              iconData: FontAwesome.linkedin,
              onPressed: () {},
            ),
            SocialIcon(
              colors: [
                Color(0xFF00c6fb),
                Color(0xFF005bea),
              ],
              iconData: FontAwesome.whatsapp,
              onPressed: () {},
            ) */
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
