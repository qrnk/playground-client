import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:qrank_playground/fade_in_widget.dart';
import 'package:qrank_playground/screen/about_screen.dart';
import 'package:qrank_playground/screen/showcase_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final List<String> _menu = ['Resources', 'License'];

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

    Logger logger = Provider.of<Logger>(context, listen: false);

    return Scaffold(
      key: _globalKey,
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: PopupMenuButton<String>(
                                  initialValue: _menu[0],
                                  icon: Icon(Icons.menu),
                                  onSelected: (String s) {
                                    if(s == _menu[1]) {
                                      showLicensePage(context: context, applicationName: 'QRANK PLAYGROUND', applicationVersion: '1.0.0',);
                                    }
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return _menu.map((String s) {
                                      return PopupMenuItem(
                                        child: Text(s),
                                        value: s,
                                      );
                                    }).toList();
                                  },
                                ),
                              )
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Spacer(),
                                OpenContainer(
                                  openElevation: 0.0,
                                  closedElevation: 0.0,
                                  transitionType: ContainerTransitionType.fadeThrough,
                                  openBuilder: (BuildContext context, VoidCallback _) {
                                    return Provider<Logger>(
                                      create: (BuildContext context) => logger,
                                      lazy: true,
                                      child: ShowcaseScreen()
                                    );
                                  },
                                  closedBuilder: (BuildContext _, VoidCallback openContainer) {
                                    return _FlatButton(
                                      openContainer: openContainer,
                                      child: Text('SHOWCASE'),
                                    );
                                  },
                                ),
                                Spacer(),
                                OpenContainer(
                                  openElevation: 0.0,
                                  closedElevation: 0.0,
                                  transitionType: ContainerTransitionType.fade,
                                  openBuilder: (BuildContext context, VoidCallback _) {
                                    return Provider<Logger>(
                                        create: (BuildContext context) => logger,
                                        lazy: true,
                                        child: AboutScreen()
                                    );
                                  },
                                  closedBuilder: (BuildContext _, VoidCallback openContainer) {
                                    return _FlatButton(
                                      openContainer: openContainer,
                                      child: Text('ABOUT'),
                                    );
                                  },
                                ),
                                Spacer(),
                              ],
                            ),
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

  Route _createShowcaseScreenRoute(BuildContext context){
    Provider.of<Logger>(context, listen: false).d('MainScreen._createShowcaseScreenRoute()');

    Logger logger = Provider.of<Logger>(context, listen: false);

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Provider<Logger>(
        create: (BuildContext context) => logger,
        child: ShowcaseScreen(),
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

class _FlatButton extends StatelessWidget {
  const _FlatButton({
    this.openContainer,
    this.child,
  });

  final VoidCallback openContainer;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: BorderSide(color: Colors.black)
      ),
      child: this.child,
      onPressed: this.openContainer,
    );
  }
}