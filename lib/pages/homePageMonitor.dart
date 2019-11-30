import 'package:extended_navbar_scaffold/extended_navbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class HomePageMonitor extends StatefulWidget {
  HomePageMonitor({Key key}) : super(key: key);

  @override
  _HomePageMonitorState createState() => _HomePageMonitorState();
}

class _HomePageMonitorState extends State<HomePageMonitor> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Text('data'),
        Scaffold(),
        ExtendedNavigationBarScaffold(
          body: Container(
            color: Colors.green,
          ),
          elevation: 0,
          //floatingAppBar: true,
          /*  appBar: AppBar(

            actions: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.apps,color: Colors.black,),
                  Text('...'),
                  SizedBox(height: 80,)
                ],
              )
            ],
            shape: kAppbarShape,
            leading: IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.black,
                size:25,
              ),
              onPressed: () {},
            ),
            title: Text(
              'Extended Scaffold Example',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ), */
          navBarColor: Colors.white,
          navBarIconColor: Colors.black,
          moreButtons: [
            MoreButtonModel(
              icon: MaterialCommunityIcons.wallet,
              label: 'Wallet',
              onTap: () {},
            ),
            MoreButtonModel(
              icon: MaterialCommunityIcons.parking,
              label: 'My Bookings',
              onTap: () {},
            ),
            MoreButtonModel(
              icon: MaterialCommunityIcons.car_multiple,
              label: 'My Cars',
              onTap: () {},
            ),
            MoreButtonModel(
              icon: FontAwesome.book,
              label: 'Transactions',
              onTap: () {},
            ),
            MoreButtonModel(
              icon: MaterialCommunityIcons.home_map_marker,
              label: 'Offer Parking',
              onTap: () {},
            ),
            MoreButtonModel(
              icon: FontAwesome5Regular.user_circle,
              label: 'Profile',
              onTap: () {},
            ),
            null,
            MoreButtonModel(
              icon: Icons.settings,
              label: 'Settings',
              onTap: () {},
            ),
            null,
          ],
          searchWidget: Container(
            height: 150,
            color: Colors.redAccent,
          ),
          // onTap: (button) {},
          // currentBottomBarCenterPercent: (currentBottomBarParallexPercent) {},
          // currentBottomBarMorePercent: (currentBottomBarMorePercent) {},
          // currentBottomBarSearchPercent: (currentBottomBarSearchPercent) {},
          parallexCardPageTransformer: PageTransformer(
            pageViewBuilder: (context, visibilityResolver) {
              return PageView.builder(

                controller: PageController(viewportFraction: 1),
                itemCount: parallaxCardItemsList.length,
                itemBuilder: (context, index) {
                  final item = parallaxCardItemsList[index];
                  final pageVisibility =
                      visibilityResolver.resolvePageVisibility(index);
                  return ParallaxCardsWidget(
                    item: item,
                    pageVisibility: pageVisibility,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  final parallaxCardItemsList = <ParallaxCardItem>[
    /*  ParallaxCardItem(
        title: 'Some Random Route 1',
        body: 'Place 1',
        background: Container(
          color: Colors.orange,
        )), */
    ParallaxCardItem(
        title: '',
        body: '',
        background: Container(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(),
                title: Text('data'),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Estudiantes abordo:   ',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  TextSpan(
                      text: '2/5',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.bold))
                ]),
              )
            ],
          ),
          color: Colors.redAccent,
        )),
    ParallaxCardItem(
        title: 'Some Random Route 3',
        body: 'Place 1',
        background: Container(
          color: Colors.blue,
        )),
  ];
}
