import 'package:antawaschool/4%20notificaciones/views/widgets/tarjeta_notificaciones.dart';
import 'package:antawaschool/utils/hexaColor.dart';
import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';

class NotificacionesRuta extends StatefulWidget {
  NotificacionesRuta({Key key}) : super(key: key);

  @override
  _NotificacionesRutaState createState() => _NotificacionesRutaState();
}

class _NotificacionesRutaState extends State<NotificacionesRuta>
    with SingleTickerProviderStateMixin {
  RubberAnimationController _controller;

  double _dampingValue = DampingRatio.HIGH_BOUNCY;
  //double _stiffnessValue = Stiffness.HIGH;

  @override
  void initState() {
    _controller = RubberAnimationController(
        dismissable: true,
        vsync: this,
        lowerBoundValue: AnimationControllerValue(pixel: 50),
        upperBoundValue: AnimationControllerValue(percentage: 0.8),
        springDescription: SpringDescription.withDampingRatio(
            mass: 1, stiffness: Stiffness.HIGH, ratio: _dampingValue),
        duration: Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            child: RubberBottomSheet(
              onTap: () {},
              lowerLayer: _getLowerLayer(),
              upperLayer: _getUpperLayer(),
              animationController: _controller,
            ),
          ),
        ),
      ],
    );
  }

  Widget _getLowerLayer() {
    return Container(
      height: 2,
      decoration: BoxDecoration(color: Colors.transparent),
    );
  }

  Widget _getUpperLayer() {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(80), topRight: Radius.circular(5)),
          child: Container(
            decoration: BoxDecoration(
                color: Color(hexColor('#5CC4B8')).withOpacity(0.9)),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white70,
                  size: 26,
                ),
              ],
            ),
            SizedBox( width: 10),
            Text(
              'Notificaciones',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Poppins-Medium',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                        IconButton(
                          highlightColor: Colors.white,
                        icon: Icon(Icons.filter_list,
                            color: Colors.white),
                        onPressed: () {},
                      ),
                    Divider(
                      color: Colors.white,
                    ),
                 
                    SizedBox(height: 20),
                    TarjetaNotificaciones(),
                  ],
                ),
              ),
            )
            /*     SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              SizedBox(height: 50,),
              Text('Niño para realizar el monitoreo', )
            ],
          ),
        ) */
          ],
        )
      ],
    );
  }
}
