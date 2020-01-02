import 'package:antawaschool/estatesApp/socialLoginState.dart';
import 'package:antawaschool/utils/hexaColor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class MonitorServices extends StatefulWidget {
  MonitorServices({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new HomeWidgetState();
  }
}

class HomeWidgetState extends State<MonitorServices>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    new Tab(text: "Registro de Monitores"),
    new Tab(text: "Registro Conductores"),
    new Tab(text: "Registro de Vehículos"),
    new Tab(text: "Vinculación a Vehículos"),
    new Tab(text: "Vinculación a Empresa")
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(
            FontAwesome.chevron_circle_left,
            color: Color(hexColor('#61B4E5')),
            size: 30,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'mapAttw');
          },
        ),
        backgroundColor: Colors.white,
        title: Text('Configuración del Servicio'.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(hexColor('#5CC4B8')),
            )),
        bottom: new TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: new BubbleTabIndicator(
            indicatorHeight: 25.0,
            indicatorColor: Color(hexColor('#F6C34F')),
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          tabs: tabs,
          controller: _tabController,
        ),
      ),
      body: new TabBarView(controller: _tabController, children: <Widget>[
        RegistreMonitores(),
        Text(''),
        Text(''),
        Text(''),
        Text(''),
      ]),
    );
  }
}

class RegistreMonitores extends StatelessWidget {
  const RegistreMonitores({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<LoginState>(context, listen: false).currentUser();
    return Scaffold(
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
          StreamBuilder(
            stream: Firestore.instance.collection('user').document(user.uid)
                                  .collection('registroMonitorEps').snapshots(),
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
                    leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/imgEps/icoConductor.png') ,
                    ),
                    title: Row(
                      children: <Widget>[
                        Text(data['apellidos'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        SizedBox(width:3,),
                        Text(data['nombre'], style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    subtitle: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                 Row(
                                   children: <Widget>[
                                     Icon(FontAwesome.id_badge, color: Colors.grey,),
                                     Text(data['cedula']),
                                   ],
                                 ),
                                 SizedBox(height: 5,),
                                 Row(
                                   children: <Widget>[
                                     Icon(FontAwesome.phone, color: Colors.grey,),
                                     Text(data['celular']),
                                   ],
                                 ),
                              ],
                            ),
                            Expanded(child: SizedBox()),
                             Icon(FontAwesome.edit, color: Color(hexColor('#F6C34F')),),
                                    SizedBox(width: 15,),
                             Icon(FontAwesome.trash, color: Color(hexColor('#E86A87')),),
                          ],
                        ),
                        Divider(color: Color(hexColor('#3A4A64')),thickness: 3,)
                      ],
                    ),
               
                  );
                },
              );
            },
          ),
          /*    StreamBuilder<QuerySnapshot>(
            
            stream:
                Firestore.instance
                                  .collection('user')
                                  .document(user.uid)
                                  .collection('registroMonitorEps')
                                  
        .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text('Loading...');
                default:
                  return new ListView(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return new ListTile(
                        title: new Text(document['nombre']),
                       // subtitle: new Text(document['apellidos']),
                      );
                    }).toList(),
                  );
                  
              }
            },
          ), */
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(hexColor('#3A4A64')),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'registroMonitor');
        },
      ),
    );
  }
}
