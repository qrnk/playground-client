import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class AboutScreen extends StatefulWidget {
  AboutScreen({Key key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  bool _isScreenTransiting = false;

  @override
  void initState() {
    Provider.of<Logger>(context, listen: false).d('AboutScreen.initState()');

    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isScreenTransiting = true;
      });
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Logger>(context, listen: false).d('AboutScreen.build()');

    return Scaffold(
        key: _globalKey,
        body: Builder(
          builder: (BuildContext context) {
            Provider.of<Logger>(context, listen: false).d('Scaffold context : ${Scaffold.of(context)}');
            return Container(
              color: Colors.blue,
              child: Stack(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: Stack(children: <Widget>[
                        SafeArea(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Visibility(
                              visible: _isScreenTransiting,
                              child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: FlatButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    setState(() {
                                      _isScreenTransiting = false;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(Icons.arrow_back, size: 24.0,),
                                ),
                              ),
                            )
                          ),
                        ),
                      ])
                  ),
                ],
              ),
            );
          },
        ));
  }
}
