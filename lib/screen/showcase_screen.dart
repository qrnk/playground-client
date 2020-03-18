import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ShowcaseScreen extends StatefulWidget {
  ShowcaseScreen({Key key}) : super(key: key);

  @override
  _ShowcaseScreenState createState() => _ShowcaseScreenState();
}

class _ShowcaseScreenState extends State<ShowcaseScreen> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  ScrollController _scrollController = ScrollController();

  bool _isScreenTransiting = false;

  @override
  void initState() {
    Provider.of<Logger>(context, listen: false).d('ShowcaseScreen.initState()');

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isScreenTransiting = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Logger>(context, listen: false).d('ShowcaseScreen.build()');

    return Scaffold(
        key: _globalKey,
        body: Builder(
          builder: (BuildContext context) {
            return Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  SafeArea(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(18, 60, 0, 20),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: FractionallySizedBox(
                                    widthFactor: 0.5,
                                    child: Image.asset(
                                      'assets/image/showcase_title.png',
                                    ),
                                  )
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 150,
                              color: Colors.red,
                            ),
                            Container(
                              width: double.infinity,
                              height: 150,
                              color: Colors.orange,
                            ),
                            Container(
                              width: double.infinity,
                              height: 150,
                              color: Colors.yellow,
                            ),
                            Container(
                              width: double.infinity,
                              height: 150,
                              color: Colors.green,
                            ),
                            Container(
                              width: double.infinity,
                              height: 150,
                              color: Colors.blue,
                            ),
                            Container(
                              width: double.infinity,
                              height: 150,
                              color: Colors.purple,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ]
                      )
                  ),
                ],
              ),
            );
          },
        ));
  }
}
