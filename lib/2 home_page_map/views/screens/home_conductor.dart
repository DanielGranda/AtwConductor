import 'dart:convert';
import 'dart:typed_data';
import 'dart:async';
import "dart:ui" as ui;
import 'dart:math' as math;
import 'package:antawaschool/2%20home_page_map/views/widgets/menu_lateral.dart';
import 'package:antawaschool/2%20home_page_map/views/widgets/slider_inic_ruta.dart';
import 'package:antawaschool/2%20home_page_map/views/widgets/tabItem.dart';
import 'package:antawaschool/3%20monitoreo/view/screen/informacion_ruta.dart';
import 'package:antawaschool/4%20notificaciones/views/screens/notificaciones_ruta.dart';
import 'package:antawaschool/5%20quejas_conductor/views/screen/Quejas.dart';
import 'package:antawaschool/6%20novedades_conductor/views/screen/novedades_trayecto.dart';
import 'package:antawaschool/utils/circularBotton.dart';
import 'package:antawaschool/utils/hexaColor.dart';
import 'package:antawaschool/utils/stylesMaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vibration/vibration.dart';

class HomeAtwConductor extends StatefulWidget {
  HomeAtwConductor({Key key, this.title, void Function() onSignOut})
      : super(key: key);
  final String title;

  @override
  _HomeAtwConductorState createState() => _HomeAtwConductorState();
}

class _HomeAtwConductorState extends State<HomeAtwConductor> {
  int selectedPos = 0;

  List<TabItem> tabItems = List.of([
    new TabItem('assets/icon/IcoMapaR.png', "Monitoreo", Colors.blue,
        labelStyle: TextStyle(
          fontFamily: 'Poppins-Medium',
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color(hexColor('#5CC4B8')),
        )),
    new TabItem(
        'assets/icon/NotificacionesIco.png', "Notificaciones", Colors.blue,
        labelStyle: TextStyle(
          fontFamily: 'Poppins-Medium',
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color(hexColor('#5CC4B8')),
        )),
    new TabItem('assets/icon/QuejasIco.png', "Quejas", Colors.blue,
        labelStyle: TextStyle(
          fontFamily: 'Poppins-Medium',
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color(hexColor('#5CC4B8')),
        )),
    new TabItem('assets/icon/novedades.png', "Novedades", Colors.blue,
        labelStyle: TextStyle(
          fontFamily: 'Poppins-Medium',
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color(hexColor('#5CC4B8')),
        )),
  ]);

  CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    //_loadCarPin();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    _navigationController = new CircularBottomNavigationController(selectedPos);
  }

  GoogleMapController _mapController;
  Uint8List _carPin;
  Marker _myMarker;
  StreamSubscription<Position> _positionStream;
  Map<MarkerId, Marker> _markers = Map();
  Map<PolylineId, Polyline> _polylines = Map();
  List<LatLng> _myRoute = List();
  Position _lastPosition;

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  _loadCarPin() async {
    final byteData = await rootBundle.load('assets/icon/busAtw.png');
    _carPin = byteData.buffer.asUint8List();

    final codec = await ui.instantiateImageCodec(_carPin, targetWidth: 80);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    _carPin = (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
    _startTracking();
  }

  _startTracking() {
    final geolocator = Geolocator();
    final locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 5);

    _positionStream =
        geolocator.getPositionStream(locationOptions).listen(_onLocationUpdate);
  }

  _onLocationUpdate(Position position) {
    if (position != null) {
      final myPosition = LatLng(position.latitude, position.longitude);
      _myRoute.add(myPosition);

      final myPolyline = Polyline(
          polylineId: PolylineId("me"),
          points: _myRoute,
          color: Colors.cyanAccent,
          width: 8);

      if (_myMarker == null) {
        final markerId = MarkerId("me");
        final bitmap = BitmapDescriptor.fromBytes(_carPin);
        _myMarker = Marker(
            markerId: markerId,
            position: myPosition,
            icon: bitmap,
            rotation: 0,
            anchor: Offset(0.5, 0.5));
      } else {
        final rotation = _getMyBearing(_lastPosition, position);
        _myMarker = _myMarker.copyWith(
            positionParam: myPosition, rotationParam: rotation);
      }

      setState(() {
        _markers[_myMarker.markerId] = _myMarker;
        _polylines[myPolyline.polylineId] = myPolyline;
      });
      _lastPosition = position;
      _moveMarkerMap(position);
    }
  }

  /* Rotador de Pin */
  double _getMyBearing(Position lastPosition, Position currentPosition) {
    final dx = math.cos(math.pi / 180 * lastPosition.latitude) *
        (currentPosition.longitude - lastPosition.longitude);
    final dy = currentPosition.latitude - lastPosition.latitude;
    final angle = math.atan2(dy, dx);
    return 90 - angle * 180 / math.pi;
  }

  @override
  void dispose() {
    if (_positionStream != null) {
      _positionStream.cancel();
      _positionStream = null;
    }
    _navigationController.dispose();
    super.dispose();
  }

  _moveMarkerMap(Position position) {
    try {
      final cameraUpdate =
          CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude));
      _mapController.animateCamera(cameraUpdate);
    } catch (e) {
      print(e.toString());
    }
  }

  _updateMarkerPosition(MarkerId markerId, LatLng p) {
    print("newPosition");
    _markers[markerId] = _markers[markerId].copyWith(positionParam: p);
  }

  _onTapMArker(LatLng p) {
    final id = "${_markers.length}";
    final marketId = MarkerId(id);
    final infoWindow = InfoWindow(
        title: "Estudiante: $id", snippet: "${p.latitude}, ${p.longitude}");
    final marker = Marker(
        markerId: marketId,
        position: p,
        infoWindow: infoWindow,
        anchor: Offset(0.5, 1),
        onTap: () {
          callEstudents();
          print("clicked info$id");
        });
    setState(() {
      _markers[marketId] = marker;
    });
    print("p:${p.latitude}, ${p.longitude} ");
  }

  Future callEstudents() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Estudiante:'),
            content: Text(''),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Icon(Icons.perm_contact_calendar),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text('Daniel Granda'),
                  IconButton(
                    icon: Icon(Icons.call),
                    onPressed: () {},
                  ),
                  /*   IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () {},
                  ) */
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      appBar: cabecera(),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: Set.of(_markers.values),
            polylines: Set.of(_polylines.values),
            onTap: _onTapMArker,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              _mapController
                  .setMapStyle(jsonEncode(mapStyle4)); /* Escoger 1-2-3 */
            },
          ),
          Column(
            children: <Widget>[
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                        radius: 23,
                                        backgroundImage: AssetImage(
                                            'assets/icon/botonPanico.png'),
                                        child: Text('')),
                                    Text(
                                      'Botón de Pánico',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                backgroundColor:
                                    Color(hexColor('#E86A87')).withOpacity(0.5),
                                elevation: 10,
                                content: Text(
                                    "Usted está apunto de activar el botón de pánico. ¿Desea continuar?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white70,
                                    )),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      'Cancelar',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text(
                                      'Aceptar',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      if (await Vibration.hasVibrator()) {
                                        Vibration.vibrate();
                                      }
                                    },
                                  ),
                                ],
                              ));
                    },
                    child: CircleAvatar(
                        radius: 23,
                        backgroundImage:
                            AssetImage('assets/icon/botonPanico.png'),
                        child: Text('')),
                  ),
                  SizedBox(width: 8),
                ],
              ),
              SizedBox(height: 280),
              SliderButtonRutaInic(),
            ],
          ),
          Padding(
            child: bodyContainer(),
            padding: EdgeInsets.only(bottom: 60),
          ),
          Align(alignment: Alignment.bottomCenter, child: bottomNav()),
        ],
      ),
    );
  }

  AppBar cabecera() {
    return AppBar(
        centerTitle: true,
        backgroundColor: Color(hexColor('#5CC4B8')),
        title: ListTile(
          trailing: CircleAvatar(
            backgroundImage: AssetImage('assets/marce.png'),
          ),
          title: Text(
            'Granda Jaramillo Luis M...',
            style: TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            'Monitor de Ruta',
            style: TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ));
  }

  Widget bodyContainer() {
    //Color selectedColor = tabItems[selectedPos].circleColor;
    //String slogan;
    Widget body;
    switch (selectedPos) {
      case 0:
        body = InformacionRutas();
        break;
      case 1:
        body = NotificacionesRuta();
        break;
      case 2:
        body = Quejas();
        break;
      case 3:
        body = NovedadesTrayecto();
        break;
    }

    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        //color: selectedColor,
        child: Center(
            child: Container(
          child: body,
        )),
      ),
      onTap: () {
        if (_navigationController.value == tabItems.length - 1) {
          _navigationController.value = 0;
        } else {
          _navigationController.value++;
        }
      },
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      barHeight: 60,
      barBackgroundColor: Colors.white,
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int selectedPos) {
        setState(() {
          this.selectedPos = selectedPos;
          //print(_navigationController.value);
        });
      },
    );
  }
}
