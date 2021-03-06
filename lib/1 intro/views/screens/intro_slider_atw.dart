import 'package:antawaschool/1%20intro/views/screens/permition_gps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class IntroPageAtw extends StatefulWidget {
  IntroPageAtw({
    Key key,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _IntroPageAtwState createState() => new _IntroPageAtwState();
}

class RadioGroup extends StatefulWidget {
  final List<String> titles;

  final ValueChanged<int> onIndexChanged;

  const RadioGroup({Key key, this.titles, this.onIndexChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _RadioGroupState();
  }
}

class _RadioGroupState extends State<RadioGroup> {
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < widget.titles.length; ++i) {
      list.add(((String title, int index) {
        return new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Radio<int>(
                value: index,
                groupValue: _index,
                onChanged: (int index) {
                  setState(() {
                    _index = index;
                    widget.onIndexChanged(_index);
                  });
                }),
            new Text(title)
          ],
        );
      })(widget.titles[i], i));
    }

    return new Wrap(
      children: list,
    );
  }
}

class _IntroPageAtwState extends State<IntroPageAtw> {
  //int _index = 1;

  double size = 20.0;
  double activeSize = 30.0;

  PageController controller;

  PageIndicatorLayout layout = PageIndicatorLayout.SLIDE;

  List<PageIndicatorLayout> layouts = PageIndicatorLayout.values;

  bool loop = false;

  @override
  void initState() {
    controller = new PageController();
    super.initState();
  }

  @override
  void didUpdateWidget(IntroPageAtw oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
                image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.colorBurn),
              image: AssetImage("assets/introImg/introAtw1.png"),
              fit: BoxFit.contain,
            )),
          ),
        ],
      ),
      Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
            image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2), BlendMode.colorBurn),
          image: AssetImage("assets/introImg/introAtw2.png"),
          fit: BoxFit.contain,
        )),
      ),
      Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
            image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2), BlendMode.colorBurn),
          image: AssetImage("assets/introImg/introAtw3.png"),
          fit: BoxFit.contain,
        )),
      ),
      Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
                image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.colorBurn),
              image: AssetImage("assets/introImg/introAtw4.png"),
              fit: BoxFit.contain,
            )),
          ),
          Column(
            children: <Widget>[
              Expanded(child: SizedBox()),
              Row(
                children: <Widget>[
                  Expanded(child: SizedBox()),
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
                            child: Text("INICIEMOS",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 18,
                                    letterSpacing: 1.0)),
                          ),
                          onTap: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (BuildContext context) {
                                return PermitionGpsUi();
                              },
                            ));
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ],
      ),
    ];
    return new Scaffold(
        body: new Column(
      children: <Widget>[
        Expanded(
            child: new Stack(
          children: <Widget>[
            loop
                ? new TransformerPageView.children(
                    children: children,
                    pageController: controller,
                  )
                : new PageView(
                    controller: controller,
                    children: children,
                  ),
            new Align(
              alignment: Alignment.bottomCenter,
              child: new Padding(
                padding: new EdgeInsets.only(bottom: 20.0),
                child: new PageIndicator(
                  layout: PageIndicatorLayout.DROP,
                  size: size,
                  activeSize: activeSize,
                  controller: controller,
                  space: 8.0,
                  count: 4,
                  dropHeight: 25,
                ),
              ),
            )
          ],
        ))
      ],
    ));
  }
}
