
import 'package:antawaschool/utils/hexaColor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Velocimetro extends StatelessWidget {
  const Velocimetro({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: SizedBox()),
        Center(
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                    color: Colors.white38,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'Salida',
                                style: TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '15:00',
                                style: TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  fontSize: 30,
                                  letterSpacing: 3,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Ene-27',
                                    style: TextStyle(
                                      fontFamily:
                                          'Poppins-Medium',
                                      fontSize: 14,
                                      fontWeight:
                                          FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //Expanded(child: SizedBox(width: 1,)),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Ruta: 6',
                                style: TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '40 km/h',
                                style: TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 23,
                                child: Icon(
                                  FontAwesomeIcons
                                      .tachometerAlt,
                                  color: Color(
                                      hexColor('#61B4E5')),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Llegada',
                                style: TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '16:00',
                                style: TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  fontSize: 30,
                                  letterSpacing: 3,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Ene-27',
                                    style: TextStyle(
                                      fontFamily:
                                          'Poppins-Medium',
                                      fontSize: 14,
                                      fontWeight:
                                          FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }
}
