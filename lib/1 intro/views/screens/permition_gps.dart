import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermitionGpsUi extends StatefulWidget {
  PermitionGpsUi({Key key}) : super(key: key);

  @override
  _PermitionGpsUiState createState() => _PermitionGpsUiState();
}

class _PermitionGpsUiState extends State<PermitionGpsUi>
    with WidgetsBindingObserver {
  PermissionHandler _permissionHandler = PermissionHandler();
  var _isChecking = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _check();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state=$state');
    if (state ==  AppLifecycleState.resumed  ) {
      _check();
    } 
  }

  _check() async {
    final status = await _permissionHandler
        .checkPermissionStatus(PermissionGroup.locationWhenInUse);
    if (status == PermissionStatus.granted) {
      Navigator.pushReplacementNamed(context, 'mapAttw');
    } else {
      setState(() {
        _isChecking = false;
      });
    }
  }

  _request() async {
    final result = await _permissionHandler
        .requestPermissions([PermissionGroup.locationWhenInUse]);
    if (result.containsKey(PermissionGroup.locationWhenInUse)) {
      final status = result[PermissionGroup.locationWhenInUse];
      if (status == PermissionStatus.granted) {
        Navigator.pushReplacementNamed(context, 'mapAttw');
      } else if (status == PermissionStatus.denied) {
        final result = await _permissionHandler.openAppSettings();
        print('result $result');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.only(top: 10.0),
          decoration: BoxDecoration(
              image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.colorBurn),
            image: AssetImage("assets/backGround/backGroundAtw.png"),
            fit: BoxFit.contain,
          )),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          child: _isChecking
              ? Center( child: CupertinoActivityIndicator(radius: 15),)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    InkWell(
                      child: Container(
                        width: 150,
                        height: 60,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                            borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF6078ea).withOpacity(.3),
                                  offset: Offset(0.0, 8.0),
                                  blurRadius: 8.0)
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            child: Center(
                              child: Text("PERMISOS",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins-Bold",
                                      fontSize: 18,
                                      letterSpacing: 1.0)),
                            ),
                            onTap: _request,
                          ),
                        ),
                      ),
                    ),
                /*     IconButton(
                      icon: Icon(FontAwesome.map_marker),
                      onPressed: _request,
                    ) */
                  ],
                ),
        ),
      ],
    ));
  }
}
