import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:qrank_playground/fade_in_widget.dart';
import 'package:qrank_playground/screen/about_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  String _appName = '';
  String _packageName = '';
  String _version = '';
  String _buildNumber = '';

  @override
  void initState() {
    Provider.of<Logger>(context, listen: false).d('MainScreen.initState()');

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        _appName = packageInfo.appName;
        _packageName = packageInfo.packageName;
        _version = packageInfo.version;
        _buildNumber = packageInfo.buildNumber;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Logger>(context, listen: false).d('MainScreen.build()');

    return Scaffold(
      key: _globalKey,
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: FadeInWidget(
                          delay: const Duration(milliseconds: 1000),
                          duration: const Duration(milliseconds: 1500),
                          child: Image.asset('assets/image/main_logo.png', fit: BoxFit.fitWidth,),
                        ),
                      ),
                      SafeArea(
                        child: Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: FlatButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {

                                },
                                child: Icon(Icons.menu, size: 24.0,),
                              ),
                            )
                        ),
                      ),
                      SafeArea(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Spacer(),
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    side: BorderSide(color: Colors.black)
                                ),
                                child: Text('SHOWCASE'),
                                onPressed: () {

                                },
                              ),
                              Spacer(),
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    side: BorderSide(color: Colors.black)
                                ),
                                child: Text('ABOUT QRANK'),
                                onPressed: () => Navigator.of(context).push(_createAboutScreenRoute(context)),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      )
    );
  }

  Route _createAboutScreenRoute(BuildContext context){
    Provider.of<Logger>(context, listen: false).d('MainScreen._createAboutScreenRoute()');

    Logger logger = Provider.of<Logger>(context, listen: false);

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Provider<Logger>(
        create: (BuildContext context) => logger,
        child: AboutScreen(),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end   = Offset.zero;
        var curve = Curves.easeInOutExpo;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 1500),
    );
  }
}
