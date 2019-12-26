import 'package:antawaschool/pages/homePage/util/utilHome.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'customContainerHome.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example App',
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            body: Stack(
              children: <Widget>[
                buildMap(),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top + 16, 16, 0),
                    child: FloatingActionButton(
                      child: Icon(
                        FontAwesome.ellipsis_v,
                        color: mapsBlue,
                      ),
                      backgroundColor: Colors.white,
                      onPressed: () {
                        showBottomSheet(context);
                      },
                    ),
                  ),
                ),
                buildSheet(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildSheet() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.biggest.height;

        return SlidingSheet(
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
              height * 0.7,
              double.infinity,
            ],
            onSnap: (state, snap) {
              print('Snapped to $snap');
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
        //divider,
        //SizedBox(height: 32),
        /* Padding(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Traffic',
                style: titleStyle,
              ),
              SizedBox(height: 16),
              //buildChart(context),
            ],
          ),
        ), */
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

            //buildSteps(context),
          ],
        ),
        SizedBox(height: 32),
        divider,
        SizedBox(height: 32),
        /*  Icon(
          MdiIcons.githubCircle,
          color: Colors.grey.shade900,
          size: 48,
        ), */
        SizedBox(height: 16),
        /*   Align(
          alignment: Alignment.center,
          child: Text(
            'Pull request are welcome!',
            style: textStyle.copyWith(
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: Text(
            '(Stars too)',
            style: textStyle.copyWith(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ), */
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

  void showBottomSheet(BuildContext context) {
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
                  prefix0.ListTile(
                    leading: Icon(FontAwesome.address_card),
                    title: prefix0.Text('Perfil de usuario'),
                  ),
                  prefix0.Divider(),
                    prefix0.ListTile(
                    leading: Icon(FontAwesome.bell),
                    title: prefix0.Text('Notificaciones'),
                    trailing: prefix0.CircleAvatar(
                      backgroundColor: Colors.red,
                      child: prefix0.Text('2'),
                    )
                  ),
                  prefix0.Divider(),
                    prefix0.ListTile(
                    leading: Icon(FontAwesome.clipboard),
                    title: prefix0.Text('Novedades en el trayecto'),
                  ),
                  prefix0.Divider(),
                    prefix0.ListTile(
                    leading: Icon(FontAwesome.headphones),
                    title: prefix0.Text('Gestión de Quejas'),
                  ),
                  prefix0.Divider()
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

  Widget buildMap() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Image.asset(
            'assets/maps_screenshot.png',
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 56),
      ],
    );
  }
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
