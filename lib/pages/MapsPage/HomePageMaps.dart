import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:antawaschool/estatesApp/socialLoginState.dart';
import 'package:antawaschool/utils/hexaColor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:antawaschool/pages/homePage/util/utilHome.dart';
import "dart:ui" as ui;

import 'utilsPageMaps/stylesMaps.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;

class HomePageMaps extends StatefulWidget {
  HomePageMaps({Key key}) : super(key: key);

  @override
  _HomePageMapsState createState() => _HomePageMapsState();
}

class _HomePageMapsState extends State<HomePageMaps> {
  GoogleMapController _mapController;
  Uint8List _carPin;
  Marker _myMarker;

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  StreamSubscription<Position> _positionStream;
  Map<MarkerId, Marker> _markers = Map();
  Map<PolylineId, Polyline> _polylines = Map();
  List<LatLng> _myRoute = List();
  Position _lastPosition;

  SheetController controller;
  GlobalKey headerKey;
  GlobalKey footerKey;

  double headerHeight = 0;
  double footerHeight = 0;

  final textStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'sans-serif-medium',
    fontSize: 15,
  );

  final mapsBlue = Color(0xFF4185F3);
  SheetState state;
  bool get isExpanded => state?.isExpanded ?? false;
  bool get isCollapsed => state?.isCollapsed ?? true;
  double get progress => state?.progress ?? 0.0;

  @override
  void initState() {
    super.initState();
    _loadCarPin();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    headerKey = GlobalKey();
    footerKey = GlobalKey();
    controller = SheetController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox header = headerKey?.currentContext?.findRenderObject();
      final RenderBox footer = footerKey?.currentContext?.findRenderObject();
      if (header != null && footer != null) {
        headerHeight = header.size.height;
        footerHeight = footer.size.height;
        setState(() {});
      }
    });
  }

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
    super.dispose();
  }

  _moveMarkerMap(Position position) {
    final cameraUpdate =
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude));
    _mapController.animateCamera(cameraUpdate);
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
                  IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () {},
                  )
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //buildMap(),
          /*    SafeArea(
            child: StreamBuilder(
              stream: Firestore.instance.collection('tareas').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<DocumentSnapshot> docs = snapshot.data.documents;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> data = docs[index].data;
                    return ListTile(
                      title: Text(data['Apellido']),
                      subtitle: Text(data['nombre']),
                    );
                  },
                );
              },
            ),
          ), */

          SafeArea(child: mapa()),
          botonOpciones(context),
          cajaInferior(),
        ],
      ),
    );
  }

  Container mapa() {
    return Container(
      width: double.infinity,
      height: 500,
      child: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: Set.of(_markers.values),
        polylines: Set.of(_polylines.values),
        onTap: _onTapMArker,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
          _mapController.setMapStyle(jsonEncode(mapStyle1)); /* Escoger 1-2-3 */
        },
      ),
    );
  }

  Align botonOpciones(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            0, MediaQuery.of(context).padding.top + 5, 19, 0),
        child: FloatingActionButton(
          mini: true,
          child: Icon(
            FontAwesome.ellipsis_v,
            color: Colors.black38,
          ),
          backgroundColor: Colors.white.withOpacity(0.7),
          onPressed: () {
            contenidoOpciones(context);
          },
        ),
      ),
    );
  }

  void contenidoOpciones(BuildContext context) {
    showSlidingBottomSheet(
      context,
      snapSpec: const SnapSpec(
        snap: false,
        snappings: const [0.4, 0.7, 1.0],
      ),
      scrollSpec: ScrollSpec.bouncingScroll(),
      color: Colors.white,
      builder: (context, state) {
        return Container(
            height: 1000,
            child: Material(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(FontAwesome.address_card),
                    title: Text('Perfil de usuario'),
                    onTap: (){
                            Navigator.pushNamed(context,  'registroMonitor');
                    },
                  ),
                  Divider(),
                      ListTile(
                    leading: Icon(FontAwesome.cog, color:Color(hexColor('#61B4E5'))),
                    title: Text('Configuración del Servicio'),
                    onTap: (){
                      Navigator.pushNamed(context,  'servicesMonitor');
                    },
                  ),
                  Divider(),
                  ListTile(
                      leading: Icon(FontAwesome.bell),
                      title: Text('Notificaciones'),
                      trailing: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text('2'),
                      )),
                  Divider(),
                  ListTile(
                    leading: Icon(FontAwesome.clipboard),
                    title: Text('Novedades en el trayecto'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(FontAwesome.headphones),
                    title: Text('Gestión de Quejas'),
                  ),
                  Divider(),
                      ListTile(
            trailing: Icon(
              Icons.power_settings_new,
              color: Colors.redAccent.withOpacity(0.4),
            ),
            title: Text( 'Cerrar Sesión', style: TextStyle(color: Colors.grey)),
            onTap: () {
              Provider.of<LoginState>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, 'registre');
            },
          ),
                ],
              ),
            )

            /* Center(
            child: Text(
              'This is a bottom sheet dialog!',
              style: textStyle,
            ),
          ), */
            );
      },
    );
  }

  Widget cajaInferior() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.biggest.height;

        return SlidingSheet(
          closeOnBackdropTap: true,
          controller: controller,
          color: Colors.white,
          elevation: 16,
          maxWidth: 500,
          cornerRadius: 16 * (1 - fInRange(0.7, 1.0, progress)),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 3,
          ),
          snapSpec: SnapSpec(
            snap: true,
            positioning: SnapPositioning.pixelOffset,
            snappings: [
              headerHeight > 0 ? headerHeight + footerHeight : 140,
              height * 0.3,
              double.infinity,
            ],
            onSnap: (state, snap) {
              //print('Snapped to $snap');
            },
          ),
          scrollSpec: ScrollSpec.bouncingScroll(),
          listener: (state) {
            this.state = state;
            setState(() {});
          },
          headerBuilder: buildHeader,
          footerBuilder: buildFooter,
          builder: buildChild,
        );
      },
    );
  }

  Widget buildHeader(BuildContext context, SheetState state) {
    return CustomContainer(
      key: headerKey,
      animate: true,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      elevation: !state.isAtTop ? 4 : 0,
      shadowColor: Colors.black12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
              height: 2 +
                  (MediaQuery.of(context).padding.top *
                      fInRange(.7, 1.0, progress))),
          Align(
            alignment: Alignment.topCenter,
            child: CustomContainer(
              width: 16,
              height: 4,
              borderRadius: 2,
              color: Colors.grey
                  .withOpacity(.5 * (1 - fInRange(0.7, 1.0, progress))),
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: <Widget>[
              Text(
                '0h 36m',
                style: textStyle.copyWith(
                  color: Color(0xFFF0BA64),
                  fontSize: 22,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '(De la Unidad Eductiva)',
                style: textStyle.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 21,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: <Widget>[
              Text(
                '5/10',
                style: textStyle.copyWith(
                  color: Color(0xFFF0BA64),
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Estudiantes abordo',
                style: textStyle.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget buildFooter(BuildContext context, SheetState state) {
    Widget button(Icon icon, Text text, VoidCallback onTap,
        {BorderSide border, Color color}) {
      final child = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          icon,
          SizedBox(width: 8),
          text,
        ],
      );

      final shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      );

      return border == null
          ? RaisedButton(
              color: color,
              onPressed: onTap,
              elevation: 2,
              child: child,
              shape: shape,
            )
          : OutlineButton(
              color: color,
              onPressed: onTap,
              child: child,
              borderSide: border,
              shape: shape,
            );
    }

    return CustomContainer(
      key: footerKey,
      animate: true,
      elevation: !isCollapsed && !state.isAtBottom ? 4 : 0,
      shadowDirection: ShadowDirection.top,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      shadowColor: Colors.black12,
      child: Row(
        children: <Widget>[
          button(
            Icon(
              Icons.navigation,
              color: Colors.white,
            ),
            Text(
              'Detener',
              style: textStyle.copyWith(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            () async {
              await controller.hide();
              Future.delayed(const Duration(milliseconds: 1500), () {
                controller.show();
              });
            },
            color: mapsBlue,
          ),
          SizedBox(width: 8),
          button(
            Icon(
              !isExpanded ? Icons.list : Icons.map,
              color: mapsBlue,
            ),
            Text(
              !isExpanded ? 'Estudiantes' : 'Ver mapa',
              style: textStyle.copyWith(
                fontSize: 15,
              ),
            ),
            !isExpanded ? () => controller.scrollTo(230) : controller.collapse,
            color: Colors.white,
            border: BorderSide(
              color: Colors.grey.shade400,
              width: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChild(BuildContext context, SheetState state) {
    final divider = Container(
      height: 1,
      color: Colors.grey.shade300,
    );

    final titleStyle = textStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    final padding = const EdgeInsets.symmetric(horizontal: 16);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 32),
        divider,
        SizedBox(height: 32),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: padding,
              child: Text(
                'Estudiante por Abordar',
                style: prefix0.TextStyle(
                    color: Colors.orange.withOpacity(0.7),
                    fontSize: 16,
                    fontWeight: prefix0.FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            prefix0.ListTile(
              leading: prefix0.CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: prefix0.AssetImage("assets/daniel.png"),
              ),
              title: Row(
                children: <Widget>[
                  prefix0.Text(
                    'Victor Daniel Granda P.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 15,
                        fontWeight: prefix0.FontWeight.bold),
                  ),
                  prefix0.Expanded(
                    child: prefix0.SizedBox(
                      width: 20,
                    ),
                  ),
                  prefix0.Icon(
                    FontAwesome.whatsapp,
                    color: Colors.blueGrey.withOpacity(0.7),
                  ),
                  prefix0.SizedBox(
                    width: 20,
                  ),
                  prefix0.Icon(
                    FontAwesome.phone,
                    color: Colors.blueGrey.withOpacity(0.7),
                  ),
                ],
              ),
              subtitle: prefix0.Text('A 10 minutos'),
            ),
            Padding(
              padding: padding,
              child: Text(
                'Estudiantes que Abordaron',
                style: prefix0.TextStyle(
                    color: Colors.green.withOpacity(0.7),
                    fontSize: 16,
                    fontWeight: prefix0.FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            prefix0.ListTile(
              leading: prefix0.CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: prefix0.AssetImage("assets/jose.png"),
              ),
              title: Row(
                children: <Widget>[
                  prefix0.Text(
                    'José Orellana T.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 15,
                        fontWeight: prefix0.FontWeight.bold),
                  ),
                  Expanded(
                    child: prefix0.SizedBox(
                      width: 70,
                    ),
                  ),
                  prefix0.Icon(
                    FontAwesome.whatsapp,
                    color: Colors.blueGrey.withOpacity(0.7),
                  ),
                  prefix0.SizedBox(
                    width: 20,
                  ),
                  prefix0.Icon(
                    FontAwesome.phone,
                    color: Colors.blueGrey.withOpacity(0.7),
                  ),
                ],
              ),
              subtitle: prefix0.Text('A 10 minutos'),
            ),
            prefix0.ListTile(
              leading: prefix0.CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: prefix0.AssetImage("assets/cata.png"),
              ),
              title: Row(
                children: <Widget>[
                  prefix0.Text(
                    'Katherine Estrada V.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 15,
                        fontWeight: prefix0.FontWeight.bold),
                  ),
                  prefix0.Expanded(
                    child: prefix0.SizedBox(
                      width: 40,
                    ),
                  ),
                  prefix0.Icon(
                    FontAwesome.whatsapp,
                    color: Colors.blueGrey.withOpacity(0.7),
                  ),
                  prefix0.SizedBox(
                    width: 20,
                  ),
                  prefix0.Icon(
                    FontAwesome.phone,
                    color: Colors.blueGrey.withOpacity(0.7),
                  ),
                ],
              ),
              subtitle: prefix0.Text('A 10 minutos'),
            ),
            Padding(
              padding: padding,
              child: Text(
                'Estudiante que no abordaron',
                style: prefix0.TextStyle(
                    color: Colors.red.withOpacity(0.7),
                    fontSize: 16,
                    fontWeight: prefix0.FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            prefix0.ListTile(
              leading: prefix0.CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: prefix0.AssetImage("assets/marce.png"),
              ),
              title: Row(
                children: <Widget>[
                  prefix0.Text(
                    'Marcelo Granda J.',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 15,
                        fontWeight: prefix0.FontWeight.bold),
                  ),
                  prefix0.Expanded(
                    child: prefix0.SizedBox(
                      width: 20,
                    ),
                  ),
                  prefix0.Icon(
                    FontAwesome.whatsapp,
                    color: Colors.blueGrey.withOpacity(0.7),
                  ),
                  prefix0.SizedBox(
                    width: 20,
                  ),
                  prefix0.Icon(
                    FontAwesome.phone,
                    color: Colors.blueGrey.withOpacity(0.7),
                  ),
                ],
              ),
              subtitle: prefix0.Text('A 10 minutos'),
            ),
          ],
        ),
        SizedBox(height: 32),
        divider,
        SizedBox(height: 32),
        SizedBox(height: 16),
        SizedBox(height: 32),
      ],
    );
  }

  Widget buildSteps(BuildContext context) {
    final steps = [
      Step('Victor Granda P...', 'a 15 minutos'),
      //Step("José Orellana T...", '5 seconds'),
      /* Step("Run 'flutter packages get' in the terminal.", '4 seconds'),
      Step("Happy coding!", 'Forever'), */
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      itemBuilder: (context, i) {
        final step = steps[i];

        return Padding(
          padding: const EdgeInsets.fromLTRB(56, 16, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                step.instruction,
                style: textStyle.copyWith(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Text(
                    '${step.time}',
                    style: textStyle.copyWith(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                  )
                ],
              ),
              SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget buildChart(BuildContext context) {
    final series = [
      charts.Series<Traffic, String>(
        id: 'traffic',
        data: [
          Traffic(0.5, '14:00'),
          Traffic(0.6, '14:30'),
          Traffic(0.5, '15:00'),
          Traffic(0.7, '15:30'),
          Traffic(0.8, '16:00'),
          Traffic(0.6, '16:30'),
        ],
        colorFn: (traffic, __) {
          if (traffic.time == '14:30')
            return charts.Color.fromHex(code: '#F0BA64');
          return charts.MaterialPalette.gray.shade300;
        },
        domainFn: (Traffic traffic, _) => traffic.time,
        measureFn: (Traffic traffic, _) => traffic.intesity,
      ),
    ];

    return Container(
      height: 128,
      child: charts.BarChart(
        series,
        animate: true,
        domainAxis: charts.OrdinalAxisSpec(
          renderSpec: charts.SmallTickRendererSpec(
            labelStyle: charts.TextStyleSpec(
              fontSize: 12, // size in Pts.
              color: charts.MaterialPalette.gray.shade500,
            ),
          ),
        ),
        defaultRenderer: charts.BarRendererConfig(
          cornerStrategy: const charts.ConstCornerStrategy(5),
        ),
      ),
    );
  }

  Widget buildMap() {}
}

class Step {
  final String instruction;
  final String time;
  Step(
    this.instruction,
    this.time,
  );
}

class Traffic {
  final double intesity;
  final String time;
  Traffic(
    this.intesity,
    this.time,
  );
}
