import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "dart:ui" as ui;
import 'utilsPageMaps/stylesMaps.dart';

class MapsPrueba extends StatefulWidget {
  MapsPrueba({Key key}) : super(key: key);

  @override
  _MapsPruebaState createState() => _MapsPruebaState();
}

class _MapsPruebaState extends State<MapsPrueba> {
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

  @override
  void initState() {
    super.initState();
    _loadCarPin();
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
    return Container(
      width: double.infinity,
      height: double.infinity,
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
}
