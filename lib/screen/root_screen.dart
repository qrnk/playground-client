import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:qrank_playground/bloc/bloc.dart';
import 'package:qrank_playground/screen/main_screen.dart';
import 'package:qrank_playground/util/color/primary_black.dart';
import 'package:qrank_playground/util/flavor.dart';

class RootScreen extends StatelessWidget {
  RootScreen({this.flavor, Key key}) : super(key: key);

  final Flavor flavor;

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MaterialApp(
      title: 'Qrank Playground',
      theme: ThemeData(
        primarySwatch: primaryBlack,
        backgroundColor: Colors.white,
      ),
      home: FlavorProvider(
        flavor: this.flavor,
        child: MultiProvider(
          providers: [
            Provider<Bloc>(
              create: (_) => Bloc(),
              lazy: false,
              dispose: (_, value) => value.dispose(),
            ),
            Provider<Logger>(
              create: (_) => Logger(
                filter: null,
                printer: PrettyPrinter(
                  methodCount: 5,
                  errorMethodCount: 8,
                  lineLength: 100,
                  colors: true,
                  printEmojis: true,
                  printTime: true,
                ),
                output: null,
              ),
              lazy: false,
              dispose: (_, value) => value.close(),
            ),
          ],
          child: MainScreen(),
        )
      ),
    );

    return MaterialApp(
      title: 'Qrank Playground',
      theme: ThemeData(
        primarySwatch: primaryBlack,
        backgroundColor: Colors.white,
      ),
      home: Provider<Logger>(
        create: (_) => Logger(
          filter: null,
          printer: PrettyPrinter(
              methodCount: 2,
              // number of method calls to be displayed
              errorMethodCount: 8,
              // number of method calls if stacktrace is provided
              lineLength: 120,
              // width of the output
              colors: true,
              // Colorful log messages
              printEmojis: true,
              // Print an emoji for each log message
              printTime: false // Should each log print contain a timestamp
              ),
          output: null,
        ),
        lazy: false,
        child: FlavorProvider(
          flavor: this.flavor,
          child: Provider<Bloc>(
            create: (_) => Bloc(),
            lazy: false,
            child: MainScreen(),
            dispose: (context, value) => value.dispose(),
          ),
        ),
        dispose: (context, value) => value.close(),
      ),
    );
  }
}
