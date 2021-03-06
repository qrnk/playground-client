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

  ScrollController _scrollController = ScrollController();

  bool _isScreenTransiting = false;
  bool _isVisibleTitle = false;

  @override
  void initState() {
    Provider.of<Logger>(context, listen: false).d('AboutScreen.initState()');

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isScreenTransiting = true;
      });
    });
    
    _scrollController.addListener(() {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentPosition = _scrollController.position.pixels;
      print('maxScrollExtent : $maxScrollExtent');
      print('currentPosition : $currentPosition');
      if (maxScrollExtent > 0 && 105.0 <= currentPosition) {
        setState(() => _isVisibleTitle = true);
      } else {
        setState(() => _isVisibleTitle = false);
      }
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
                                    child: Image.asset('assets/image/about_title.png',),
                                  )
                              ),
                            ),
                            SizedBox(height: 50,),
                            Container(
                              width: double.infinity,
                              height: 1500,
                              color: Colors.white,
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
                        Visibility(
                          visible: _isVisibleTitle,
                          child: SafeArea(
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: SizedBox(
                                    height: 22.0,
                                    child: Image.asset('assets/image/about_title.png',),
                                  ),
                                )
                            ),
                          ),
                        )
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
