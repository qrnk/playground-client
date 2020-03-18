
import 'package:flutter/widgets.dart';

class FadeInWidget extends StatefulWidget {
  FadeInWidget({
    @required this.child,
    this.delay = const Duration(milliseconds: 1),
    this.duration = const Duration(seconds: 1),
    Key key}) : super(key: key);

  final Widget child;
  final Duration delay;
  final Duration duration;

  @override
  _FadeInWidgetState createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget> {
  double opacityLevel = 0.0;

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  void initState() {

    Future.delayed(widget.delay, () {
      _changeOpacity();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacityLevel,
      duration: widget.duration,
      child: widget.child,
    );
  }
}