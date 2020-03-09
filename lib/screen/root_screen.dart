import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:qrank_playground/bloc.dart';
import 'package:qrank_playground/flavor.dart';
import 'package:qrank_playground/screen/main_screen.dart';
import 'package:qrank_playground/util/color/primary_black.dart';

class RootScreen extends StatelessWidget {
  RootScreen({this.flavor, Key key}) : super(key: key);

  final Flavor flavor;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MaterialApp(
      title: 'Qrank Playground',
      theme: ThemeData(
        primarySwatch: primaryBlack,
        backgroundColor: Colors.white,
      ),
      home: FlavorProvider(
        flavor: this.flavor,
        child: Provider<Bloc>(
          create: (_) => Bloc(),
          lazy: false,
          child: MainScreen(),
          dispose: (context, value) => value.dispose(),
        ),
      ),
    );
  }
}